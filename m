Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130868AbRBTXFx>; Tue, 20 Feb 2001 18:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129475AbRBTXFn>; Tue, 20 Feb 2001 18:05:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59915 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130887AbRBTXF1>;
	Tue, 20 Feb 2001 18:05:27 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102202302.f1KN2B423460@flint.arm.linux.org.uk>
Subject: Re: [PATCH] make nfsroot accept server addresses from BOOTP root
To: bcrl@redhat.com (Ben LaHaise)
Date: Tue, 20 Feb 2001 23:02:10 +0000 (GMT)
Cc: trini@kernel.crashing.org (Tom Rini), linux-kernel@vger.kernel.org,
        alan@redhat.com
In-Reply-To: <Pine.LNX.4.30.0102201248290.1614-100000@today.toronto.redhat.com> from "Ben LaHaise" at Feb 20, 2001 01:12:28 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben LaHaise writes:
> Yeah, that's the problem I was trying to work around, mostly because the
> docs on dhcpd are sufficiently vague and obscure.  Personally, I don't
> actually need tftp support, so I've just configured the system to now
> point at the NFS server.  For anyone who cares, the last patch was wrong,
> this one is right.

This is the dhcp entry for a host that I use to tftp a kernel from a 
different machine to that running dhcpd:

                host tasslehoff
                {
                        hardware ethernet       00:10:57:00:03:EC;
                        fixed-address           tasslehoff;
                        next-server             raistlin;
                        filename                "/usr/src/k/tasslehoff";
                }

The booting host is called "tasslehoff".  The tftp server host is called
"raistlin", and the dhcp server is called "flint".

According to Tom, this should also cause Linux to nfs mount from the
"next-server" address, and it is fair that this is not documented by
the dhcp man pages since it appears to be a Linux Kernel quirk.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


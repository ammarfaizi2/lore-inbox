Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130999AbRBTX2L>; Tue, 20 Feb 2001 18:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131018AbRBTX2A>; Tue, 20 Feb 2001 18:28:00 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:18926
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S130999AbRBTX1u>; Tue, 20 Feb 2001 18:27:50 -0500
Date: Tue, 20 Feb 2001 16:25:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        alan@redhat.com
Subject: Re: [PATCH] make nfsroot accept server addresses from BOOTP root
Message-ID: <20010220162520.D5639@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.30.0102201248290.1614-100000@today.toronto.redhat.com> <200102202302.f1KN2B423460@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200102202302.f1KN2B423460@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Feb 20, 2001 at 11:02:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 11:02:10PM +0000, Russell King wrote:
> Ben LaHaise writes:
> > Yeah, that's the problem I was trying to work around, mostly because the
> > docs on dhcpd are sufficiently vague and obscure.  Personally, I don't
> > actually need tftp support, so I've just configured the system to now
> > point at the NFS server.  For anyone who cares, the last patch was wrong,
> > this one is right.
> 
> This is the dhcp entry for a host that I use to tftp a kernel from a 
> different machine to that running dhcpd:
> 
>                 host tasslehoff
>                 {
>                         hardware ethernet       00:10:57:00:03:EC;
>                         fixed-address           tasslehoff;
>                         next-server             raistlin;
>                         filename                "/usr/src/k/tasslehoff";
>                 }
> 
> The booting host is called "tasslehoff".  The tftp server host is called
> "raistlin", and the dhcp server is called "flint".
> 
> According to Tom, this should also cause Linux to nfs mount from the
> "next-server" address, and it is fair that this is not documented by
> the dhcp man pages since it appears to be a Linux Kernel quirk.

Well, assuming next-server gets translated into TFTP server by the
dhcp-doing-bootp bit, yes.  I'm using that right now to bootp on
one box and NFS off another.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

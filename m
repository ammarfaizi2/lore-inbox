Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311811AbSCNVvK>; Thu, 14 Mar 2002 16:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311807AbSCNVvA>; Thu, 14 Mar 2002 16:51:00 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:31619 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S311811AbSCNVur>; Thu, 14 Mar 2002 16:50:47 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200203142150.g2ELoJr27197@devserv.devel.redhat.com>
Subject: Re: linux 2.2.21 pre3, pre4 and rc1 problems. (fwd)
To: bonganilinux@mweb.co.za (Bongani)
Date: Thu, 14 Mar 2002 16:50:19 -0500 (EST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mikesw@ns1.whiterose.net (M Sweger),
        linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <1016142855.14838.5.camel@localhost.localdomain> from "Bongani" at Mar 14, 2002 11:53:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> on 2.4.19-pre3 and 2.4.19-pre3-aa1. I put a couple of printk's to see
> where the problem was (arch/i386/bluesmoke.c), but after rebooting it
> did not show up. I just vompiled 2.4.19-pre3-aa and 2.4.19-pre3 +
> preempt, I would like o have it solved before I reboot though

The intel cpus get deeply upset if you write to bank zero of the error
reporting registers used by MCE exceptions. The AMD ones want you to do so
and the change that went in was tested on AMD boxes but not Intel.

Revert the bluesmoke.c change and all should be well

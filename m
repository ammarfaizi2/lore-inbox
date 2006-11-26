Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935336AbWKZLFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935336AbWKZLFF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 06:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935338AbWKZLFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 06:05:05 -0500
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:35272
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S935336AbWKZLFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 06:05:03 -0500
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'David Brownell'" <david-b@pacbell.net>,
       "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>
Cc: <akpm@osdl.org>, "'Alessandro Zummo'" <alessandro.zummo@towertech.it>,
       <linuxppc-dev@ozlabs.org>, <lethal@linux-sh.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       <ralf@linux-mips.org>, "'Andi Kleen'" <ak@muc.de>, <paulus@samba.org>,
       <rmk@arm.linux.org.uk>, <davem@davemloft.net>, <kkojima@rr.iij4u.or.jp>
Subject: RE: NTP time sync
Date: Sun, 26 Nov 2006 12:04:54 +0100
Message-ID: <009a01c7114a$b429f850$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AccQ6KFreZatZITbSra+1apY1bj2oQAYTVhA
In-Reply-To: <200611251522.19900.david-b@pacbell.net>
X-OriginalArrivalTime: 26 Nov 2006 11:04:57.0979 (UTC) FILETIME=[B5DD74B0:01C7114A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: 
> linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org 
> [mailto:linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozl
> abs.org] On Behalf Of David Brownell
> Sent: den 26 november 2006 00:22
> To: Benjamin Herrenschmidt
> Cc: akpm@osdl.org; Alessandro Zummo; linuxppc-dev@ozlabs.org; 
> lethal@linux-sh.org; Linux Kernel Mailing List; 
> ralf@linux-mips.org; Andi Kleen; paulus@samba.org; 
> rmk@arm.linux.org.uk; davem@davemloft.net; kkojima@rr.iij4u.or.jp
> Subject: Re: NTP time sync
> 
> On Thursday 23 November 2006 3:00 am, Benjamin Herrenschmidt wrote:
> > 
> > Couldn't we have a transition period by making the kernel 
> not rely on
> > interrupts ? if the NTP irq code just triggers a work 
> queue, then all of
> > a sudden, all of the RTC drivers can be used and the 
> latency is small.
> > That might well be a good enough solution and is very simple.
> 
> Good point.  Of course, one issue is that the NTP sync code all
> seems to be platform-specific right now ... just like the code
> to set the system time from an RTC at boot (except for the new
> RTC framework stuff) and after resume.
> 
> - Dave

Looking at rtc-dev.c I don't see a MARJOR number assigned to /dev/rtcN. Seems like
it is dynamically allocated to whatever major number that is free.
Is that the way it is supposed to be? How do I create a static /dev/rtcN in my /dev
directory if the major number isn't fixed?
Maybe I am just missing something, feel free to correct me :)

 Jocke


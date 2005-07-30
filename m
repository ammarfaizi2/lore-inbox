Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbVG3Eic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbVG3Eic (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 00:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbVG3Eic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 00:38:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1705 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262933AbVG3Eib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 00:38:31 -0400
Date: Fri, 29 Jul 2005 21:37:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: mkrufky@m1k.net
Cc: frank.peters@comcast.net, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
Message-Id: <20050729213724.01c61c26.akpm@osdl.org>
In-Reply-To: <42EAF885.40008@m1k.net>
References: <20050624113404.198d254c.frank.peters@comcast.net>
	<42BC306A.1030904@m1k.net>
	<20050624125957.238204a4.frank.peters@comcast.net>
	<42BC3EFE.5090302@m1k.net>
	<20050728222838.64517cc9.akpm@osdl.org>
	<42E9C245.6050205@m1k.net>
	<20050728225433.6dbfecbe.akpm@osdl.org>
	<42EAF885.40008@m1k.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky <mkrufky@m1k.net> wrote:
>
> Andrew Morton wrote:
> 
> >Michael Krufky <mkrufky@m1k.net> wrote:
> >  
> >
> >> Sadly, I must report that yes, the problem still intermittently occurs 
> >> in 2.6.13-rc4 :-(  I'm the one that tested on the Shuttle FT61 
> >> Motherboard.  Never has a problem in windows and never in 2.6.11 and 
> >> earlier.
> >>
> >> I first noticed this problem sometime during 2.6.12-rc series.
> >>    
> >>
> >
> >Sigh.  I think it would help if you could generate a new report, please.
> >
> >We need a super-easy way for people to do bisection searching.
> >  
> >
> I dug up the original email that I sent to LKML...
> 
> Michael Krufky wrote (5/26/2005 10:16 PM):
> 
> > In 2.6.12-rc5-mm1, I can't use my psaux mouse, but it worked perfectly 
> > fine in both 2.6.12-rc5 and in 2.6.12-rc4-mm2.
> >
> > In 2.6.12-rc5-mm1 , dmesg says:
> >
> > PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> > Failed to disable AUX port, but continuing anyway... Is this a SiS?
> > If AUX port is really absent please use the 'i8042.noaux' option.
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> >
> > This is what dmesg says in both 2.6.12-rc4-mm2 and 2.6.12-rc5 :
> >
> > PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> >
> > I am using a Shuttle FT61 motherboard.  Is there any more information 
> > necessary to debug this?
> >

The diff between 2.6.12-rc4-mm2 and 2.6.12-rc5-mm1 is enormous, but there
aren't any significant input driver changes there:
http://www.zip.com.au/~akpm/linux/patches/stuff/diffstat-2.6.12-rc4-mm2-2.6.12-rc5-mm1

Similarly, the 2.6.12-rc5-mm1 diff is large, but there aren't input driver
changes:
http://www.zip.com.au/~akpm/linux/patches/stuff/diffstat-2.6.12-rc5-mm1

So I dunno, sorry.  Brute-force it with a git bisection search, perhaps?

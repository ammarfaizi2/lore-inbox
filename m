Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSDECKl>; Thu, 4 Apr 2002 21:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311239AbSDECKb>; Thu, 4 Apr 2002 21:10:31 -0500
Received: from randall.mail.atl.earthlink.net ([207.69.200.237]:26118 "EHLO
	randall.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id <S311244AbSDECKV>; Thu, 4 Apr 2002 21:10:21 -0500
Date: Thu, 04 Apr 2002 21:10:04 -0500
From: <joeja@mindspring.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Reply-To: joeja@mindspring.com
Subject: Re: Re: faster boots?
Message-ID: <Springmail.0994.1017972604.0.67144600@webmail.atl.earthlink.net>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Think pre init scripts....

no apache was install on this machine, no iptables scripts, etc.

I'm actually talking about the time from where Linux spits out all this crap about probing irq's, ide drive found with dma etc.  That kind of stuff.  

I'm not sure if there is an issue because I use the Linux framebuffer and all those printk() are taking to much time to print? To much scrolling or  redraw?  Is there any way to turn all that off (without commenting that code out)?

It would be nice to test if that is an issue.  FreeBSD does not seem to spit out all that crap.  It is more like 1 or 2 lines a device not this 30 lines of irq mapping and 4 lines of thank you to so and so and foo for the code of blah....   

If the video card is old and slow, could all this extra stuff that scrolls up the screen be causing the issue?  If so is there a way of turning this off?    


Joe

On Fri, 5 Apr 2002 01:21:17 +0100 (BST) Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>     Is there some way of making the linux kernel boot faster?  

#1: Start less crap at boot time. Obvious but thats frequently most of
    the issue.

For Red Hat if your hardware set up is constant then rpm -e kudzu will do
no harm and avoid the grovelling through the box looking for new toys.

Longer term swsuspend means you can bang alt-sysrq-Z and suspend to disk
without BIOS support

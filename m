Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWGJOSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWGJOSM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWGJOSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:18:12 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:17027 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030408AbWGJOSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:18:10 -0400
Date: Mon, 10 Jul 2006 16:17:41 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clean up old names in tty code to current names
In-Reply-To: <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0607101616090.5071@yvahk01.tjqt.qr>
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com> 
 <1152524657.27368.108.camel@localhost.localdomain> 
 <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com> 
 <1152537049.27368.119.camel@localhost.localdomain> 
 <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com> 
 <1152539034.27368.124.camel@localhost.localdomain>
 <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Before the change /proc/tty/drivers shows this:
>
> [jonsmirl@jonsmirl ~]$ cat /proc/tty/drivers
> /dev/tty             /dev/tty        5       0 system:/dev/tty
> /dev/console         /dev/console    5       1 system:console
> /dev/ptmx            /dev/ptmx       5       2 system
> /dev/vc/0            /dev/vc/0       4       0 system:vtmaster
> serial               /dev/ttyS       4 64-67 serial
> pty_slave            /dev/pts      136 0-1048575 pty:slave
> pty_master           /dev/ptm      128 0-1048575 pty:master
> unknown              /dev/tty        4 1-63 console
>

My word here too :)

I doubt that userspace can do something useful with the "/dev/vc/0" 
line when there is no devfs around at all.

Like below.

> Nothing in that patch has anything to do with udev support. It is just
> trying to make things match my current devices. When we got rid of
> devfs /dev/vc/0 became /dev/tty0.


Jan Engelhardt
-- 

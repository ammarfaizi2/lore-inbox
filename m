Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283714AbRLWFqs>; Sun, 23 Dec 2001 00:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283720AbRLWFqh>; Sun, 23 Dec 2001 00:46:37 -0500
Received: from www.transvirtual.com ([206.14.214.140]:23310 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S283714AbRLWFqc>; Sun, 23 Dec 2001 00:46:32 -0500
Date: Sat, 22 Dec 2001 21:45:56 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Ilguiz Latypov <ilatypov@superbt.com>
cc: linux-kernel@vger.kernel.org, sjh@wibble.net
Subject: Re: pc speaker cant be accessed with no video card in computer
In-Reply-To: <3C2259E2.4070504@superbt.com>
Message-ID: <Pine.LNX.4.10.10112222143400.30838-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Rather than porting it to Linux I chose a simple option of copying
> the ioctl PC speaker code into a skeleton misc character device
> driver.  As a result I can issue ioctl "beep" calls against my
> /dev/pcspeaker (character device with major number 10, minor number
> 240).  E.g., replacing "/dev/console" with "/dev/pcspeaker" in
> PCMCIA cardmgr.c will revive its sound effects.

Ug. I have thought about this problem as well. I plan to make it a
/dev/input driver. Especially since I plan to migrate the VT code over 
to input api. This will allow use to the speaker with or without the
VT tty system.



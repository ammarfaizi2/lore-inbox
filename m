Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285134AbRLVAMH>; Fri, 21 Dec 2001 19:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285280AbRLVALs>; Fri, 21 Dec 2001 19:11:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43270 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285134AbRLVAL2>; Fri, 21 Dec 2001 19:11:28 -0500
Subject: Re: =?iso-8859-1?Q?Asynchronous_Video_Console_f=FCr_Linux=3F?=
To: pavel@suse.cz (Pavel Machek)
Date: Sat, 22 Dec 2001 00:21:32 +0000 (GMT)
Cc: fm3@os.inf.tu-dresden.de (Frank Mehnert), linux-kernel@vger.kernel.org
In-Reply-To: <20011218010300.B37@toy.ucw.cz> from "Pavel Machek" at Dec 18, 2001 01:03:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HZuu-00025K-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > are there exist any projects for connecting video consoles to the Linux
> > kernel asynchronous? We would like to write a Linux video console for a
> > (comparatively) slow device which is able to run simple console 
> > applications upto the fbdev X-server.
> > 
> > Please cc your answer to me.
> 
> 	I do not know about any such project and yes it would be nice.
> 
> Its bad to see find / limited by vesafb speed...

There is no fundamental reason you cannot do this. For the kernel side the
console driver in text mode already gives you the 80x25 + attributes image
that you can use to do asynchronous video updates however your hardware
works.

XFree86 4.x has a shadowfb driver layer which does precisely what you need
for an asynchronous server engine. In fact for a real life example of 
XFree86 driving "asynchronous" hardware look at the XFree86 VNC drivers.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTAWJ0l>; Thu, 23 Jan 2003 04:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbTAWJ0l>; Thu, 23 Jan 2003 04:26:41 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:45068 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262821AbTAWJ0k>; Thu, 23 Jan 2003 04:26:40 -0500
Message-Id: <200301230927.h0N9RHs22240@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Sam Gendler <SGendler@s8.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: completely undiagnosable (for me) kernel boot problem
Date: Thu, 23 Jan 2003 11:26:23 +0200
X-Mailer: KMail [version 1.3.2]
References: <8D587D949A61D411AFE300D0B74D75D7048C9F13@server.s8.com>
In-Reply-To: <8D587D949A61D411AFE300D0B74D75D7048C9F13@server.s8.com>
Cc: DragonK <dragon_krome@yahoo.com>, "W. Michael Petullo" <mike@flyn.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 January 2003 06:20, Sam Gendler wrote:
> the main one) fails.  It successfully uncompresses vmlinuz and
> initrd.img, then clears the screen and displays the message
> "Uncompressing Linux... Ok, booting the kernel." and leaves a
> blinking cursor two lines below.  Nothing ever happens subsequent to
> that.

Heh... you'll have to mess up with boot code. CCed to
DragonK <dragon_krome@yahoo.com> (he had similar 'no boot'
horror story, and was able to diagnose it).

> was complaining about a 2.88MB boot image.  Also, the same symptoms
> occur whether I boot from the net or the CDR/DVD drive, so I don't
> think it is the device.  I don't know how to go about finding out
> what is hanging the system, and I don't have a system available to me
> on which I can comple a custom kernel.  This is the only machine I
> have, and it now has nothing but freeDOS on it.

Thats strange. How did you managed to try network boot without
a second system available to you? Did you tried to copy kernel
to DOS partition and load it with loadlin or linld?

http://www.imtp.ilyichevsk.odessa.ua/linux/vda/linld/

A long time ago I said to "W. Michael Petullo" <mike@flyn.org>:
>> Since the kernel does not even peep an oops message, I'm not sure where
>> to start debugging.  Is anyone else having similar problems?
>
>If noone will send you a suggestion, I'm afraid you'll have to put debug 
>stores to video memory all over startup code.
>
>C example (assumes 1:1 address mapping)
>
>char *p = (char*)0x000b8000;  // color VGA text framebuffer
>p[(col+row*80)*2] = 'Z';      // character
>p[(col+row*80)*2+1] = 0x0f;   // attr (0x0f=white on black)
>
>You may try this first with booting kernel to be sure it works.
>Good luck.
--
vda

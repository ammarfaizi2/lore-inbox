Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751834AbWJMT4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbWJMT4W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWJMT4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:56:22 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:49049 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id S1751834AbWJMT4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:56:21 -0400
Date: Fri, 13 Oct 2006 12:56:20 -0700 (PDT)
From: alan <alan@clueserver.org>
X-X-Sender: alan@blackbox.fnordora.org
To: Pavel Machek <pavel@ucw.cz>
cc: Thomas Tuttle <thinkinginbinary+lkml@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dell Inspiron e1405 hangs on lid close in 64-bit mode
In-Reply-To: <20061013145415.GC5512@ucw.cz>
Message-ID: <Pine.LNX.4.64.0610131251590.6997@blackbox.fnordora.org>
References: <e4cb19870610111010p3da2022bud047163417560033@mail.gmail.com>
 <20061013145415.GC5512@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, Pavel Machek wrote:

> Hi!
>
>> I have a Dell Inspiron e1405 laptop with a Core 2 Duo
>> processor.
>> Under every 64-bit kernel I have tried yet, it hangs
>> when I close the
>> lid (or, I would assume, do anything else that activates
>> System
>> Management Mode).  It works fine under 32-bit mode;
>> closing the lid
>> turns the LCD off using DPMS.
>>
>> I understand that this might be entirely outside the
>> control of the
>> kernel developers, but I would of course love to be able
>> to use this
>> laptop in 64-bit mode.  What information would be needed
>> to fix it,
>> and/or how would I go about debugging it?  I've tried
>> turning the
>
> Modify 64bit kernel entry point to do something trivial (flashing
> character on vga text mode?) then see if lid close breaks it. If so,
> blame smm, and force vendor to fix it.

I have the same problem, kinda sorta.  Closing the lid causes it to go to 
sleep in the context that a vetrinarian uses.  ("It was put to sleep.")

Wakeup just spins the drive. And spins. And spins. And spins.

The machine is also a 64bit.  HP zv5200z AMD64 3700+.

According to a friend, 32bit suspend works in 32 bit but not 64bit.

-- 
"Oh, Joel Miller, you've just found the marble in the oatmeal. You're a
lucky, lucky, lucky little boy. 'Cause you know why? You get to drink
from... the FIRE HOOOOOSE!"
         - The Stanley Spudoski guide to mailing list administration

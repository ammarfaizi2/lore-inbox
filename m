Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbTBTNni>; Thu, 20 Feb 2003 08:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbTBTNni>; Thu, 20 Feb 2003 08:43:38 -0500
Received: from h-64-105-35-136.SNVACAID.covad.net ([64.105.35.136]:34207 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265320AbTBTNnh>; Thu, 20 Feb 2003 08:43:37 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 20 Feb 2003 05:51:50 -0800
Message-Id: <200302201351.FAA08649@baldur.yggdrasil.com>
To: zippel@linux-m68k.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, wa@almesberger.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Roman Zippel wrote:
>On Thu, 20 Feb 2003, Adam J. Richter wrote:

>> 	The ability to remove a module is generally independent of
>> whether or not there is any hardware present at that moment for which
>> the module supplies a driver.  Instead, the determining issue is
>> whether there are file descriptors open for that driver.

>I don't understand, what you're trying to say.
>File descriptors are not the only way to access a driver and the ability 
>to remove a module is only dependent on the number of references to this 
>module.

	You're right.  My second sentence was an oversimplification.
I should have said "software references" rather than file descriptors
to include things like "ifconfig eth0 up" creating a reference,
mounting a block device creating a refernece, etc.  (Perhaps I
should have stated only my first sentence and stopped there.)

	Anyhow, my point is that removing a piece of hardware
does not require that the corresponding module be unloaded
immediately.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

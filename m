Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277798AbRKHUFn>; Thu, 8 Nov 2001 15:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277942AbRKHUFe>; Thu, 8 Nov 2001 15:05:34 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:27922 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S277798AbRKHUFW>; Thu, 8 Nov 2001 15:05:22 -0500
Message-Id: <200111082005.fA8K5GY63302@aslan.scsiguy.com>
To: John Gluck <jgluckca@home.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question: Adaptec AIC7xxx support 
In-Reply-To: Your message of "Thu, 08 Nov 2001 12:52:57 EST."
             <3BEAC679.A80ACBAC@home.com> 
Date: Thu, 08 Nov 2001 13:05:16 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi
>
>I configuring the kernel, there is a option "Build adapter firmware with
>Kernel build".

There should be.  This comment has been in my distributed patches for
Configure.help for some time:

Build Adapter Firmware with Kernel Build
CONFIG_AIC7XXX_BUILD_FIRMWARE
  This option should only be enabled if you are modifying the
  firmware source to the aic7xxx driver and wish to have the
  generated firmware include files updated during a normal
  kernel build.  The assembler for the firmware requires
  lex and yacc or their equivalents, as well as the db v1
  library.  You may have to install additional packages or
  modify the assembler make file or the files it includes
  if your build environment is different than that of the
  author.

I guess it didn't make it in with the rest of the 6.2.4 driver.

>There is no help for this. It's obvious that it build
>firmware but is it installed in the adapter automagically ???

Firmware is always downloaded by the driver during card initialization.
As noted above, only someone working on the firmware should need to
recompile it.

>I also wonder why the reset delay is 15000 Msec. It used to be 5000
>Msec. I've usually set it to that without nasty results. I just wonder
>what the reasoning is behind such a long delay.

Some devices require it.  The default should be long enough to accomodate
all configurations.  If you can use something shorter, feel free to
reconfig your kernel that way.

--
Justin

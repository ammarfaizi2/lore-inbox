Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSIDUPG>; Wed, 4 Sep 2002 16:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSIDUPF>; Wed, 4 Sep 2002 16:15:05 -0400
Received: from [64.6.248.2] ([64.6.248.2]:30090 "EHLO greenie.frogspace.net")
	by vger.kernel.org with ESMTP id <S315198AbSIDUPF>;
	Wed, 4 Sep 2002 16:15:05 -0400
Date: Wed, 4 Sep 2002 13:19:33 -0700 (PDT)
From: Peter <cogweb@cogweb.net>
X-X-Sender: cogweb@greenie.frogspace.net
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-ac4 build problem
Message-ID: <Pine.LNX.4.44.0209041311250.16204-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg -

Agree -- I couldn't find it either. This may be a makefile error:

linux-2.4.19-ac4 # grep usbdrv.o * -r
Makefile:DRIVERS-$(CONFIG_USB) += drivers/usb/usbdrv.o
drivers/usb/Makefile:O_TARGET   := usbdrv.o

The kernel compiled fine when I defined Input core support in the kernel
rather than as modules (cf. below). And USB is working great -- keyboard, 
cordless mouse, webcam, scanner, printer, the works.

Cheers,
Peter


Does not compile:

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_EVDEV is not set

Compiles:

#
# Input core support
#
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y

I don't know if the last two lines matter.


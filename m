Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268892AbTBSFgW>; Wed, 19 Feb 2003 00:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268893AbTBSFgW>; Wed, 19 Feb 2003 00:36:22 -0500
Received: from asclepius.uwa.edu.au ([130.95.128.56]:32948 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id <S268892AbTBSFgV>; Wed, 19 Feb 2003 00:36:21 -0500
Date: Wed, 19 Feb 2003 13:46:17 +0800 (WST)
From: Paul Marinceu <elixxir@ucc.gu.uwa.edu.au>
To: linux-kernel@vger.kernel.org
Cc: kai@tp1.ruhr-uni-bochum.de
Subject: Loading 3rd-party module in 2.5.59
Message-ID: <Pine.LNX.4.21.0302191322500.13555-100000@mussel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai,

I'm currently helping port a "half open source, half closed
source" winmodem driver from 2.4 to 2.5.59 (at www.linmodems.org)

The problem I'm facing is that since the kernel build process and the
module infrastructure was changed the driver refuses to load.

I'm currently building the open source part using a makefile with
something like:

obj-m := modem.o

This then needs to be linked with the closed source object file, like so:

ld -m elf_i386 -r -o modem_module.o modem.o closed_src.o

Next, I attempt to load modem_module.o with insmod (having installed
Rusty's module-init-tools) and I get '-1: invalid module format'

If I try to load modem.o by itself I get 'unresolved symbols' messages but
that's because it needs the closed source part...(but it seems to at least
be in the right format)

What am I doing wrong? Also what is the correct way to load a closed
source object file in 2.5.59?

Do I need to get the closed source manufacturer to compile me a new module
under 2.5 for it to be the correct format?

Hope you can help (and please cc me a response if you can)

--
 Paul Marinceu
 http://elixxir.ucc.asn.au



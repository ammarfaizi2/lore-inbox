Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265420AbUAUN5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 08:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUAUN5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 08:57:39 -0500
Received: from centershock.net ([217.160.219.55]:15064 "EHLO
	bastet.centershock.net") by vger.kernel.org with ESMTP
	id S265420AbUAUN5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 08:57:37 -0500
From: Florian Lindner <mailinglists@xgm.de>
To: linux-kernel@vger.kernel.org
Subject: Problem with framebuffer resolution setting
Date: Wed, 21 Jan 2004 15:01:40 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401211501.40794.mailinglists@xgm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
sorry for bothering you with this (probably) rather simple question. but I've 
already asked two newsgroups, none had the answer.
I just try to compile kernel 2.6.1. Everything works perfect, except the
framebuffer support (I want to higher resolution for the console).
I've support for frame buffer devices (FB) and nVidia Riva support
(FB_RIVA) as well as Video mode selection support (VIDEO_SELECT) and
Framebuffer Console support (FRAMEBUFFER_CONSOLE) enabled. All of them are 
compiled into the kernel, not as a module. I've a Riva TNT2
I tried some modes from $KERNEL-SOURCES/Documentation/fb/vesafb.txt like
vga=0x317, vga=0x318 to append to to the kernel command line.
I've tried it with setting vga=0x317 in lilo.conf and also with vga=ask and 
entering 317 directly.
The monitor switches to another resolution upon boot for a very short time
and displays a message, but to short to read. Than it switches back to the
default resolution.
Trying fbset on the console to set the resolution results in a blank screen.
What is wrong? fb support with 2.4 and vga=773 worked perfect.
Thx,
Florian

This is the output of fbset -i

mode "640x480-60"
    # D: 25.176 MHz, H: 31.469 kHz, V: 59.942 Hz
    geometry 640 480 640 480 8
    timings 39721 40 24 32 11 96 2
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

Frame buffer device information:
    Name        : nVidiaRIVA-VTNT2
    Address     : 0xd4000000
    Size        : 33554432
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 640
    MMIO Address: 0xd6000000
    MMIO Size   : 16777216
    Accelerator : Unknown (28)


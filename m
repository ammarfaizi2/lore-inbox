Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264053AbTEJL6E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 07:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbTEJL6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 07:58:04 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:27900 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264053AbTEJL6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 07:58:03 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [BUG] missing symbox in es18xx - isapnp_protocol
Date: Sat, 10 May 2003 08:11:18 -0400
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200305100811.18633.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I converted a work 2.5 config for a second processor.   PNP is set as follows in .config

oscar% grep PNP .config
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_PNP_DEBUG=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_IDEPNP=y
# CONFIG_IP_PNP is not set

Yet I get:

*** Warning: "isapnp_protocol" [sound/isa/snd-es18xx.ko] undefined!
  ld -m elf_i386  -r --format binary --oformat elf32-i386 -T arch/i386/boot/compressed/vmlinux.

The following is set for sound.

CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_VIRMIDI=m
CONFIG_SND_ES18XX=m
CONFIG_SND_EMU10K1=m

It would seem that pnp.h exports the symbol and that es18xx.c includes this...

Ideas?
Ed Tomlinson

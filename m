Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSKXPb0>; Sun, 24 Nov 2002 10:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSKXPb0>; Sun, 24 Nov 2002 10:31:26 -0500
Received: from mail-2.tiscali.it ([195.130.225.148]:33406 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S261375AbSKXPbZ>;
	Sun, 24 Nov 2002 10:31:25 -0500
Date: Sun, 24 Nov 2002 16:38:42 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Subject: [2.5.49] Serial registered twice
Message-ID: <20021124153842.GA586@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my bootlog I see this:

Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: pnp: match found with the PnP device '00:0c' and the driver 'serial'
devfs_register(tts/0): could not append to parent, err: -17
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: pnp: match found with the PnP device '00:10' and the driver 'serial'
devfs_register(tts/1): could not append to parent, err: -17
tts/1 at I/O 0x2f8 (irq = 3) is a 16550A

>From my .config:

CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_PNP_DEBUG=y
CONFIG_PNPBIOS=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_CORE=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y


ciao,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"La mia teoria scientifica preferita e` quella secondo la quale gli 
 anelli di Saturno sarebbero interamente composti dai bagagli andati 
 persi nei viaggi aerei." -- Mark Russel

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbRFRTZL>; Mon, 18 Jun 2001 15:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262611AbRFRTZB>; Mon, 18 Jun 2001 15:25:01 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:18440 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S262580AbRFRTYt>; Mon, 18 Jun 2001 15:24:49 -0400
Subject: 2.4.5-ac15 -- Unresolved symbols "gameport_register_port" and
	"gameport_unregister_port" in char/joystick/[cs461x.o, emu10k1-gp.o,
	lightning.o, ns558.o, pcigame.o]
From: Miles Lane <miles@megapathdsl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 18 Jun 2001 12:31:28 -0700
Message-Id: <992892690.11752.0.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this is due to symbols not being exported or due
to some failed dependency structuring in "make menuconfig".

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.5-ac15;
fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.5-ac15/kernel/drivers/char/joystick/cs461x.o
depmod: 	gameport_register_port
depmod: 	gameport_unregister_port
depmod: *** Unresolved symbols in
/lib/modules/2.4.5-ac15/kernel/drivers/char/joystick/emu10k1-gp.o
depmod: 	gameport_register_port
depmod: 	gameport_unregister_port
depmod: *** Unresolved symbols in
/lib/modules/2.4.5-ac15/kernel/drivers/char/joystick/lightning.o
depmod: 	gameport_register_port
depmod: 	gameport_unregister_port
depmod: *** Unresolved symbols in
/lib/modules/2.4.5-ac15/kernel/drivers/char/joystick/ns558.o
depmod: 	gameport_register_port
depmod: 	gameport_unregister_port
depmod: *** Unresolved symbols in
/lib/modules/2.4.5-ac15/kernel/drivers/char/joystick/pcigame.o
depmod: 	gameport_register_port
depmod: 	gameport_unregister_port

Here are the relevant .config bits:

CONFIG_INPUT_GAMEPORT=y
CONFIG_INPUT_NS558=m
CONFIG_INPUT_LIGHTNING=m
CONFIG_INPUT_PCIGAME=m
CONFIG_INPUT_CS461X=m
CONFIG_INPUT_EMU10K1=m
CONFIG_INPUT_SERIO=m
CONFIG_INPUT_SERPORT=m
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set



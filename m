Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129744AbRAEP2e>; Fri, 5 Jan 2001 10:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130571AbRAEP2Y>; Fri, 5 Jan 2001 10:28:24 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:55989 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S129744AbRAEP2U>;
	Fri, 5 Jan 2001 10:28:20 -0500
Date: Fri, 5 Jan 2001 10:26:59 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.2.19pre6 maestro3 driver requires ac97_codec (but doesn't claim
 so)
In-Reply-To: <E14Dwv9-0004m4-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0101031806560.2120-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following (psuedo)patch to line 97 of drivers/sound/Makefile
corrects the problem:

 obj-$(CONFIG_SOUND_FUSION)      += cs46xx.o ac97_codec.o
 obj-$(CONFIG_SOUND_ICH)         += i810_audio.o ac97_codec.o
 obj-$(CONFIG_SOUND_MAESTRO)     += maestro.o
!obj-$(CONFIG_SOUND_MAESTRO3)    += maestro3.o
 obj-$(CONFIG_SOUND_SONICVIBES)  += sonicvibes.o
 obj-$(CONFIG_SOUND_TRIDENT)     += trident.o ac97_codec.o
 obj-$(CONFIG_SOUND_VIA82CXXX)   += via82cxxx_audio.o ac97_codec.o

 obj-$(CONFIG_SOUND_FUSION)      += cs46xx.o ac97_codec.o
 obj-$(CONFIG_SOUND_ICH)         += i810_audio.o ac97_codec.o
 obj-$(CONFIG_SOUND_MAESTRO)     += maestro.o
!obj-$(CONFIG_SOUND_MAESTRO3)    += maestro3.o ac97_codec.o
 obj-$(CONFIG_SOUND_SONICVIBES)  += sonicvibes.o
 obj-$(CONFIG_SOUND_TRIDENT)     += trident.o ac97_codec.o
 obj-$(CONFIG_SOUND_VIA82CXXX)   += via82cxxx_audio.o ac97_codec.o



-- 
Rick Nelson
Microsoft Corp., concerned by the growing popularity of the free 32-bit
operating system for Intel systems, Linux, has employed a number of top
programmers from the underground world of virus development. Bill Gates stated
yesterday: "World domination, fast -- it's either us or Linus". Mr. Torvalds
was unavailable for comment ...
(rjm@swift.eng.ox.ac.uk (Robert Manners), in comp.os.linux.setup)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

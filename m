Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261863AbTCYJu0>; Tue, 25 Mar 2003 04:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261871AbTCYJuZ>; Tue, 25 Mar 2003 04:50:25 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:49280 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S261863AbTCYJuY>;
	Tue, 25 Mar 2003 04:50:24 -0500
Message-ID: <3E802909.7020200@portrix.net>
Date: Tue, 25 Mar 2003 11:01:45 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: problems with rivafb again
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting plenty of those when switch from X (nv driver) to console 
(rivafb) since your latest code got merged in bk. Also, the console 
screen is really corrupted when switching back from X (sort of worked 
before) and the little penguin isn't drawn anymore at bootup time.

Jan

  Debug: sleeping function called from illegal context at mm/slab.c:1723
  Call Trace:
   [__might_sleep+95/128] __might_sleep+0x5f/0x80
   [kmalloc+136/144] kmalloc+0x88/0x90
   [accel_cursor+238/816] accel_cursor+0xee/0x330
   [page_remove_rmap+287/304] page_remove_rmap+0x11f/0x130
   [fb_vbl_handler+136/176] fb_vbl_handler+0x88/0xb0
   [init_stall_timer+66/80] init_stall_timer+0x42/0x50
   [i8042_timer_func+0/64] i8042_timer_func+0x0/0x40
   [cursor_timer_handler+0/64] cursor_timer_handler+0x0/0x40
   [cursor_timer_handler+31/64] cursor_timer_handler+0x1f/0x40
   [run_timer_softirq+141/368] run_timer_softirq+0x8d/0x170
   [timer_interrupt+123/336] timer_interrupt+0x7b/0x150
   [do_softirq+156/160] do_softirq+0x9c/0xa0
   [do_IRQ+252/288] do_IRQ+0xfc/0x120
   [default_idle+0/48] default_idle+0x0/0x30
   [default_idle+0/48] default_idle+0x0/0x30
   [common_interrupt+24/32] common_interrupt+0x18/0x20
   [default_idle+0/48] default_idle+0x0/0x30
   [default_idle+0/48] default_idle+0x0/0x30
   [default_idle+36/48] default_idle+0x24/0x30
   [cpu_idle+46/64] cpu_idle+0x2e/0x40
   [rest_init+0/96] _stext+0x0/0x60

ds666:/usr/src/bk/b# grep -i fb .config
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_HGA is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set
ds666:/usr/src/bk/b# grep -i logo .config
# Logo configuration
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y


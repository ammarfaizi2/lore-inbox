Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312996AbSDOGk5>; Mon, 15 Apr 2002 02:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312998AbSDOGk4>; Mon, 15 Apr 2002 02:40:56 -0400
Received: from [61.149.35.255] ([61.149.35.255]:3599 "HELO linux.tcpip.cxm")
	by vger.kernel.org with SMTP id <S312996AbSDOGkz>;
	Mon, 15 Apr 2002 02:40:55 -0400
Date: Mon, 15 Apr 2002 14:40:48 +0800
From: hugang <gang_hu@soul.com.cn>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [BUG] kmem_cache_grow.
Message-Id: <20020415144048.37318357.gang_hu@soul.com.cn>
Organization: soul
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hell all:

Problem: first run "find /" , eject and insert pcmcia network's card, the kernel will crash.

Kernel oops: at 
linux/mm/slab.c->kmem_cache_grow.
        if (in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC)
                BUG(); 		<-- here.

Can I remove this check ?
-----------
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
pcmcia-cs              3.1.31
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         serial_cs serial isa-pnp pcnet_cs 8390 af_packet parport_pc lp parport usb-uhci usbcore ide-cd cdrom floppy agpgart ospm_thermal ospm_battery ospm_ec ospm_button ospm_ac_adapter ospm_processor ospm_system ospm_busmgr via82cxxx_audio ac97_codec uart401 sound soundcore rtc unix
-- 
thanks with regards!
hugang.

***********************************
Beijing Soul Technology Co.,Ltd.
Tel:010-68425741/42/43/44
Fax:010-68425745
email:gang_hu@soul.com.cn
web:http://www.soul.com.cn
***********************************

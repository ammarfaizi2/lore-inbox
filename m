Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbSLJSfJ>; Tue, 10 Dec 2002 13:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbSLJSfJ>; Tue, 10 Dec 2002 13:35:09 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:39162 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265154AbSLJSfG>; Tue, 10 Dec 2002 13:35:06 -0500
Message-ID: <3DF635A5.7040105@attbi.com>
Date: Tue, 10 Dec 2002 10:42:45 -0800
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021129
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.51 -- Unresolved symbols in /lib/modules/2.5.51/kernel/3c59x.ko
 -- pci_set_power_state, etc.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.22
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12

Running:
sh arch/i386/boot/install.sh 2.5.51 arch/i386/boot/bzImage System.map ""
(which calls "depmod -ae -F /boot/System.map-2.5.51 2.5.51"),
I get:

depmod: *** Unresolved symbols in /lib/modules/2.5.51/kernel/3c59x.ko
depmod:         pci_set_power_state
depmod:         EISA_bus
depmod:         __netdev_watchdog_up
depmod:         preempt_schedule
depmod:         _mmx_memcpy
depmod:         enable_irq
depmod:         eth_type_trans
depmod:         __kfree_skb
depmod:         alloc_skb
depmod:         pci_register_driver
depmod:         pci_bus_write_config_byte
depmod:         __release_region
depmod:         pci_free_consistent
depmod:         pci_enable_device
depmod:         alloc_etherdev
depmod:         cpu_raise_softirq
depmod:         pci_restore_state
depmod:         free_irq
depmod:         unregister_netdev
depmod:         copy_to_user
depmod:         pci_alloc_consistent
depmod:         __ioremap
depmod:         zone_table
depmod:         del_timer
depmod:         register_netdev
depmod:         linkwatch_fire_event
depmod:         mod_timer
depmod:         kfree
depmod:         disable_irq
depmod:         request_irq
depmod:         netif_rx
depmod:         pci_unregister_driver
depmod:         skb_over_panic
depmod:         pci_set_master
depmod:         pci_enable_wake
depmod:         sprintf
depmod:         copy_from_user
depmod:         jiffies
depmod:         softnet_data
depmod:         __request_region
depmod:         printk
depmod:         add_timer
depmod:         irq_stat
depmod:         pci_save_state
depmod:         __const_udelay
depmod:         ioport_resource
depmod:         do_softirq
depmod:         pci_bus_read_config_byte

  mkdir -p /lib/modules/2.5.51/kernel && cp drivers/usb/media/dsbr100.ko 
drivers
/usb/media/ibmcam.ko drivers/usb/media/usbvideo.ko 
drivers/usb/media/ultracam.ko
 drivers/usb/media/konicawc.ko drivers/usb/media/usbvideo.ko 
drivers/usb/media/o
v511.ko drivers/usb/media/pwc.ko drivers/usb/media/se401.ko 
drivers/usb/media/st
v680.ko drivers/usb/media/vicam.ko drivers/usb/media/usbvideo.ko 
/lib/modules/2.
5.51/kernel/
cp: warning: source file `drivers/usb/media/usbvideo.ko' specified more 
than once
cp: warning: source file `drivers/usb/media/usbvideo.ko' specified more 
than once

  mkdir -p /lib/modules/2.5.51/kernel && cp 
drivers/usb/serial/usbserial.ko driv
ers/usb/serial/visor.ko drivers/usb/serial/ipaq.ko 
drivers/usb/serial/whiteheat.
ko drivers/usb/serial/ftdi_sio.ko drivers/usb/serial/keyspan_pda.ko 
drivers/usb/
serial/keyspan_pda.ko drivers/usb/serial/omninet.ko 
drivers/usb/serial/digi_acce
leport.ko drivers/usb/serial/belkin_sa.ko drivers/usb/serial/empeg.ko 
drivers/us
b/serial/mct_u232.ko drivers/usb/serial/io_edgeport.ko 
drivers/usb/serial/io_ti.
ko drivers/usb/serial/pl2303.ko drivers/usb/serial/cyberjack.ko 
drivers/usb/seri
al/ir-usb.ko drivers/usb/serial/kl5kusb105.ko 
drivers/usb/serial/safe_serial.ko
/lib/modules/2.5.51/kernel/
cp: warning: source file `drivers/usb/serial/keyspan_pda.ko' specified 
more than once




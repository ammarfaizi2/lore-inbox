Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131983AbRDMWK4>; Fri, 13 Apr 2001 18:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRDMWKr>; Fri, 13 Apr 2001 18:10:47 -0400
Received: from mailout2-1.nyroc.rr.com ([24.92.226.165]:54569 "EHLO
	mailout2-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S132027AbRDMWKe>; Fri, 13 Apr 2001 18:10:34 -0400
Date: Fri, 13 Apr 2001 18:09:47 -0400
From: Scott Prader <gnea@rochester.rr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac5
Message-ID: <20010413180947.A22533@rochester.rr.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E14njvB-0000xu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E14njvB-0000xu-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Apr 12, 2001 at 05:26:11PM +0100
X-Editor: Vim http://www.vim.org/
X-Info: http://garson.org
X-Operating-System: Linux/2.4.0-test10 (i586)
X-Uptime: 5:52pm  up 15 days,  2:17, 14 users,  load average: 0.23, 0.09, 0.03
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Alan Cox (alan@lxorguk.ukuu.org.uk) uttered:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/

one of the problems i've been having so far with the 2.4.3 series is the
fact that USB appears to be futzed.  It just doesn't want to work right.
Also, I compile a lot of things as modules and I've been getting lots of
unresolved symbols and hence many things (including my nic) don't work,
so I am still stuck at 2.4.2-ac4.  So here's some info that should help
out whoevers doing the specific work on USB and whatever else decided it
wanted to say "ok, you suck, go away" ;)

one other note i should mention, is that i use usbmgr from debian linux
(sid) and after i tweaked its config file, it runs just fine,
hot-plugging with my usb mice just fine... gpm and X don't have a
problem with them.

system: abit bp6 dual celerons 366 oc'd to 504 work fine with 2.4.2-ac4
and win98 blahblahblah

utils:
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.1
util-linux             
util-linux             Note: /usr/bin/fdformat is obsolete and is no
longer available.
util-linux             Please use /usr/bin/superformat instead (make
sure you have the 
util-linux             fdutils package installed first).  Also, there
had been some
util-linux             major changes from version 4.x.  Please refer to
the documentation.
util-linux             
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0j
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.59
Console-tools          0.2.3
Sh-utils               2.0.11
blahblahblah...

well that's about it, i've attached some logs that i snipped since the
rest of it didn't contain any errogenous errors.  If you need more info
please give me a hollar.  But i think this should do it.

the first log is from make modules_install at the end, the second is the
tailing part of dmesg (nothing out of place before it, and it tends to
scroll past the buffer so I can't see the whole thing even with dmesg
-s20000, which i find quite annoying, but 'tis life)

   .oO Gnea [gnea at rochester dot rr dot com] Oo.
         .oO url: http://garson.org/~gnea Oo.

"You can tune a filesystem, but you can't tuna fish." -unknown

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="modules.install.log"

make[1]: Nothing to be done for `modules_install'.
make[1]: Leaving directory `/usr/src/linux-2.4.3-ac5/arch/i386/lib'
cd /lib/modules/2.4.3-ac5; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.3-ac5; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/char/joystick/pcigame.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/ieee1394/ohci1394.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/ieee1394/pcilynx.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/ieee1394/video1394.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/media/video/bttv.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/message/i2o/i2o_block.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/message/i2o/i2o_core.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/message/i2o/i2o_lan.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/message/i2o/i2o_scsi.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/3c59x.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/ac3200.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/arlan-proc.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/arlan.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/eepro100.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/ethertap.o
depmod: 	netlink_kernel_create
depmod: 	netlink_broadcast
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/irda/irda-usb.o
depmod: 	rtnl_unlock
depmod: 	rtnl_lock
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/irda/irport.o
depmod: 	rtnl_unlock
depmod: 	rtnl_lock
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/irda/irtty.o
depmod: 	rtnl_unlock
depmod: 	rtnl_lock
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/irda/nsc-ircc.o
depmod: 	rtnl_unlock
depmod: 	rtnl_lock
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/irda/toshoboe.o
depmod: 	rtnl_unlock
depmod: 	rtnl_lock
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/irda/w83977af_ir.o
depmod: 	rtnl_unlock
depmod: 	rtnl_lock
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/natsemi.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/ppp_generic.o
depmod: 	rtnl_unlock
depmod: 	rtnl_lock
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/slip.o
depmod: 	rtnl_unlock
depmod: 	rtnl_lock
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/starfire.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/sundance.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/sunhme.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/tokenring/ibmtr.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/tokenring/lanstreamer.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/tokenring/olympic.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/tun.o
depmod: 	rtnl_unlock
depmod: 	rtnl_lock
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/net/winbond-840.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/scsi/sym53c8xx.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/drivers/usb/usb-ohci.o
depmod: 	__io_virt_debug
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/decnet/decnet.o
depmod: 	rtnetlink_links
depmod: 	__rta_fill
depmod: 	netlink_set_err
depmod: 	netlink_broadcast
depmod: 	netlink_unicast
depmod: 	rtnl_unlock
depmod: 	rtnl
depmod: 	rtnl_lock
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/cls_fw.o
depmod: 	__rta_fill
depmod: 	rtattr_parse
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/cls_route.o
depmod: 	__rta_fill
depmod: 	rtattr_parse
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/cls_rsvp.o
depmod: 	__rta_fill
depmod: 	rtattr_parse
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/cls_rsvp6.o
depmod: 	__rta_fill
depmod: 	rtattr_parse
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/cls_tcindex.o
depmod: 	__rta_fill
depmod: 	rtattr_parse
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/cls_u32.o
depmod: 	__rta_fill
depmod: 	rtattr_parse
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/sch_cbq.o
depmod: 	__rta_fill
depmod: 	rtattr_parse
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/sch_csz.o
depmod: 	__rta_fill
depmod: 	rtattr_parse
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/sch_dsmark.o
depmod: 	__rta_fill
depmod: 	rtattr_parse
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/sch_gred.o
depmod: 	__rta_fill
depmod: 	rtattr_parse
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/sch_ingress.o
depmod: 	__rta_fill
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/sch_prio.o
depmod: 	__rta_fill
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/sch_red.o
depmod: 	__rta_fill
depmod: 	rtattr_parse
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/sch_sfq.o
depmod: 	__rta_fill
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/sch_tbf.o
depmod: 	__rta_fill
depmod: 	rtattr_parse
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac5/kernel/net/sched/sch_teql.o
depmod: 	rtnl_unlock
depmod: 	rtnl_lock

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.celery.20010413"

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 17:32:01 Apr 13 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xc000, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb-uhci.c: interrupt, status 30, frame# 0
usb.c: kmalloc IF c7cfadfc, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: c000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c7cfadfc
hub.c: port 1 connection change
hub.c: port 1, portstatus 301, change 1, 1.5 Mb/s
hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: registered new driver hid
mice: PS/2 mouse device common for all mice
usb.c: registered new driver usb_mouse
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
hub.c: USB new device connect on bus1/1, assigned device number 3
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)

--rwEMma7ioTxnRzrJ--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTH0T4j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 15:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbTH0T4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 15:56:39 -0400
Received: from [194.151.80.102] ([194.151.80.102]:17675 "EHLO
	paldrick.research.newtrade.nl") by vger.kernel.org with ESMTP
	id S262095AbTH0T4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 15:56:32 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: jjluza <jjluza@yahoo.fr> (by way of jjluza <jjluza@yahoo.fr>),
       linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6-testXX and alcatel speedtouch usb modem
Date: Wed, 27 Aug 2003 21:57:47 +0200
User-Agent: KMail/1.5.1
References: <200308260543.16739.jjluza@yahoo.fr>
In-Reply-To: <200308260543.16739.jjluza@yahoo.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_70QT/WXo77Urinu"
Message-Id: <200308272157.47529.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_70QT/WXo77Urinu
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Tuesday 26 August 2003 05:43, jjluza wrote:
> Le Lundi 25 Août 2003 11:31, vous avez écrit :
> > On Wednesday 20 August 2003 02:03, jjluza wrote:
> > > I try to make this modem working.
> > > It works very well on kernel 2.4 series.
> > > It work with some kernel 2.6 until test2-mm1.
> > > But since test2-mm1, the newer kernel doesn't work anymore.
> > > There is 2 related drivers for this modem.
> > > The one which is included in the kernel and which can be found here :
> > > http://www.linux-usb.org/SpeedTouch/
> > > and the one which I've always used until now :
> > > speedtouch.sourceforge.net
> > >
> > > when I notice that the old one doesn't work anymore, I try with the
> > > driver which included in the kernel, without success.
> >
> > Did you follow the instructions on http://www.linux-usb.org/SpeedTouch/ ?
> >
> > > It crashed when I do "pppd call adsl".
> >
> > From what I see below you are still using the userspace driver (pppoa3),
> > which is being called by pppd.  This won't work when you have the kernel
> > module loaded.  You need to use a pppoa aware pppd and not call pppd.
> >
> > > I can load the firmware.
> > >
> > > And here is messages in syslog :
> > > Aug 19 22:00:26 serveur modem_run[337]: modem_run version 1.1 started
> > > by root uid 0
> > > Aug 19 22:00:28 serveur kernel: usb 1-2: bulk timeout on ep5in
> > > Aug 19 22:00:28 serveur kernel: usbfs: USBDEVFS_BULK failed dev 2 ep
> > > 0x85 len 512 ret -110
> > > Aug 19 22:00:43 serveur modem_run[337]: ADSL synchronization has been
> > > obtained Aug 19 22:00:43 serveur modem_run[337]: ADSL line is up (608
> > > kbit/s down | 160 kbit/s up)
> > > Aug 19 22:00:43 serveur modprobe: FATAL: Module ipv6 not found.
> > > Aug 19 22:00:43 serveur pppd[345]: pppd 2.4.1 started by root, uid 0
> > > Aug 19 22:00:43 serveur pppd[345]: Using interface ppp0
> > > Aug 19 22:00:44 serveur pppd[345]: Connect: ppp0 <--> /dev/pts/0
> > > Aug 19 22:00:44 serveur kernel: ip_conntrack version 2.1 (768 buckets,
> > > 6144 max) - 300 bytes per conntrack
> > > Aug 19 22:00:44 serveur pppoa3[346]: PPPoA3 version 1.1 started by root
> > > (uid 0)
> > > Aug 19 22:00:44 serveur pppoa3[346]: Control thread ready
> > > Aug 19 22:00:44 serveur pppoa3[352]: ppp(d) --> pppoa3 --> modem 
> > > stream ready Aug 19 22:00:44 serveur pppoa3[353]: modem  --> pppoa3 -->
> > > ppp(d) stream ready Aug 19 22:00:44 serveur pppoa3[353]: Error reading
> > > usb urb Aug 19 22:00:44 serveur pppoa3[346]: Woken by a sem_post event
> > > -> Exiting Aug 19 22:00:44 serveur pppoa3[346]: Read from ppp Canceled
> > > Aug 19 22:00:44 serveur pppoa3[346]: Write to ppp Canceled
> > > Aug 19 22:00:44 serveur pppoa3[346]: Exiting
> > > Aug 19 22:00:44 serveur pppd[345]: Modem hangup
> > > Aug 19 22:00:44 serveur pppd[345]: Connection terminated.
> > > Aug 19 22:00:44 serveur kernel: usbfs: usb_submit_urb returned -32
> > > Aug 19 22:00:44 serveur kernel: Device class 'ppp0' does not have a
> > > release() function, it is broken and must
> > > be fixed.
> > > Aug 19 22:00:44 serveur kernel: Badness in class_dev_release at
> > > drivers/base/class.c:201
> > > Aug 19 22:00:44 serveur kernel: Call Trace:
> > > Aug 19 22:00:44 serveur kernel:  [kobject_cleanup+54/64]
> > > kobject_cleanup+0x36/0x40
> > > Aug 19 22:00:44 serveur kernel:  [netdev_run_todo+267/464]
> > > netdev_run_todo+0x10b/0x1d0
> > > Aug 19 22:00:44 serveur kernel:  [_end+114517535/1070384712]
> > > ppp_shutdown_interface+0x87/0xe0 [ppp_generic]
> > > Aug 19 22:00:44 serveur kernel:  [_end+114504362/1070384712]
> > > ppp_ioctl+0x802/0x820 [ppp_generic]
> > > Aug 19 22:00:44 serveur kernel:  [__fput+193/288] __fput+0xc1/0x120
> > > Aug 19 22:00:44 serveur kernel:  [sys_ioctl+263/640]
> > > sys_ioctl+0x107/0x280 Aug 19 22:00:44 serveur kernel:
> > > [syscall_call+7/11] syscall_call+0x7/0xb Aug 19 22:00:44 serveur
> > > kernel: Aug 19 22:00:44 serveur kernel: ip_tables: (C) 2000-2002
> > > Netfilter core team Aug 19 22:00:44 serveur pppd[345]: Using interface
> > > ppp0
> > > Aug 19 22:00:44 serveur pppd[345]: Connect: ppp0 <--> /dev/pts/0
> > > Aug 19 22:00:44 serveur pppoa3[364]: PPPoA3 version 1.1 started by root
> > > (uid 0)
> > > Aug 19 22:00:44 serveur pppoa3[364]: Control thread ready
> > > Aug 19 22:00:44 serveur pppoa3[374]: ppp(d) --> pppoa3 --> modem 
> > > stream ready Aug 19 22:00:44 serveur pppoa3[375]: modem  --> pppoa3 -->
> > > ppp(d) stream ready Aug 19 22:00:44 serveur pppoa3[375]: Error reading
> > > usb urb Aug 19 22:00:44 serveur pppoa3[364]: Woken by a sem_post event
> > > -> Exiting Aug 19 22:00:44 serveur pppoa3[364]: Read from ppp Canceled
> > > Aug 19 22:00:44 serveur pppoa3[364]: Write to ppp Canceled
> > > Aug 19 22:00:44 serveur kernel: usbfs: usb_submit_urb returned -32
> > > Aug 19 22:00:44 serveur pppoa3[364]: Exiting
> > > Aug 19 22:00:44 serveur pppd[345]: Modem hangup
> > > Aug 19 22:00:44 serveur pppd[345]: Connection terminated.
> > > Aug 19 22:00:44 serveur kernel: Device class 'ppp0' does not have a
> > > release() function, it is broken and must
> > > be fixed.
> > > Aug 19 22:00:44 serveur kernel: Badness in class_dev_release at
> > > drivers/base/class.c:201
> > > Aug 19 22:00:44 serveur kernel: Call Trace:
> > > Aug 19 22:00:44 serveur kernel:  [kobject_cleanup+54/64]
> > > kobject_cleanup+0x36/0x40
> > > Aug 19 22:00:44 serveur kernel:  [netdev_run_todo+267/464]
> > > netdev_run_todo+0x10b/0x1d0
> > > Aug 19 22:00:44 serveur kernel:  [_end+114517535/1070384712]
> > > ppp_shutdown_interface+0x87/0xe0 [ppp_generic]
> > > Aug 19 22:00:44 serveur kernel:  [_end+114504362/1070384712]
> > > ppp_ioctl+0x802/0x820 [ppp_generic]
> > > Aug 19 22:00:44 serveur kernel:  [__fput+193/288] __fput+0xc1/0x120
> > > Aug 19 22:00:44 serveur kernel:  [sys_ioctl+263/640]
> > > sys_ioctl+0x107/0x280 Aug 19 22:00:44 serveur kernel:
> > > [syscall_call+7/11] syscall_call+0x7/0xb Aug 19 22:00:44 serveur
> > > kernel: Aug 19 22:00:44 serveur pppoa3[386]: PPPoA3 version 1.1 started
> > > by root (uid 0)
> > > Aug 19 22:00:44 serveur pppoa3[386]: Control thread ready
> > > Aug 19 22:00:44 serveur pppoa3[389]: ppp(d) --> pppoa3 --> modem 
> > > stream ready Aug 19 22:00:44 serveur pppoa3[390]: modem  --> pppoa3 -->
> > > ppp(d) stream ready Aug 19 22:00:44 serveur pppoa3[390]: Error reading
> > > usb urb Aug 19 22:00:44 serveur pppoa3[386]: Woken by a sem_post event
> > > -> Exiting Aug 19 22:00:44 serveur pppoa3[386]: Read from ppp Canceled
> > > Aug 19 22:00:44 serveur pppoa3[386]: Write to ppp Canceled
> > > Aug 19 22:00:44 serveur kernel: usbfs: usb_submit_urb returned -32
> > > Aug 19 22:00:44 serveur pppd[345]: Using interface ppp0
> > > Aug 19 22:00:44 serveur pppoa3[386]: Exiting
> > > Aug 19 22:00:44 serveur pppd[345]: Connect: ppp0 <--> /dev/pts/0
> > > Aug 19 22:00:44 serveur pppd[345]: ioctl(PPPIOCSASYNCMAP):
> > > Inappropriate ioctl for device(25)
> > > Aug 19 22:00:44 serveur pppd[345]: tcflush failed: Input/output error
> > > Aug 19 22:00:44 serveur kernel: Device class 'ppp0' does not have a
> > > release() function, it is broken and must
> > > be fixed.
> > > Aug 19 22:00:44 serveur kernel: Badness in class_dev_release at
> > > drivers/base/class.c:201
> > > Aug 19 22:00:44 serveur kernel: Call Trace:
> > > Aug 19 22:00:44 serveur kernel:  [kobject_cleanup+54/64]
> > > kobject_cleanup+0x36/0x40
> > > Aug 19 22:00:44 serveur kernel:  [netdev_run_todo+267/464]
> > > netdev_run_todo+0x10b/0x1d0
> > > Aug 19 22:00:45 serveur kernel:  [_end+114517535/1070384712]
> > > ppp_shutdown_interface+0x87/0xe0 [ppp_generic]
> > > Aug 19 22:00:45 serveur kernel:  [_end+114504362/1070384712]
> > > ppp_ioctl+0x802/0x820 [ppp_generic]
> > > Aug 19 22:00:45 serveur kernel:  [__fput+193/288] __fput+0xc1/0x120
> > > Aug 19 22:00:45 serveur kernel:  [sys_ioctl+263/640]
> > > sys_ioctl+0x107/0x280 Aug 19 22:00:45 serveur kernel:
> > > [syscall_call+7/11] syscall_call+0x7/0xb Aug 19 22:00:45 serveur
> > > kernel: Aug 19 22:00:45 serveur pppd[345]: Exit.
> > >
> > >
> > > so, the last kernel which work with this adsl modem is test2-mm1.
> >
> > It looks like usbfs is broken again.  I should be able to look into
> > this next week.  In the meantime, please try the kernel module.
> >
> > All the best,
> >
> > Duncan.
>
> So, I just retry to use the way explain here :
>  http://www.linux-usb.org/SpeedTouch/
> and I don't succeed
> It seems that the howto page is too old
> the pppd I should use is a bit old too (several year)
> when I try to run pppd, it tells me "illegal instruction" (but I follow
> closely the documentation

Hi jj, yes the howto is a bit out of date.  If you download the "speedbundle"
from the download page, your life should be much easier: it contains all
the programs you need (kernel module, pppd, scripts etc): all you need
to does is a make, make install.  The make will prompt you to set various
values (read the error messages) like your user name and password.
You may need the attached Makefile.

> The doc says that modem_run work, but it don't work for me (it tells me
> another instance is running when speedtch is loaded)

This probably means you are using the init script for the user mode driver
and it has already launched modem_run.

> So, I'm bored to make it works whereas speedtouch.sourceforge.net is a
> great project which have made my life easier for several years  ;)

Yeah, I used it for ages too, it works fine.  However, when the kernel module
went into 2.5, someone had to take care of it :)

> I decide to not try again to use other solutions. If futur kernels don't
> work with my modem, I keep on using older kernel anyway, like test2-mm1
>
> The usb problem I got is fixed in test4-mm1 : good thing

Great!

Duncan.
--Boundary-00=_70QT/WXo77Urinu
Content-Type: text/x-makefile;
  charset="iso-8859-15";
  name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Makefile"

all: build

configure: configure-stamp
configure-stamp:
	./configure

build: configure-stamp build-stamp
build-stamp:
	cd kernel_module && $(MAKE)
	cd linux-atm/src/lib && $(MAKE)
	cd ppp/pppd && $(MAKE)
	cd ppp/pppd/plugins && $(MAKE) C_INCLUDE_PATH=../../../linux-atm/src/include LIBRARY_PATH=../../../linux-atm/src/lib/.libs
	cd firmware && $(MAKE)
	cd firmware_loader && $(MAKE)
	cd hotplug_scripts && $(MAKE)
	cd ppp_scripts && $(MAKE)
	touch build-stamp

clean:
	rm -f build-stamp configure-stamp
	cd firmware && $(MAKE) clean
	cd firmware_loader && $(MAKE) clean
	cd hotplug_scripts && $(MAKE) clean
	cd kernel_module && $(MAKE) clean
	cd linux-atm/src/lib && $(MAKE) clean
	cd ppp/pppd/plugins && $(MAKE) clean
	cd ppp/pppd && $(MAKE) clean
	cd ppp && $(MAKE) clean
	cd ppp_scripts && $(MAKE) clean

install: build
	cd kernel_module && $(MAKE) install
	cd firmware && $(MAKE) install
	cd firmware_loader && $(MAKE) modem_run
	cd hotplug_scripts && $(MAKE) install
	cd linux-atm/src/lib && $(MAKE) install
	cd ppp/pppd && $(MAKE) install
	cd ppp/pppd/plugins && $(MAKE) install
	cd ppp_scripts && $(MAKE) install

--Boundary-00=_70QT/WXo77Urinu--

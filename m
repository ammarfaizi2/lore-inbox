Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUIJI0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUIJI0X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267234AbUIJI0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:26:23 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:3732 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S267232AbUIJI0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:26:03 -0400
Date: Fri, 10 Sep 2004 10:26:01 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm4, visor.c, Badness in usb_unlink_urb
Message-ID: <20040910082601.GA32746@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Syncing my PalmOne T|C I get a lot of error messages (see below).
Suprisingly this didn't disturb my palm to be synced. 



vmunix: usb 4-2.1: new full speed USB device using address 6
vmunix: visor 4-2.1:1.0: Handspring Visor / Palm OS converter detected
vmunix: usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB0
vmunix: usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB1
udev[14677]: configured rule in '/etc/udev/rules.d/00-local.rules' at line 3 applied, added symlink 'pilot'
udev[14675]: creating device node '/dev/ttyUSB0'
udev[14677]: creating device node '/dev/ttyUSB1'
vmunix: usb_unlink_urb() is deprecated for synchronous unlinks.  Use usb_kill_urb()
vmunix: Badness in usb_unlink_urb at drivers/usb/core/urb.c:456
vmunix:  [<c02616fe>] usb_unlink_urb+0x7e/0x90
vmunix:  [<c0287e82>] visor_close+0x22/0xe0
vmunix:  [<c028548b>] serial_close+0x9b/0x110
vmunix:  [<c01f8fcd>] release_dev+0x62d/0x650
vmunix:  [<c01f7eaa>] tty_read+0xda/0x130
vmunix:  [<c01f941f>] tty_release+0x1f/0x50
vmunix:  [<c014f38e>] __fput+0xfe/0x110
vmunix:  [<c014dc0f>] filp_close+0x4f/0x80
vmunix:  [<c0115520>] do_page_fault+0x0/0x550
vmunix:  [<c0103ff5>] sysenter_past_esp+0x52/0x71
vmunix: usb 4-2.1: USB disconnect, address 6
vmunix:  [<c0285150>] destroy_serial+0x0/0x150
vmunix:  [<c01ba954>] kref_put+0x34/0xa0
vmunix:  [<c0286b98>] usb_serial_disconnect+0x38/0x90
vmunix:  [<c026272d>] usb_disable_endpoint+0x3d/0x40
vmunix:  [<c0262756>] usb_disable_interface+0x26/0x40
vmunix:  [<c025c130>] usb_unbind_interface+0x60/0x70
vmunix:  [<c02183e6>] device_release_driver+0x56/0x60
vmunix:  [<c0218612>] bus_remove_device+0x52/0x90
vmunix:  [<c02175fa>] device_del+0x5a/0x90
vmunix:  [<c026280c>] usb_disable_device+0x9c/0xd0
vmunix:  [<c025e0f1>] usb_disconnect+0xa1/0x130
vmunix:  [<c025f12b>] hub_port_connect_change+0x36b/0x390
vmunix:  [<c025f389>] hub_events+0x239/0x360
vmunix:  [<c0122241>] free_uid+0x11/0x80
vmunix:  [<c025f4e5>] hub_thread+0x35/0x110
vmunix:  [<c012c390>] autoremove_wake_function+0x0/0x50
vmunix:  [<c0103f1e>] ret_from_fork+0x6/0x14
vmunix:  [<c012c390>] autoremove_wake_function+0x0/0x50
vmunix:  [<c025f4b0>] hub_thread+0x0/0x110
vmunix:  [<c010227d>] kernel_thread_helper+0x5/0x18
vmunix: usb_unlink_urb() is deprecated for synchronous unlinks.  Use usb_kill_urb()
kernel: visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0
vmunix: Badness in usb_unlink_urb at drivers/usb/core/urb.c:45ad+0x0/0x110
vmunix:  [<c010227d>] kernel_thread_helper+0x5/0x18
vmunix: visor 4-2.1:1.0: device disconnected
kernel: usb_unlink_urb() is deprecated for synchronous unlinks.  Use usb_kill_urb()
kernel: Badness in usb_unlink_urb at drivers/usb/core/urb.c:456
kernel:  [usb_unlink_urb+126/144] usb_unlink_urb+0x7e/0x90
kernel:  [port_release+114/176] port_release+0x72/0xb0
kernel:  [device_release+83/96] device_release+0x53/0x60
kernel:  [kobject_cleanup+142/144] kobject_cleanup+0x8e/0x90
kernel:  [kobject_release+0/16] kobject_release+0x0/0x10
kernel:  [kref_put+52/160] kref_put+0x34/0xa0
kernel:  [device_del+105/144] device_del+0x69/0x90
kernel:  [destroy_serial+266/336] destroy_serial+0x10a/0x150
kernel:  [hcd_endpoint_disable+219/432] hcd_endpoint_disable+0xdb/0x1b0
kernel: 6
kernel:  [usb_unlink_urb+126/144] usb_unlink_urb+0x7e/0x90
kernel:  [port_release+99/176] port_release+0x63/0xb0
kernel:  [device_release+83/96] device_release+0x53/0x60
kernel:  [kobject_cleanup+142/144] kobject_cleanup+0x8e/0x90
kernel:  [kobject_release+0/16] kobject_release+0x0/0x10
kernel:  [kref_put+52/160] kref_put+0x34/0xa0
kernel:  [device_del+105/144] device_del+0x69/0x90
kernel:  [destroy_serial+266/336] destroy_serial+0x10a/0x150
kernel:  [hcd_endpoint_disable+219/432] hcd_endpoint_disable+0xdb/0x1b0
kernel:  [destroy_serial+0/336] destroy_serial+0x0/0x150
kernel:  [kref_put+52/160] kref_put+0x34/0xa0
kernel:  [usb_serial_disconnect+56/144] usb_serial_disconnect+0x38/0x90
kernel:  [usb_disable_endpoint+61/64] usb_disable_endpoint+0x3d/0x40
kernel:  [usb_disable_interface+38/64] usb_disable_interface+0x26/0x40
kernel:  [usb_unbind_interface+96/112] usb_unbind_interface+0x60/0x70
kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
kernel:  [bus_remove_device+82/144] bus_remove_device+0x52/0x90
kernel:  [device_del+90/144] device_del+0x5a/0x90
kernel:  [usb_disable_device+156/208] usb_disable_device+0x9c/0xd0
kernel:  [usb_disconnect+161/304] usb_disconnect+0xa1/0x130
kernel:  [hub_port_connect_change+875/912] hub_port_connect_change+0x36b/0x390
kernel:  [hub_events+569/864] hub_events+0x239/0x360
kernel:  [free_uid+17/128] free_uid+0x11/0x80
kernel:  [hub_thread+53/272] hub_thread+0x35/0x110
kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
kernel:  [hub_thread+0/272] hub_thread+0x0/0x110
kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
kernel: visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected from ttyUSB1
kernel: usb_unlink_urb() is deprecated for synchronous unlinks.  Use usb_kill_urb()
kernel: Badness in usb_unlink_urb at drivers/usb/core/urb.c:456
kernel:  [usb_unlink_urb+126/144] usb_unlink_urb+0x7e/0x90
kernel:  [port_release+114/176] port_release+0x72/0xb0
kernel:  [device_release+83/96] device_release+0x53/0x60
kernel:  [kobject_cleanup+142/144] kobject_cleanup+0x8e/0x90
kernel:  [kobject_release+0/16] kobject_release+0x0/0x10
kernel:  [kref_put+52/160] kref_put+0x34/0xa0
kernel:  [device_del+105/144] device_del+0x69/0x90
kernel:  [destroy_serial+266/336] destroy_serial+0x10a/0x150
kernel:  [hcd_endpoint_disable+219/432] hcd_endpoint_disable+0xdb/0x1b0
kernel:  [destroy_serial+0/336] destroy_serial+0x0/0x150
kernel:  [kref_put+52/160] kref_put+0x34/0xa0
kernel:  [usb_serial_disconnect+56/144] usb_serial_disconnect+0x38/0x90
kernel:  [usb_disable_endpoint+61/64] usb_disable_endpoint+0x3d/0x40
kernel:  [usb_disable_interface+38/64] usb_disable_interface+0x26/0x40
kernel:  [usb_unbind_interface+96/112] usb_unbind_interface+0x60/0x70
kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
kernel:  [bus_remove_device+82/144] bus_remove_device+0x52/0x90
kernel:  [device_del+90/144] device_del+0x5a/0x90
kernel:  [usb_disable_device+156/208] usb_disable_device+0x9c/0xd0
kernel:  [usb_disconnect+161/304] usb_disconnect+0xa1/0x130
kernel:  [hub_port_connect_change+875/912] hub_port_connect_change+0x36b/0x390
kernel:  [hub_events+569/864] hub_events+0x239/0x360
kernel:  [free_uid+17/128] free_uid+0x11/0x80
kernel:  [hub_thread+53/272] hub_thread+0x35/0x110
kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
kernel:  [hub_thread+0/272] hub_thread+0x0/0x110
kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
kernel: usb_unlink_urb() is deprecated for synchronous unlinks.  Use usb_kill_urb()
kernel: Badness in usb_unlink_urb at drivers/usb/core/urb.c:456
kernel:  [usb_unlink_urb+126/144] usb_unlink_urb+0x7e/0x90
kernel:  [port_release+99/176] port_release+0x63/0xb0
kernel:  [device_release+83/96] device_release+0x53/0x60
kernel:  [kobject_cleanup+142/144] kobject_cleanup+0x8e/0x90
kernel:  [kobject_release+0/16] kobject_release+0x0/0x10
kernel:  [kref_put+52/160] kref_put+0x34/0xa0
kernel:  [device_del+105/144] device_del+0x69/0x90
kernel:  [destroy_serial+266/336] destroy_serial+0x10a/0x150
kernel:  [hcd_endpoint_disable+219/432] hcd_endpoint_disable+0xdb/0x1b0
kernel:  [destroy_serial+0/336] destroy_serial+0x0/0x150
kernel:  [kref_put+52/160] kref_put+0x34/0xa0
kernel:  [usb_serial_disconnect+56/144] usb_serial_disconnect+0x38/0x90
kernel:  [usb_disable_endpoint+61/64] usb_disable_endpoint+0x3d/0x40
kernel:  [usb_disable_interface+38/64] usb_disable_interface+0x26/0x40
kernel:  [usb_unbind_interface+96/112] usb_unbind_interface+0x60/0x70
kernel:  [device_release_driver+86/96] device_release_driver+0x56/0x60
kernel:  [bus_remove_device+82/144] bus_remove_device+0x52/0x90
kernel:  [device_del+90/144] device_del+0x5a/0x90
kernel:  [usb_disable_device+156/208] usb_disable_device+0x9c/0xd0
kernel:  [usb_disconnect+161/304] usb_disconnect+0xa1/0x130
kernel:  [hub_port_connect_change+875/912] hub_port_connect_change+0x36b/0x390
kernel:  [hub_events+569/864] hub_events+0x239/0x360
kernel:  [free_uid+17/128] free_uid+0x11/0x80
kernel:  [hub_thread+53/272] hub_thread+0x35/0x110
kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
udev[15601]: removing device node '/dev/ttyUSB0'
udev[15608]: removing device node '/dev/ttyUSB1'

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
YORK (vb.)
To shift the position of the shoulder straps on a heavy bag or
rucksack in a vain attempt to make it seem lighter. Hence : to laugh
falsely and heartily at an unfunny remark. 'Jasmine yorked politely,
loathing him to the depths of her being' - Virginia Woolf.
			--- Douglas Adams, The Meaning of Liff

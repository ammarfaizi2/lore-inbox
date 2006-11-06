Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752945AbWKFMqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbWKFMqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752947AbWKFMqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:46:30 -0500
Received: from mx2.mail.ru ([194.67.23.122]:31520 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1752945AbWKFMq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:46:28 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-usb-devel@lists.sourceforge.net
Subject: 2.6.18.2: lockdep warnings on rmmod ohci_hcd
Date: Mon, 6 Nov 2006 15:46:47 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611061546.48062.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I presume this is lockdep; this looks initially truncated, unfortunately this 
is how it was stored in messages. I will try to get more complete output ig 
required.

- -andrey

   bor : TTY=pts/1 ; PWD=/tmp ; USER=root ; COMMAND=/sbin/rmmod ohci_hcd
+0x5d/0x360
                                [<00000000>] 0x0
       in-hardirq-W at:
                                [lock_acquire+93/128] lock_acquire+0x5d/0x80
                                [<c0133ccd>] lock_acquire+0x5d/0x80
                                [_spin_lock+44/64] _spin_lock+0x2c/0x40
                                [<c02aedec>] _spin_lock+0x2c/0x40
                                [scheduler_tick+199/768] 
scheduler_tick+0xc7/0x300
                                [<c0115557>] scheduler_tick+0xc7/0x300
                                [update_process_times+70/112] 
update_process_times+0x46/0x70
                                [<c0123206>] update_process_times+0x46/0x70
                                [timer_interrupt+65/160] 
timer_interrupt+0x41/0xa0
                                [<c01067b1>] timer_interrupt+0x41/0xa0
                                [handle_IRQ_event+51/112] 
handle_IRQ_event+0x33/0x70
                                [<c0146d43>] handle_IRQ_event+0x33/0x70
                                [__do_IRQ+137/272] __do_IRQ+0x89/0x110
                                [<c0146e09>] __do_IRQ+0x89/0x110
                                [do_IRQ+72/160] do_IRQ+0x48/0xa0
                                [<c01054b8>] do_IRQ+0x48/0xa0
                                [common_interrupt+37/44] 
common_interrupt+0x25/0x2c
                                [<c0103a75>] common_interrupt+0x25/0x2c
                                [printk+27/32] printk+0x1b/0x20
                                [<c011a0bb>] printk+0x1b/0x20
                                [populate_rootfs+65/256] 
populate_rootfs+0x41/0x100
                                [<c03bc191>] populate_rootfs+0x41/0x100
                                [init+53/656] init+0x35/0x290
                                [<c01002b5>] init+0x35/0x290
                                [kernel_thread_helper+5/16] 
kernel_thread_helper+0x5/0x10
                                [<c0101005>] kernel_thread_helper+0x5/0x10
       in-softirq-W at:
                                [lock_acquire+93/128] lock_acquire+0x5d/0x80
                                [<c0133ccd>] lock_acquire+0x5d/0x80
                                [_spin_lock+44/64] _spin_lock+0x2c/0x40
                                [<c02aedec>] _spin_lock+0x2c/0x40
                                [task_rq_lock+23/32] task_rq_lock+0x17/0x20
                                [<c0115ad7>] task_rq_lock+0x17/0x20
                                [try_to_wake_up+32/288] 
try_to_wake_up+0x20/0x120
                                [<c0115c20>] try_to_wake_up+0x20/0x120
                                [default_wake_function+11/16] 
default_wake_function+0xb/0x10
                                [<c0115d2b>] default_wake_function+0xb/0x10
                                [__wake_up_common+57/112] 
__wake_up_common+0x39/0x70
                                [<c0114dc9>] __wake_up_common+0x39/0x70
                                [complete+61/96] complete+0x3d/0x60
                                [<c01151bd>] complete+0x3d/0x60
                                [wakeme_after_rcu+11/16] 
wakeme_after_rcu+0xb/0x10
                                [<c012a74b>] wakeme_after_rcu+0xb/0x10
                                [__rcu_process_callbacks+105/448] 
__rcu_process_callbacks+0x69/0x1c0
                                [<c012a8e9>] 
__rcu_process_callbacks+0x69/0x1c0
                                [rcu_process_callbacks+18/48] 
rcu_process_callbacks+0x12/0x30
                                [<c012aa52>] rcu_process_callbacks+0x12/0x30
                                [tasklet_action+64/144] 
tasklet_action+0x40/0x90
                                [<c011e880>] tasklet_action+0x40/0x90
                                [__do_softirq+85/192] __do_softirq+0x55/0xc0
                                [<c011e785>] __do_softirq+0x55/0xc0
                                [do_softirq+70/80] do_softirq+0x46/0x50
                                [<c011e836>] do_softirq+0x46/0x50
                                [irq_exit+53/64] irq_exit+0x35/0x40
                                [<c011ec65>] irq_exit+0x35/0x40
                                [do_IRQ+77/160] do_IRQ+0x4d/0xa0
                                [<c01054bd>] do_IRQ+0x4d/0xa0
                                [common_interrupt+37/44] 
common_interrupt+0x25/0x2c
                                [<c0103a75>] common_interrupt+0x25/0x2c
                                [cpu_idle+57/80] cpu_idle+0x39/0x50
                                [<c0101c59>] cpu_idle+0x39/0x50
                                [rest_init+30/48] rest_init+0x1e/0x30
                                [<c010052e>] rest_init+0x1e/0x30
                                [start_kernel+691/864] 
start_kernel+0x2b3/0x360
                                [<c03b67c3>] start_kernel+0x2b3/0x360
                                [<00000000>] 0x0
     }
     ... key      at: [per_cpu__runqueues+2388/2396] 
per_cpu__runqueues+0x954/0x95c
     ... key      at: [<c03f1d54>] per_cpu__runqueues+0x954/0x95c
    ... acquired at:
   [lock_acquire+93/128] lock_acquire+0x5d/0x80
   [<c0133ccd>] lock_acquire+0x5d/0x80
   [_spin_lock+44/64] _spin_lock+0x2c/0x40
   [<c02aedec>] _spin_lock+0x2c/0x40
   [task_rq_lock+23/32] task_rq_lock+0x17/0x20
   [<c0115ad7>] task_rq_lock+0x17/0x20
   [try_to_wake_up+32/288] try_to_wake_up+0x20/0x120
   [<c0115c20>] try_to_wake_up+0x20/0x120
   [default_wake_function+11/16] default_wake_function+0xb/0x10
   [<c0115d2b>] default_wake_function+0xb/0x10
   [autoremove_wake_function+27/80] autoremove_wake_function+0x1b/0x50
   [<c012ccdb>] autoremove_wake_function+0x1b/0x50
   [__wake_up_common+57/112] __wake_up_common+0x39/0x70
   [<c0114dc9>] __wake_up_common+0x39/0x70
   [__wake_up+55/80] __wake_up+0x37/0x50
   [<c0115277>] __wake_up+0x37/0x50
   [<dfc9fd04>] kick_khubd+0x54/0x70 [usbcore]
   [<dfca049e>] hub_activate+0x4e/0xa0 [usbcore]
   [<dfca16ad>] hub_probe+0x59d/0x730 [usbcore]
   [<dfca6ca8>] usb_probe_interface+0x68/0xa0 [usbcore]
   [driver_probe_device+68/192] driver_probe_device+0x44/0xc0
   [<c021f974>] driver_probe_device+0x44/0xc0
   [__device_attach+8/16] __device_attach+0x8/0x10
   [<c021f9f8>] __device_attach+0x8/0x10
   [bus_for_each_drv+87/128] bus_for_each_drv+0x57/0x80
   [<c021f1c7>] bus_for_each_drv+0x57/0x80
   [device_attach+118/128] device_attach+0x76/0x80
   [<c021fa76>] device_attach+0x76/0x80
   [bus_attach_device+30/64] bus_attach_device+0x1e/0x40
   [<c021ee5e>] bus_attach_device+0x1e/0x40
   [device_add+620/816] device_add+0x26c/0x330
   [<c021defc>] device_add+0x26c/0x330
   [<dfca5e00>] usb_set_configuration+0x330/0x490 [usbcore]
   [<dfca0da5>] usb_new_device+0x1d5/0x300 [usbcore]
   [<dfca3917>] usb_add_hcd+0x447/0x5a0 [usbcore]
   [<dfcaca6f>] usb_hcd_pci_probe+0x19f/0x2b0 [usbcore]
   [pci_device_probe+94/128] pci_device_probe+0x5e/0x80
   [<c01ca83e>] pci_device_probe+0x5e/0x80
   [driver_probe_device+68/192] driver_probe_device+0x44/0xc0
   [<c021f974>] driver_probe_device+0x44/0xc0
   [__driver_attach+165/176] __driver_attach+0xa5/0xb0
   [<c021fb25>] __driver_attach+0xa5/0xb0
   [bus_for_each_dev+73/112] bus_for_each_dev+0x49/0x70
   [<c021f2d9>] bus_for_each_dev+0x49/0x70
   [driver_attach+25/32] driver_attach+0x19/0x20
   [<c021f8b9>] driver_attach+0x19/0x20
   [bus_add_driver+113/320] bus_add_driver+0x71/0x140
   [<c021eef1>] bus_add_driver+0x71/0x140
   [driver_register+93/144] driver_register+0x5d/0x90
   [<c021fdbd>] driver_register+0x5d/0x90
   [__pci_register_driver+80/112] __pci_register_driver+0x50/0x70
   [<c01ca9f0>] __pci_register_driver+0x50/0x70
   [<df820038>] ac97_bus_suspend+0x28/0x30 [snd_ac97_bus]
   [sys_init_module+301/6080] sys_init_module+0x12d/0x17c0
>] sys_init_module+0x12d/0x17c0
   [sysenter_past_esp+86/141] sysenter_past_esp+0x56/0x8d
   [<c0103009>] sysenter_past_esp+0x56/0x8d

   ... acquired at:
   [lock_acquire+93/128] lock_acquire+0x5d/0x80
   [<c0133ccd>] lock_acquire+0x5d/0x80
   [_spin_lock_irqsave+57/80] _spin_lock_irqsave+0x39/0x50
   [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
   [__wake_up+27/80] __wake_up+0x1b/0x50
   [<c011525b>] __wake_up+0x1b/0x50
   [<dfc9fd04>] kick_khubd+0x54/0x70 [usbcore]
   [<dfca049e>] hub_activate+0x4e/0xa0 [usbcore]
   [<dfca16ad>] hub_probe+0x59d/0x730 [usbcore]
   [<dfca6ca8>] usb_probe_interface+0x68/0xa0 [usbcore]
   [driver_probe_device+68/192] driver_probe_device+0x44/0xc0
   [<c021f974>] driver_probe_device+0x44/0xc0
   [__device_attach+8/16] __device_attach+0x8/0x10
   [<c021f9f8>] __device_attach+0x8/0x10
   [bus_for_each_drv+87/128] bus_for_each_drv+0x57/0x80
   [<c021f1c7>] bus_for_each_drv+0x57/0x80
   [device_attach+118/128] device_attach+0x76/0x80
   [<c021fa76>] device_attach+0x76/0x80
   [bus_attach_device+30/64] bus_attach_device+0x1e/0x40
   [<c021ee5e>] bus_attach_device+0x1e/0x40
   [device_add+620/816] device_add+0x26c/0x330
   [<c021defc>] device_add+0x26c/0x330
   [<dfca5e00>] usb_set_configuration+0x330/0x490 [usbcore]
   [<dfca0da5>] usb_new_device+0x1d5/0x300 [usbcore]
   [<dfca3917>] usb_add_hcd+0x447/0x5a0 [usbcore]
   [<dfcaca6f>] usb_hcd_pci_probe+0x19f/0x2b0 [usbcore]
   [pci_device_probe+94/128] pci_device_probe+0x5e/0x80
   [<c01ca83e>] pci_device_probe+0x5e/0x80
   [driver_probe_device+68/192] driver_probe_device+0x44/0xc0
   [<c021f974>] driver_probe_device+0x44/0xc0
   [__driver_attach+165/176] __driver_attach+0xa5/0xb0
   [<c021fb25>] __driver_attach+0xa5/0xb0
   [bus_for_each_dev+73/112] bus_for_each_dev+0x49/0x70
   [<c021f2d9>] bus_for_each_dev+0x49/0x70
   [driver_attach+25/32] driver_attach+0x19/0x20
   [<c021f8b9>] driver_attach+0x19/0x20
   [bus_add_driver+113/320] bus_add_driver+0x71/0x140
   [<c021eef1>] bus_add_driver+0x71/0x140
   [driver_register+93/144] driver_register+0x5d/0x90
   [<c021fdbd>] driver_register+0x5d/0x90
   [__pci_register_driver+80/112] __pci_register_driver+0x50/0x70
   [<c01ca9f0>] __pci_register_driver+0x50/0x70
   [<df820038>] ac97_bus_suspend+0x28/0x30 [snd_ac97_bus]
   [sys_init_module+301/6080] sys_init_module+0x12d/0x17c0
   [<c013948d>] sys_init_module+0x12d/0x17c0
   [sysenter_past_esp+86/141] sysenter_past_esp+0x56/0x8d
   [<c0103009>] sysenter_past_esp+0x56/0x8d

  ... acquired at:
   [lock_acquire+93/128] lock_acquire+0x5d/0x80
   [<c0133ccd>] lock_acquire+0x5d/0x80
   [_spin_lock_irqsave+57/80] _spin_lock_irqsave+0x39/0x50
   [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
   [<dfc9fcc8>] kick_khubd+0x18/0x70 [usbcore]
   [<dfc9fd3e>] usb_resume_root_hub+0x1e/0x20 [usbcore]
   [<dfca3a9c>] usb_hcd_resume_root_hub+0x2c/0x50 [usbcore]
   [<df86d838>] ohci_irq+0x128/0x1d0 [ohci_hcd]
   [<dfca3c17>] usb_hcd_irq+0x27/0x60 [usbcore]
   [handle_IRQ_event+51/112] handle_IRQ_event+0x33/0x70
   [<c0146d43>] handle_IRQ_event+0x33/0x70
   [__do_IRQ+137/272] __do_IRQ+0x89/0x110
   [<c0146e09>] __do_IRQ+0x89/0x110
   [do_IRQ+72/160] do_IRQ+0x48/0xa0
   [<c01054b8>] do_IRQ+0x48/0xa0
   [common_interrupt+37/44] common_interrupt+0x25/0x2c
   [<c0103a75>] common_interrupt+0x25/0x2c
   [<df86c474>] ohci_bus_suspend+0x104/0x1d0 [ohci_hcd]
   [<df86db22>] ohci_hub_status_data+0x242/0x260 [ohci_hcd]
   [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 [usbcore]
   [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
   [run_timer_softirq+345/384] run_timer_softirq+0x159/0x180
   [<c0122359>] run_timer_softirq+0x159/0x180
   [__do_softirq+85/192] __do_softirq+0x55/0xc0
   [<c011e785>] __do_softirq+0x55/0xc0
   [do_softirq+70/80] do_softirq+0x46/0x50
   [<c011e836>] do_softirq+0x46/0x50
   [irq_exit+53/64] irq_exit+0x35/0x40
   [<c011ec65>] irq_exit+0x35/0x40
   [do_IRQ+77/160] do_IRQ+0x4d/0xa0
   [<c01054bd>] do_IRQ+0x4d/0xa0
   [common_interrupt+37/44] common_interrupt+0x25/0x2c
   [<c0103a75>] common_interrupt+0x25/0x2c
   [up_read+22/37] up_read+0x16/0x25
   [<c0130266>] up_read+0x16/0x25
   [do_page_fault+1213/1536] do_page_fault+0x4bd/0x600
   [<c02b057d>] do_page_fault+0x4bd/0x600
   [error_code+57/64] error_code+0x39/0x40
   [<c0103b4d>] error_code+0x39/0x40

 ... acquired at:
   [lock_acquire+93/128] lock_acquire+0x5d/0x80
   [<c0133ccd>] lock_acquire+0x5d/0x80
   [_spin_lock+44/64] _spin_lock+0x2c/0x40
   [<c02aedec>] _spin_lock+0x2c/0x40
   [<dfca3ad1>] usb_hcd_suspend_root_hub+0x11/0x90 [usbcore]
   [<df86c46a>] ohci_bus_suspend+0xfa/0x1d0 [ohci_hcd]
   [<df86db22>] ohci_hub_status_data+0x242/0x260 [ohci_hcd]
   [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 [usbcore]
   [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
   [run_timer_softirq+345/384] run_timer_softirq+0x159/0x180
   [<c0122359>] run_timer_softirq+0x159/0x180
   [__do_softirq+85/192] __do_softirq+0x55/0xc0
   [<c011e785>] __do_softirq+0x55/0xc0
   [do_softirq+70/80] do_softirq+0x46/0x50
   [<c011e836>] do_softirq+0x46/0x50
   [irq_exit+53/64] irq_exit+0x35/0x40
   [<c011ec65>] irq_exit+0x35/0x40
   [do_IRQ+77/160] do_IRQ+0x4d/0xa0
   [<c01054bd>] do_IRQ+0x4d/0xa0
   [common_interrupt+37/44] common_interrupt+0x25/0x2c
   [<c0103a75>] common_interrupt+0x25/0x2c
   [up_read+22/37] up_read+0x16/0x25
   [<c0130266>] up_read+0x16/0x25
   [do_page_fault+1213/1536] do_page_fault+0x4bd/0x600
   [<c02b057d>] do_page_fault+0x4bd/0x600
   [error_code+57/64] error_code+0x39/0x40
   [<c0103b4d>] error_code+0x39/0x40

 -> (hcd_data_lock){-+..} ops: 0 {
    initial-use  at:
                          [lock_acquire+93/128] lock_acquire+0x5d/0x80
                          [<c0133ccd>] lock_acquire+0x5d/0x80
                          [_spin_lock_irqsave+57/80] 
_spin_lock_irqsave+0x39/0x50
                          [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                          [<dfca3ea6>] hcd_submit_urb+0x36/0x950 [usbcore]
                          [<dfca4acc>] usb_submit_urb+0x19c/0x200 [usbcore]
                          [<dfca537e>] usb_start_wait_urb+0x3e/0xf0 [usbcore]
                          [<dfca565b>] usb_control_msg+0xcb/0xf0 [usbcore]
                          [<dfca5fe8>] usb_get_descriptor+0x88/0xc0 [usbcore]
                          [<dfca62e3>] usb_get_device_descriptor+0x63/0x90 
[usbcore]
                          [<dfca37ca>] usb_add_hcd+0x2fa/0x5a0 [usbcore]
                          [<dfcaca6f>] usb_hcd_pci_probe+0x19f/0x2b0 [usbcore]
                          [pci_device_probe+94/128] pci_device_probe+0x5e/0x80
                          [<c01ca83e>] pci_device_probe+0x5e/0x80
                          [driver_probe_device+68/192] 
driver_probe_device+0x44/0xc0
                          [<c021f974>] driver_probe_device+0x44/0xc0
                          [__driver_attach+165/176] __driver_attach+0xa5/0xb0
                          [<c021fb25>] __driver_attach+0xa5/0xb0
                          [bus_for_each_dev+73/112] bus_for_each_dev+0x49/0x70
                          [<c021f2d9>] bus_for_each_dev+0x49/0x70
                          [driver_attach+25/32] driver_attach+0x19/0x20
                          [<c021f8b9>] driver_attach+0x19/0x20
                          [bus_add_driver+113/320] bus_add_driver+0x71/0x140
                          [<c021eef1>] bus_add_driver+0x71/0x140
                          [driver_register+93/144] driver_register+0x5d/0x90
                          [<c021fdbd>] driver_register+0x5d/0x90
                          [__pci_register_driver+80/112] 
__pci_register_driver+0x50/0x70
                          [<c01ca9f0>] __pci_register_driver+0x50/0x70
                          [<df820038>] ac97_bus_suspend+0x28/0x30 
[snd_ac97_bus]
                          [sys_init_module+301/6080] 
sys_init_module+0x12d/0x17c0
                          [<c013948d>] sys_init_module+0x12d/0x17c0
                          [sysenter_past_esp+86/141] 
sysenter_past_esp+0x56/0x8d
                          [<c0103009>] sysenter_past_esp+0x56/0x8d
    in-softirq-W at:
                          [lock_acquire+93/128] lock_acquire+0x5d/0x80
                          [<c0133ccd>] lock_acquire+0x5d/0x80
                          [_spin_lock_irqsave+57/80] 
_spin_lock_irqsave+0x39/0x50
                          [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                          [<dfca2e9f>] urb_unlink+0x2f/0x60 [usbcore]
                          [<dfca2ee7>] usb_hcd_giveback_urb+0x17/0x60 
[usbcore]
                          [<dfca3b2f>] usb_hcd_suspend_root_hub+0x6f/0x90 
[usbcore]
                          [<df86c46a>] ohci_bus_suspend+0xfa/0x1d0 [ohci_hcd]
                          [<df86db22>] ohci_hub_status_data+0x242/0x260 
[ohci_hcd]
                          [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 
[usbcore]
                          [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
                          [run_timer_softirq+345/384] 
run_timer_softirq+0x159/0x180
                          [<c0122359>] run_timer_softirq+0x159/0x180
                          [__do_softirq+85/192] __do_softirq+0x55/0xc0
                          [<c011e785>] __do_softirq+0x55/0xc0
                          [do_softirq+70/80] do_softirq+0x46/0x50
                          [<c011e836>] do_softirq+0x46/0x50
                          [irq_exit+53/64] irq_exit+0x35/0x40
                          [<c011ec65>] irq_exit+0x35/0x40
                          [do_IRQ+77/160] do_IRQ+0x4d/0xa0
                          [<c01054bd>] do_IRQ+0x4d/0xa0
                          [common_interrupt+37/44] common_interrupt+0x25/0x2c
                          [<c0103a75>] common_interrupt+0x25/0x2c
                          [up_read+22/37] up_read+0x16/0x25
                          [<c0130266>] up_read+0x16/0x25
                          [do_page_fault+1213/1536] do_page_fault+0x4bd/0x600
                          [<c02b057d>] do_page_fault+0x4bd/0x600
                          [error_code+57/64] error_code+0x39/0x40
                          [<c0103b4d>] error_code+0x39/0x40
    hardirq-on-W at:
                          [lock_acquire+93/128] lock_acquire+0x5d/0x80
                          [<c0133ccd>] lock_acquire+0x5d/0x80
                          [_spin_lock+44/64] _spin_lock+0x2c/0x40
                          [<c02aedec>] _spin_lock+0x2c/0x40
                          [<dfca30bf>] hcd_endpoint_disable+0x3f/0x140 
[usbcore]
                          [<dfca4c4d>] usb_disable_endpoint+0x3d/0x60 
[usbcore]
                          [<dfca4dc7>] usb_disable_device+0x37/0x100 [usbcore]
                          [<dfca0f74>] usb_disconnect+0xa4/0x100 [usbcore]
                          [<dfca2d6b>] usb_remove_hcd+0x7b/0xd0 [usbcore]
                          [<dfcac870>] usb_hcd_pci_remove+0x20/0x80 [usbcore]
                          [pci_device_remove+25/48] 
pci_device_remove+0x19/0x30
                          [<c01ca6a9>] pci_device_remove+0x19/0x30
                          [__device_release_driver+100/144] 
__device_release_driver+0x64/0x90
                          [<c021f874>] __device_release_driver+0x64/0x90
                          [driver_detach+227/229] driver_detach+0xe3/0xe5
                          [<c021fc53>] driver_detach+0xe3/0xe5
                          [bus_remove_driver+108/144] 
bus_remove_driver+0x6c/0x90
                          [<c021ee1c>] bus_remove_driver+0x6c/0x90
                          [driver_unregister+11/32] driver_unregister+0xb/0x20
                          [<c021fd4b>] driver_unregister+0xb/0x20
                          [pci_unregister_driver+19/128] 
pci_unregister_driver+0x13/0x80
                          [<c01ca873>] pci_unregister_driver+0x13/0x80
                          [<df86dfed>] ohci_hcd_pci_cleanup+0xd/0x15 
[ohci_hcd]
                          [sys_delete_module+325/432] 
sys_delete_module+0x145/0x1b0
                          [<c0138c35>] sys_delete_module+0x145/0x1b0
                          [sysenter_past_esp+86/141] 
sysenter_past_esp+0x56/0x8d
                          [<c0103009>] sysenter_past_esp+0x56/0x8d
  }
  ... key      at: [<dfcbeb9c>] hcd_data_lock+0x1c/0xfffef9e9 [usbcore]
 ... acquired at:
   [lock_acquire+93/128] lock_acquire+0x5d/0x80
   [<c0133ccd>] lock_acquire+0x5d/0x80
   [_spin_lock_irqsave+57/80] _spin_lock_irqsave+0x39/0x50
   [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
   [<dfca2e9f>] urb_unlink+0x2f/0x60 [usbcore]
   [<dfca2ee7>] usb_hcd_giveback_urb+0x17/0x60 [usbcore]
   [<dfca3b2f>] usb_hcd_suspend_root_hub+0x6f/0x90 [usbcore]
   [<df86c46a>] ohci_bus_suspend+0xfa/0x1d0 [ohci_hcd]
   [<df86db22>] ohci_hub_status_data+0x242/0x260 [ohci_hcd]
   [<dfca31fd>] usb_hcd_poll_rh_status+0x3d/0x1a0 [usbcore]
   [<dfca3368>] rh_timer_func+0x8/0x10 [usbcore]
   [run_timer_softirq+345/384] run_timer_softirq+0x159/0x180
   [<c0122359>] run_timer_softirq+0x159/0x180
   [__do_softirq+85/192] __do_softirq+0x55/0xc0
   [<c011e785>] __do_softirq+0x55/0xc0
   [do_softirq+70/80] do_softirq+0x46/0x50
   [<c011e836>] do_softirq+0x46/0x50
   [irq_exit+53/64] irq_exit+0x35/0x40
   [<c011ec65>] irq_exit+0x35/0x40
   [do_IRQ+77/160] do_IRQ+0x4d/0xa0
   [<c01054bd>] do_IRQ+0x4d/0xa0
   [common_interrupt+37/44] common_interrupt+0x25/0x2c
   [<c0103a75>] common_interrupt+0x25/0x2c
   [up_read+22/37] up_read+0x16/0x25
   [<c0130266>] up_read+0x16/0x25
   [do_page_fault+1213/1536] do_page_fault+0x4bd/0x600
   [<c02b057d>] do_page_fault+0x4bd/0x600
   [error_code+57/64] error_code+0x39/0x40
   [<c0103b4d>] error_code+0x39/0x40

 -> (device_state_lock){....} ops: 0 {
    initial-use  at:
                          [lock_acquire+93/128] lock_acquire+0x5d/0x80
                          [<c0133ccd>] lock_acquire+0x5d/0x80
                          [_spin_lock_irqsave+57/80] 
_spin_lock_irqsave+0x39/0x50
                          [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
                          [<dfc9f2af>] usb_set_device_state+0x1f/0xc0 
[usbcore]
                          [<dfca37ae>] usb_add_hcd+0x2de/0x5a0 [usbcore]
                          [<dfcaca6f>] usb_hcd_pci_probe+0x19f/0x2b0 [usbcore]
                          [pci_device_probe+94/128] pci_device_probe+0x5e/0x80
                          [<c01ca83e>] pci_device_probe+0x5e/0x80
                          [driver_probe_device+68/192] 
driver_probe_device+0x44/0xc0
                          [<c021f974>] driver_probe_device+0x44/0xc0
                          [__driver_attach+165/176] __driver_attach+0xa5/0xb0
                          [<c021fb25>] __driver_attach+0xa5/0xb0
                          [bus_for_each_dev+73/112] bus_for_each_dev+0x49/0x70
                          [<c021f2d9>] bus_for_each_dev+0x49/0x70
                          [driver_attach+25/32] driver_attach+0x19/0x20
                          [<c021f8b9>] driver_attach+0x19/0x20
                          [bus_add_driver+113/320] bus_add_driver+0x71/0x140
                          [<c021eef1>] bus_add_driver+0x71/0x140
                          [driver_register+93/144] driver_register+0x5d/0x90
                          [<c021fdbd>] driver_register+0x5d/0x90
                          [__pci_register_driver+80/112] 
__pci_register_driver+0x50/0x70
                          [<c01ca9f0>] __pci_register_driver+0x50/0x70
                          [<df820038>] ac97_bus_suspend+0x28/0x30 
[snd_ac97_bus]
                          [sys_init_module+301/6080] 
sys_init_module+0x12d/0x17c0
                          [<c013948d>] sys_init_module+0x12d/0x17c0
                          [sysenter_past_esp+86/141] 
sysenter_past_esp+0x56/0x8d
                          [<c0103009>] sysenter_past_esp+0x56/0x8d
  }
  ... key      at: [<dfcbe9dc>] device_state_lock+0x1c/0xfffefba9 [usbcore]
 ... acquired at:
   [lock_acquire+93/128] lock_acquire+0x5d/0x80
   [<c0133ccd>] lock_acquire+0x5d/0x80
   [_spin_lock_irqsave+57/80] _spin_lock_irqsave+0x39/0x50
   [<c02af2a9>] _spin_lock_irqsave+0x39/0x50
   [<dfca2637>] usb_root_hub_lost_power+0x37/0xa0 [usbcore]
   [<df86dbe6>] ohci_bus_resume+0xa6/0x478 [ohci_hcd]
   [<dfca349c>] hcd_bus_resume+0x3c/0x70 [usbcore]
   [<dfca0a1d>] hub_resume+0x13d/0x150 [usbcore]
   [<dfc9e224>] usb_generic_resume+0x64/0x110 [usbcore]
   [<dfca077c>] finish_device_resume+0xac/0x140 [usbcore]
   [<dfca2765>] usb_resume_device+0x85/0x90 [usbcore]
   [<dfc9e294>] usb_generic_resume+0xd4/0x110 [usbcore]
   [resume_device+102/208] resume_device+0x66/0xd0
   [<c0223756>] resume_device+0x66/0xd0
   [dpm_resume+183/208] dpm_resume+0xb7/0xd0
   [<c02238f7>] dpm_resume+0xb7/0xd0
   [device_resume+36/46] device_resume+0x24/0x2e
   [<c0223934>] device_resume+0x24/0x2e
   [pm_suspend_disk+165/256] pm_suspend_disk+0xa5/0x100
   [<c013d815>] pm_suspend_disk+0xa5/0x100
   [enter_state+316/368] enter_state+0x13c/0x170
   [<c013c74c>] enter_state+0x13c/0x170
   [state_store+166/176] state_store+0xa6/0xb0
   [<c013c826>] state_store+0xa6/0xb0
   [subsys_attr_store+43/64] subsys_attr_store+0x2b/0x40
   [<c01a051b>] subsys_attr_store+0x2b/0x40
   [sysfs_write_file+163/256] sysfs_write_file+0xa3/0x100
   [<c01a0823>] sysfs_write_file+0xa3/0x100
   [vfs_write+153/352] vfs_write+0x99/0x160
   [<c0167299>] vfs_write+0x99/0x160
   [sys_write+61/112] sys_write+0x3d/0x70
   [<c01678cd>] sys_write+0x3d/0x70
   [sysenter_past_esp+86/141] sysenter_past_esp+0x56/0x8d
   [<c0103009>] sysenter_past_esp+0x56/0x8d


stack backtrace:
 [show_trace_log_lvl+389/416] show_trace_log_lvl+0x185/0x1a0
 [<c0104195>] show_trace_log_lvl+0x185/0x1a0
 [show_trace+18/32] show_trace+0x12/0x20
 [<c01047a2>] show_trace+0x12/0x20
 [dump_stack+25/32] dump_stack+0x19/0x20
 [<c0104879>] dump_stack+0x19/0x20
 [print_irq_inversion_bug+263/304] print_irq_inversion_bug+0x107/0x130
 [<c0131c37>] print_irq_inversion_bug+0x107/0x130
 [check_usage_backwards+66/80] check_usage_backwards+0x42/0x50
 [<c0131d92>] check_usage_backwards+0x42/0x50
 [mark_lock+399/1472] mark_lock+0x18f/0x5c0
 [<c013201f>] mark_lock+0x18f/0x5c0
 [__lock_acquire+262/3328] __lock_acquire+0x106/0xd00
 [<c0132d96>] __lock_acquire+0x106/0xd00
 [lock_acquire+93/128] lock_acquire+0x5d/0x80
 [<c0133ccd>] lock_acquire+0x5d/0x80
 [_spin_lock+44/64] _spin_lock+0x2c/0x40
 [<c02aedec>] _spin_lock+0x2c/0x40
 [<dfca30bf>] hcd_endpoint_disable+0x3f/0x140 [usbcore]
 [<dfca4c4d>] usb_disable_endpoint+0x3d/0x60 [usbcore]
 [<dfca4dc7>] usb_disable_device+0x37/0x100 [usbcore]
 [<dfca0f74>] usb_disconnect+0xa4/0x100 [usbcore]
 [<dfca2d6b>] usb_remove_hcd+0x7b/0xd0 [usbcore]
 [<dfcac870>] usb_hcd_pci_remove+0x20/0x80 [usbcore]
 [pci_device_remove+25/48] pci_device_remove+0x19/0x30
 [<c01ca6a9>] pci_device_remove+0x19/0x30
 [__device_release_driver+100/144] __device_release_driver+0x64/0x90
 [<c021f874>] __device_release_driver+0x64/0x90
 [driver_detach+227/229] driver_detach+0xe3/0xe5
 [<c021fc53>] driver_detach+0xe3/0xe5
 [bus_remove_driver+108/144] bus_remove_driver+0x6c/0x90
 [<c021ee1c>] bus_remove_driver+0x6c/0x90
 [driver_unregister+11/32] driver_unregister+0xb/0x20
 [<c021fd4b>] driver_unregister+0xb/0x20
 [pci_unregister_driver+19/128] pci_unregister_driver+0x13/0x80
 [<c01ca873>] pci_unregister_driver+0x13/0x80
 [<df86dfed>] ohci_hcd_pci_cleanup+0xd/0x15 [ohci_hcd]
 [sys_delete_module+325/432] sys_delete_module+0x145/0x1b0
 [<c0138c35>] sys_delete_module+0x145/0x1b0
 [sysenter_past_esp+86/141] sysenter_past_esp+0x56/0x8d
 [<c0103009>] sysenter_past_esp+0x56/0x8d
 [phys_startup_32+-1209408496/-1073741824] 0xb7f9e410
 [<b7f9e410>] 0xb7f9e410
ohci_hcd 0000:00:02.0: USB bus 1 deregistered
ACPI: PCI interrupt for device 0000:00:02.0 disabled
   bor : TTY=pts/1 ; PWD=/tmp ; USER=root ; COMMAND=/sbin/rmmod usbcore
usbcore: deregistering driver usbfs
usbcore: deregistering driver hub
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFTy64R6LMutpd94wRAsj1AJ0TcyAAgsjxy03wiY90jyRcQa34vgCeJNYM
VS2ehAPOi/p3xniCfPxKZs4=
=T5rC
-----END PGP SIGNATURE-----

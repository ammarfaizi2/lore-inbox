Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbSI1Ae4>; Fri, 27 Sep 2002 20:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262656AbSI1Aez>; Fri, 27 Sep 2002 20:34:55 -0400
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:44508 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S262655AbSI1Aez>; Fri, 27 Sep 2002 20:34:55 -0400
Message-ID: <3D94FB23.9040109@easynet.be>
Date: Sat, 28 Sep 2002 02:43:15 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: (more) Sleeping function called from illegal context...
References: <20020927233044.GA14234@kroah.com> <3D94EEBF.D6328392@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_PREEMPT=y on an SMP AMD (2CPU):

Sleeping function called from illegal context at /kernel/l-2.5.39/include/asm/semaphore.h:119
c1b75e20 c0117094 c0280b00 c028d480 00000077 c1b41cf0 c016bcf9 c028d480
        00000077 c1b41c50 ffffffea c1b74000 00001000 c01937c6 c02e9578 c1b41cf0
        c1b41c50 f7f0b840 c1b75eda c018ad0a c1b41c50 c02e9578 00000020 00000000
Call Trace:
  [<c0117094>]__might_sleep+0x54/0x58
  [<c016bcf9>]driverfs_create_file+0x39/0xa0
  [<c01937c6>]device_create_file+0x26/0x40
  [<c018ad0a>]pci_pool_create+0xea/0x170
  [<c02034af>]hcd_buffer_create+0x3f/0x80
  [<c02039c3>]usb_hcd_pci_probe+0x253/0x370
  [<c01563d8>]alloc_inode+0x58/0x190
  [<c018b751>]pci_device_probe+0x41/0x60
  [<c0191b88>]probe+0x18/0x30
  [<c0191c2b>]found_match+0x2b/0x60
  [<c0191d57>]do_driver_attach+0x37/0x50
  [<c019296c>]bus_for_each_dev+0x9c/0x130
  [<c0191d83>]driver_attach+0x13/0x20
  [<c0191d20>]do_driver_attach+0x0/0x50
  [<c0192ee4>]driver_register+0x94/0xb0
  [<c018b856>]pci_register_driver+0x36/0x50
  [<c01050b7>]init+0x47/0x1c0
  [<c0105070>]init+0x0/0x1c0
  [<c010553d>]kernel_thread_helper+0x5/0x18



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266406AbSKGICp>; Thu, 7 Nov 2002 03:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266407AbSKGICp>; Thu, 7 Nov 2002 03:02:45 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:46551 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S266406AbSKGICo> convert rfc822-to-8bit;
	Thu, 7 Nov 2002 03:02:44 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Irfan Hamid <irfan_hamid@softhome.net>
Reply-To: irfan_hamid@softhome.net
Organization: Air Weapons Complex
To: linux-kernel@vger.kernel.org
Subject: PCI card char driver
Date: Thu, 7 Nov 2002 14:12:18 +0000
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211071412.18719.irfan_hamid@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to write a device driver for a PCI data acquisition device. So i 
startet writing a char driver for it. Problem is, now I'm confused, I mean, 
if its a pci device then i need to call register_pci_driver(struct pci_dev*), 
but a struct pci_dev* has only hooks like (*suspend) ( ), (*probe) ( ) etc... 
where do i fit in my read( ) / write( ) / ioctl( ) etc hooks?

I looked up some char driver sources, the only thing I could find was 
something called a struct misc_driver which contains a struct file_ops* and 
is registered using misc_register(struct misc_driver*). What am I missing 
here?

Regards,
Irfan.

PS: I have read "Linux Device Drivers" by Alessandro Rubini and also have it 
on hand. So if someone could point me to somewhere in that book it would be 
just as well. TIA.

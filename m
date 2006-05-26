Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWEZSW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWEZSW6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWEZSW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:22:58 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:45798 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1751239AbWEZSW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:22:58 -0400
Date: Fri, 26 May 2006 20:22:17 +0200
From: Frank Gevaerts <frank.gevaerts@fks.be>
To: linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: usb-serial ipaq kernel problem
Message-ID: <20060526182217.GA12687@fks.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-FKS-MailScanner: Found to be clean
X-FKS-MailScanner-SpamCheck: geen spam, SpamAssassin (score=-105.812,
	vereist 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.09,
	BAYES_00 -2.60, USER_IN_WHITELIST -100.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got this when disconnecting an ipaq with 2,6,17rc4.

Frank

usb 1-4.5.7: USB disconnect, address 79
------------[ cut here ]------------
kernel BUG at kernel/workqueue.c:110!
invalid opcode: 0000 [#1]
Modules linked in: uhci_hcd ohci_hcd ehci_hcd ppp_deflate zlib_deflate bsd_comp ppp_async crc_ccitt ppp_generic slhc usbhid ipaq usbserial usbcore 8139too mii sr_mod sbp2 scsi_mod ieee1394 psmouse ide_generic ide_cd cdrom genrtc ext3 jbd mbcache ide_disk generic via82cxxx ide_core evdev mousedev
CPU:    0
EIP:    0060:[<b0121c03>]    Not tainted VLI
EFLAGS: 00010213   (2.6.17-rc4 #3) 
EIP is at queue_work+0x17/0x2f
eax: c1e5193c   ebx: b13f2a40   ecx: 00000000   edx: c1e51938
esi: c7104160   edi: b9c90a14   ebp: 00000000   esp: c92bbeb8
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 1559, threadinfo=c92ba000 task=cbf6c050)
Stack: <0>c7104160 cc985ace c1e51800 b9c90a00 cc9cd980 cc9cd9a4 b9c90a14 cc9dd838 
       b9c90a00 b9c90a7c b9c90a14 b01fb254 b9c90a14 b9c90a14 00000000 cc9f0ba0 
       b01fb419 b9c90a14 b01fac3d b9c90a14 b9c90a5c b9c90a14 c8913058 00000000 
Call Trace:
 <cc985ace> usb_serial_disconnect+0x59/0xa1 [usbserial]   <cc9dd838> usb_unbind_interface+0x36/0x6f [usbcore]
 <b01fb254> __device_release_driver+0x5c/0x72   <b01fb419> device_release_driver+0x18/0x26
 <b01fac3d> bus_remove_device+0x74/0x8c   <b01fa0cc> device_del+0x39/0x65
 <cc9dcaa1> usb_disable_device+0x6a/0xd4 [usbcore]   <cc9d9225> usb_disconnect+0x7c/0xc9 [usbcore]
 <cc9d9f3d> hub_thread+0x35b/0x9eb [usbcore]   <b0123f84> autoremove_wake_function+0x0/0x3a
 <b0123f36> kthread+0x80/0xc1   <cc9d9be2> hub_thread+0x0/0x9eb [usbcore]
 <b0123f4a> kthread+0x94/0xc1   <b0123eb6> kthread+0x0/0xc1
 <b0101005> kernel_thread_helper+0x5/0xb  
Code: 89 d8 5b 5e 5f c3 89 d1 89 c2 a1 f4 71 32 b0 e9 86 ff ff ff 53 89 c3 0f ba 2a 00 19 c0 31 c9 85 c0 75 1c 8d 42 04 39 42 04 74 08 <0f> 0b 6e 00 64 61 27 b0 8b 03 e8 4a fc ff ff b9 01 00 00 00 5b 
EIP: [<b0121c03>] queue_work+0x17/0x2f SS:ESP 0068:c92bbeb8

-- 
Frank Gevaerts                                 frank.gevaerts@fks.be
fks bvba - Formal and Knowledge Systems        http://www.fks.be/
Stationsstraat 108                             Tel:  ++32-(0)11-21 49 11
B-3570 ALKEN                                   Fax:  ++32-(0)11-22 04 19

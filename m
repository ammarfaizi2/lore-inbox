Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbVLLOSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbVLLOSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 09:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVLLOSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 09:18:24 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:45273 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751043AbVLLOSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 09:18:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=XiMIOaUlHrSS6HSTcykHKciCJU606fMMq8jsscBIBv1bFUKTiZ9SB0rnaUYirH84ay7Eo9sJJFPX+wpibtlGDAjfQKkFmGXNpTI3n8u9TB4Z22qe7w6Mhm2b+/D55TLb8L+1udrFScPOjkaVIfVnWV48ScWqQD9UJsarh9SoAjE=
Date: Mon, 12 Dec 2005 15:18:20 +0100
From: Diego Calleja <diegocg@gmail.com>
To: luca.risolia@studio.unibo.it
Cc: linux-kernel@vger.kernel.org
Subject: Oops with w9968cf
Message-Id: <20051212151820.5656ddd8.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While playing with the webcam support in kde 3.5 (kopete), creative 
webcam go plus.... (2.6.15-rc5)

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c019b162
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: ovcamchip w9968cf videodev i2c_core ipt_REJECT radeon drm thermal fan button processor ac battery ipt_MASQUERADE iptable_nat ip_nat ip_conntrack iptable_filter ip_tables usbhid snd_ca0106 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm parport_pc floppy snd_timer parport ohci_hcd snd pcspkr usbcore e100 soundcore snd_ac97_bus snd_page_alloc
CPU:    0
EIP:    0060:[<c019b162>]    Not tainted VLI
EFLAGS: 00010246   (2.6.15-rc5)
EIP is at sysfs_hash_and_remove+0x22/0xef
eax: f4789bc8   ebx: f76338a8   ecx: c19b2d40   edx: c533de44
esi: 00000000   edi: f6a79600   ebp: f8962f40   esp: ec721f04
ds: 007b   es: 007b   ss: 0068
Process kopete (pid: 21843, threadinfo=ec721000 task=c91bfab0)
Stack: f6a79600 f4789bc8 e9ce0788 f76338a8 f76338a0 f6a79600 f8962f40 c022e426
       00000000 f8962fbc f76338a0 f8870f00 f7094830 f387ed08 c022e488 f4bc0000
       f89617c2 ec721f54 f89c1deb f89c8abc f8870f00 f4bc00bc 00000000 f4bc0000
Call Trace:
 [<c022e426>] class_device_del+0xa6/0x100
 [<c022e488>] class_device_unregister+0x8/0x10
 [<f89617c2>] video_unregister_device+0x32/0x4d [videodev]
 [<f89c1deb>] w9968cf_release_resources+0x3b/0xf0 [w9968cf]
 [<f89c24d0>] w9968cf_release+0x40/0x100 [w9968cf]
 [<c0163a01>] __fput+0x91/0x180
 [<c0162097>] filp_close+0x47/0x90
 [<c0103061>] syscall_call+0x7/0xb
Code: 26 00 8d bc 27 00 00 00 00 55 57 56 53 83 ec 0c 89 44 24 04 89 14 24 8b 50 10 8b 70 58 85 d2 74 73 f0 ff 4a 78 0f 88 cd 00 00 00 <8b> 46 0c 8d 68 fc 8b 4d 04 0f 18 01 90 83 c6 0c 89 c3 39 f0 89
 <6>usb 1-1: OV7620 image sensor initialized
usb 1-1: USB disconnect, address 5
usb 1-1: Disconnecting Creative Labs Video Blaster WebCam Go Plus...

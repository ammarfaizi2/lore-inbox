Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUDGGue (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 02:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264109AbUDGGue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 02:50:34 -0400
Received: from main.gmane.org ([80.91.224.249]:26566 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264117AbUDGGuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 02:50:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Daniel Pittman <daniel@rimspace.net>
Subject: USB/BlueTooth oops in 2.6.5
Date: Wed, 07 Apr 2004 16:33:58 +1000
Message-ID: <877jwse1pl.fsf@enki.rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: m029-045.nv.iinet.net.au
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.5 (celeriac, linux)
Cancel-Lock: sha1:3a5uvosrfIUSWtMNRXVoIhWeKwQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to turn on the BlueTooth interface in my laptop, it turns on
a USB device.  Doing that with 2.6.5 generates the following error.

  Daniel

usb 3-1: new full speed USB device using address 2
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c02c43b2
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02c43b2>]    Not tainted
EFLAGS: 00010296   (2.6.5-enki) 
EIP is at usb_disable_interface+0x14/0x46
eax: d24ca780   ebx: 00000000   ecx: 00000282   edx: dff6f100
esi: 00000002   edi: 00000000   ebp: d4dedc00   esp: dfdafd48
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5, threadinfo=dfdae000 task=dff0e080)
Stack: 00000002 0000000b 00000001 00000002 ce3dcdb0 d4dedc00 c02c4608 d4dedc00 
       d24ca780 0000000b 00000001 00000002 00000001 00000000 00000000 00001388 
       00000000 d24ca780 00000000 d59f9880 d59f9938 d24cac80 c02f283d d4dedc00 
Call Trace:
 [<c02c4608>] usb_set_interface+0xb7/0x173
 [<c02f283d>] hci_usb_probe+0x22f/0x480
 [<c015a392>] alloc_inode+0x146/0x14b
 [<c01715f5>] sysfs_new_inode+0x5d/0xa2
 [<c02bf03b>] usb_probe_interface+0x61/0x6e
 [<c024b86d>] bus_match+0x3f/0x6a
 [<c024b8d9>] device_attach+0x41/0x91
 [<c024ba98>] bus_add_device+0x5b/0x9f
 [<c024aad4>] device_add+0xa1/0x120
 [<c02c4996>] usb_set_configuration+0x1d4/0x25f
 [<c02bfdc2>] usb_new_device+0x250/0x3c3
 [<c02c14f1>] hub_port_connect_change+0x177/0x274
 [<c02c1895>] hub_events+0x2a7/0x2fa
 [<c02c1915>] hub_thread+0x2d/0xe4
 [<c0116159>] default_wake_function+0x0/0x12
 [<c02c18e8>] hub_thread+0x0/0xe4
 [<c0104d1d>] kernel_thread_helper+0x5/0xb

Code: 80 7b 04 00 74 24 31 f6 8b 43 0c 83 c7 01 0f b6 44 30 02 83 

-- 
Glass is, we now know, a 'slow liquid;' and we're slow dust.
        -- Albert Goldbarth


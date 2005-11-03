Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVKCJKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVKCJKn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 04:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVKCJKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 04:10:43 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:65179 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751267AbVKCJKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 04:10:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=bZqKPemcOMRSON68f6QiBNJCM9OGDeh+8lFI5U4k9IDDJvipYCsmRHOZZnhVgs+NiYfWRdqNGa+gwy7Q04ILDp0yza22SZ3Yoh4KinFJZ/QcZbzZxrDnef2nk+uP4+6Qo4ANUp7BW/i8+ioGsw4T7N6ORkrPobHB8o8eWU5By84=
Message-ID: <4369D3C6.4060806@gmail.com>
Date: Thu, 03 Nov 2005 10:09:26 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: 2.6.14-git4 suspend fails: kernel NULL pointer dereference
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

echo shutdown > /sys/power/disk
echo disk > /sys/power/state

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c0132a5e
*pde = 00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c0132a5e>]    Not tainted VLI
EFLAGS: 00010286   (2.6.14-git4)
EIP is at enter_state+0xe/0x90
eax: 00000000   ebx: c03b1178   ecx: ffffffff   edx: d1c25000
esi: 00000004   edi: c03b117c   ebp: 00000004   esp: ddf09ef0
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 21862, threadinfo=ddf08000 task=dcf9b540)
Stack: c03e82cc c03b1178 d1c25004 c0132c4c 00000004 00000004 00000000
00000001
       c03e7de0 c03e7e34 ddf09fa4 b7d4c000 c018c6d7 c03e7de0 d1c25000
00000005
       c03eb460 c018c97e c03e7df0 c03e7e34 d1c25000 00000005 d62d4c60
d3ef8980
Call Trace:
 [<c0132c4c>] state_store+0x9c/0xaf
 [<c018c6d7>] subsys_attr_store+0x37/0x40
 [<c018c97e>] flush_write_buffer+0x3e/0x50
 [<c018c9e9>] sysfs_write_file+0x59/0x80
 [<c0155f8c>] vfs_write+0x14c/0x160
 [<c0156071>] sys_write+0x51/0x80
 [<c0102cbf>] sysenter_past_esp+0x54/0x75
Code: ff 50 10 e8 75 04 00 00 58 5b e9 ce 05 00 00 8d b4 26 00 00 00 00
8d bc 27 00 00 00 00 56 53 83 ec 04 a1 00 e0 48 c0 8b 74 24 10 <8b> 58
04 85 db 75 52 ff 0d a0 7d 3e c0 0f 88 0e 02 00 00 31 c0



i had 2.6.14-rc2-git4 working, didn't try other rc releases.

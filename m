Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTHFNuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 09:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTHFNuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 09:50:03 -0400
Received: from mail.cybertrails.com ([162.42.150.35]:8723 "EHLO
	mail4.cybertrails.com") by vger.kernel.org with ESMTP
	id S262116AbTHFNuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 09:50:00 -0400
Date: Wed, 6 Aug 2003 06:49:54 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: My report on running 2.6.0-test2 on a Dell Inspiron 7000 (crash
 while shutting down)
Message-Id: <20030806064954.3e714af8.dickson@permanentmail.com>
In-Reply-To: <20030806021621.2da5a850.dickson@permanentmail.com>
References: <20030806021621.2da5a850.dickson@permanentmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003 02:16:21 -0700, Paul Dickson wrote:

> But all is not perfect.  I'll attach the problems I had as replies (so
> each has it's own message thread).

When I shutdown for a reboot, I getting the following oops (which I
recorded with a digital camera, an transcribe here):

--------------------------------------------------------------------------------
EIP:    0060:[<c0264054>]    Not tainted
EFLAGS: 00010246
EIP is at device_shutdown+0x74/0xab
eax: 00000000   ebx: ffffffc4   ecx: 00000000   edx: 00000000
esi: cc950000   edi: fee1dead   ebp: cc951ea0   esp: cc951e94
ds: 00tb   es: 007b   ss: 0068
Process reboot (pid: 2551, threadinfo=cc950000 task=cc94f940)
Stack: c034e09d 00000042 01234567 cc951fbc c012a4a6 c0446268 00000001 00000000
       cc8fa2e0 cdfb0c60 cc125420 00000000 cf5df4a0 cc125420 420d1c20 cf5df4a0
       cc951f04 00000246 00000246 cc770760 420d1c20 00000292 cc950000 cc951f04
Call Trace:
 [<c012a4a6>] sys_reboot+0x126/0x310
 [<c0153813>] invalidate_inod_buffers+0x13/0x80
 [<c02c5ced>] sock_destroy_inode+0x1d/0x30
 [<c016a296>] destroy_inode+0x36/0x60
 [<c016b603>] iput+0x63/0x90
 [<c0168440>] dput+0x30/0x220
 [<c0152375>] __fput+0xc5/0x130
 [<c01509db>] filp_close+04b/0x80
 [<c0150a72>] sys_close+0x62/0xa0
 [<c010b189>] sysenter_past_esp+0x52/0x71

Code: 8b 43 40 89 ca 89 c1 8d 74 26 00 81 fa c8 6e 3d c0 75 d9 b8
INIT: no more processes left in this runlevel
--------------------------------------------------------------------------------

Some of the 8s and 0s might be interchanges, especially near the end.

I think this had been mentioned before on LKML.

The feeling held in the edi is cute.

	-Paul


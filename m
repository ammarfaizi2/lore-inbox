Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVEZHiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVEZHiA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVEZHiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:38:00 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:28582 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261247AbVEZHhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:37:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=lNcm2mTKbMOuxXwYtdodLUdJdGicX5NAfMKeYp7UX/Q+aV44CvlOB+s/cGBwHIsqC0v5cOH+TfltsCA6XrN0VaR0vBkBd2n9OGzHCUb1wat7EmDQnUYMfeWIo6JYucpODsTTUyXas6wDc5EkUm/uU9szsnPY6otR0vlYklkfLDs=
Subject: 2.6.12-rc5-mm1 alsa oops
From: Islam Amer <pharon@gmail.com>
Reply-To: pharon@gmail.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 26 May 2005 10:32:48 +0300
Message-Id: <1117092768.26173.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into this problem, like someone else on the mailing list.

Pentium III 800MHz 512MB ram
CM8738 sound card

on 2.6.12-rc5-mm1 on gentoo-linux 
play sound through alsa, then quit program. I get an oops:

Unable to handle kernel NULL pointer dereference at virtual address 000000a4
 printing eip:
c02acb79
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c02acb79>]    Not tainted VLI
EFLAGS: 00210286   (2.6.12-rc5-mm1-personal)
EIP is at snd_pcm_mmap_data_close+0xa/0x11
eax: 00000000   ebx: db194000   ecx: d9fc8720   edx: d9f24b40
esi: dfabd080   edi: d9f24b18   ebp: df461b80   esp: db195f58
ds: 007b   es: 007b   ss: 0068
Process mplayer (pid: 14876, threadinfo=db194000 task=df382540)
Stack: c013dd8c d9f24b18 00000000 df461b80 b653d000 c013f1d5 d9f24b18 d9f24b18
       d9f24b18 b6545000 c013f4ec df461b80 d9f24b18 d9fc8858 df461b80 df461bb0
       00008000 db194000 c013f529 df461b80 b653d000 00008000 b653d000 00008000
Call Trace:
 [<c013dd8c>] remove_vm_struct+0x49/0x6f
 [<c013f1d5>] unmap_vma_list+0x14/0x1f
 [<c013f4ec>] do_munmap+0xe7/0xf3
 [<c013f529>] sys_munmap+0x31/0x4b
 [<c0102bd7>] sysenter_past_esp+0x54/0x75
Code: 8b 54 24 04 81 48 14 00 00 08 00 c7 40 44 fc c6 38 c0 89 50 50 8b 42 60 ff
80 a4 00 00 00 31 c0 c3 8b 44 24 04 8b 40 50 8b 40 60 <ff> 88 a4 00 00 00 c3 8b
44 24 04 8b 40 50 8b 40 60 ff 80 a4 00


I reported it here:

http://bugzilla.kernel.org/show_bug.cgi?id=4662

thinking it would appear on lkml, but it didn't. Anyway, tell me if more
info is needed.

Thanks in advance.


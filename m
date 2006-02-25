Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWBYWKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWBYWKL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWBYWKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:10:10 -0500
Received: from DS1015.servadmin.com ([12.158.190.218]:47559 "EHLO
	moon.aproximation.org") by vger.kernel.org with ESMTP
	id S1750955AbWBYWKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:10:09 -0500
Message-ID: <20060225141115.h711yj0moswgk8c4@moon.aproximation.org>
Date: Sat, 25 Feb 2006 14:11:15 -0800
From: thewade <pdman@aproximation.org>
To: linux-kernel@vger.kernel.org
Cc: planetccrma@ccrma.stanford.edu
Subject: CCRMA kernel oops & RT SPINLOCK declare question
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using the 2.6.14-0.10.rrt.rhfc4.ccrma CCRMA kernel on my Fedora 
Core 4 AMD64 laptop (in i386 mode).
I have two problems I am working on, and I hope you can help me.


The SPINLOCK problem is with building ati-fglrx from livna.org with the 
spinlock-modified CCRMA kernel:

/home/wade/rpmbuild/BUILD/ati-fglrx-8.22.5.1/fglrx/lib/modules/fglrx/build_mod/2.6.x/firegl_public.c: In 
function
'firegl_init_module':
/home/wade/rpmbuild/BUILD/ati-fglrx-8.22.5.1/fglrx/lib/modules/fglrx/build_mod/2.6.x/firegl_public.c:808: error: 'SPIN_LOCK_UNLOCKED' undeclared (first use in this 
function)

I don't even know how to start debuging something like this. Where 
would I look to find what this value is supposed to be declared as? Is 
there an include file that when added will fix this problem?



The kernel Oops is also with this CCRMA kernel. Fernando has said that 
he has built the 2.6.15 kernel and will soon release that, so maybe 
this is fixed:

   BUG: Unable to handle kernel paging request at virtual address f895e672
   printing eip:
   f895e672
   *pde = 37c5f067
   Oops: 0000 [#1]
   PREEMPT
   Modules linked in: i2c_sis96x(U) i2c_core(U) snd_intel8x0m(U) 
snd_intel8x0(U)
   snd_ac97_codec(U) snd_ac97_bus(U) snd_hdsp(U) snd_rawmidi(U) 
snd_seq_dummy(U)
   snd_seq_oss(U) snd_seq_midi_event(U) snd_seq(U) snd_seq_device(U) 
snd_pcm_oss(U)
   snd_mixer_oss(U) snd_pcm(U) snd_timer(U) snd_page_alloc(U) 
snd_hwdep(U) snd(U)
   soundcore(U) rt2500pci(U) rt2x00core(U) ieee80211(U) 
ieee80211_crypt(U) sis900(U) mii(U)
   serio_raw(U) joydev(U)
   ext3(U) jbd(U)
   CPU:    0
   EIP:    0060:[<f895e672>]    Not tainted VLI
   EFLAGS: 00010246   (2.6.14-0.10.rrt.rhfc4.ccrma)
   EIP is at 0xf895e672
   eax: 00000000   ebx: f895b9b0   ecx: 00000001   edx: 00000000
   esi: 00000000   edi: 00000000   ebp: 00000000   esp: f7dcffd8
   ds: 007b   es: 007b   ss: 0068   preempt: 00000001
   Process shpchpd_event (pid: 1077, threadinfo=f7dce000 task=f7dbb8b0 
stack_left=8100
   worst_left=-1)
   Stack: f896606c 0000007b ffffffff f895b9b0 c01013e9 00000000 
00000000 00000000
         00000000 00000000
   Call Trace:
   [<c01013e9>] kernel_thread_helper+0x5/0xc (20)
   Code:  Bad EIP value.
   <6>ehci_hcd 0000:00:03.3: EHCI Host Controller


Any information you can give me will be very helpful! Thank you all for 
your time and hard work making linux kick arse!
-thewade


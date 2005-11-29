Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbVK2HTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVK2HTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 02:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVK2HTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 02:19:12 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:13443 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751281AbVK2HTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 02:19:10 -0500
Message-ID: <438C0124.3030700@m1k.net>
Date: Tue, 29 Nov 2005 02:20:04 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc3
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>I just pushed 2.6.15-rc3 out there, and here are both the shortlog and 
>diffstats appended.
>
>Most notable are some VM fixes from Hugh Dickins (with me then redoing 
>some of it, but the bulk of the work goes to Hugh).  That should finally 
>hopefully fix some of the issues some people hit with the PageReserved 
>removal and cleanup by Nick Piggin that was in -rc1.
>
>There's also some input updates, cifs fixes, USB EHCI host controller 
>updates, and a number of random stuff. Details in the shortlog below,
>  
>
Those memory problems affecting v4l/dvb seem to be fixed (for me) , and 
everything seems to work, but I got this oops on bootup.  This is the 
first 2.6.15-rcX kernel that I've installed on this particular box.  
2.6.14 worked fine.

Full dmesg posted at:
http://techsounds.org/2.6.15-rc3-oops.txt

Unable to handle kernel NULL pointer dereference at virtual address 00000015
 printing eip:
c0149a66
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: sbp2 usbhid usb_storage cx88_blackbird tda9887 tuner cx88_dvb cx8802 mt352 or51132 video_buf_dvb dvb_core nxt200x firmware_class lgdt330x cx22702 dvb_pll cx8800 cx88xx i2c_algo_bit video_buf ir_common tveeprom i2c_core v4l1_compat v4l2_common btcx_risc videodev ohci1394 ieee1394 ati_agp agpgart snd_atiixp ehci_hcd snd_atiixp_modem snd_ac97_codec snd_ac97_bus ohci_hcd snd_pcm snd_timer snd snd_page_alloc usbcore
CPU:    1
EIP:    0060:[<c0149a66>]    Not tainted VLI
EFLAGS: 00010202   (2.6.15-rc3) 
EIP is at vm_normal_page+0x17/0x60
eax: 37c08025   ebx: 00000000   ecx: 00000000   edx: 00037c08
esi: 37c08025   edi: ffffe000   ebp: 00000001   esp: f488fed0
ds: 007b   es: 007b   ss: 0068
Process gdb (pid: 5628, threadinfo=f488e000 task=f7239a30)
Stack: c014e2ae f72a4b80 ffffe000 00000ff8 c04b0820 ffffe000 c014a8f5 00000000 
       ffffe000 37c08025 00000010 00000000 c014b9a3 c1697920 081b3000 00000010 
       00000000 bff9be38 f6fa1530 ffffe000 c012536d f6fa1530 f72a4b80 ffffe000 
Call Trace:
 [<c014e2ae>] find_extend_vma+0x20/0x6b
 [<c014a8f5>] get_user_pages+0x29f/0x309
 [<c014b9a3>] do_no_page+0x15e/0x2ac
 [<c012536d>] access_process_vm+0x133/0x1d7
 [<c0106963>] arch_ptrace+0x65/0x4bd
 [<c0124fa3>] ptrace_check_attach+0x38/0xae
 [<c01258c1>] sys_ptrace+0x6f/0xb2
 [<c0102d7d>] syscall_call+0x7/0xb
Code: 24 a0 75 3c c0 e8 87 3a fd ff 83 c4 18 5b 5e e9 ad a1 fb ff 57 56 53 83 ec 0c 8b 5c 24 1c 8b 7c 24 20 8b 74 24 24 89 f2 c1 ea 0c <f6> 43 15 04 75 1c 3b 15 00 08 4b c0 73 27 89 d1 c1 e1 05 03 0d 
 

Regards,
Michael Krufky

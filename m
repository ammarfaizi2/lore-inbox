Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVHOHTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVHOHTY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 03:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVHOHTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 03:19:24 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:47775 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932145AbVHOHTX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 03:19:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b+amzWrKrahoiRsMTocqMhDPpUShUqXCu4LOe5cRf2iat0UOgfjCj9/DzfKAheaoGYiaAHDWBny4PqgrL6cSDcINoM1FMijsnHa1Gqmbml/hZMxsPfVQI0nFtJQdlBe0P4XApzSkKSZw40939ws8huvf0Nd0Nur6p8MpQC26h4Y=
Message-ID: <2cd57c900508150019544d49ca@mail.gmail.com>
Date: Mon, 15 Aug 2005 15:19:20 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: frank nero <m4rcos2003@yahoo.com>
Subject: Re: oops in kernel 2.6.11.10
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050530021313.43231.qmail@web32601.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050530021313.43231.qmail@web32601.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/05, frank nero <m4rcos2003@yahoo.com> wrote:
> 1. After an upgrade to the kernel 2.6.11.10 the system
> have freezed two times in the span of two days.
> 
> 2. The 1st opps happen about 2 minutes after i umount
> a usb stick. So i power off the computer, wait 10
> seconds and power on again and 4 hours later the 2nd
> opps happen . Another col
> 
> 3. keywords? not sure, maybe USB?
> 
> 4. Linux version 2.6.11.10-ARCH (root@earth) (gcc
> version 3.4.3) #1 SMP Mon May 16 14:58:59 PDT 2005
> 
> 5.   First opps:
> 
> May 27 23:34:24 nova usb 1-2: USB disconnect, address
> 2
> May 27 23:34:24 nova usb 1-2.1: USB disconnect,
> address 3
> May 27 23:36:15 nova Unable to handle kernel NULL
> pointer dereference at virtual address 000
> 00000


I reply rather late. This problem was solved in v2.6.12, by the patch:
drop_buffers() oops fix. Thanks.

        Coywolf


> May 27 23:36:15 nova printing eip:
> May 27 23:36:15 nova c0166630
> May 27 23:36:15 nova *pde = 00000000
> May 27 23:36:15 nova Oops: 0000 [#1]
> May 27 23:36:15 nova PREEMPT SMP
> May 27 23:36:15 nova Modules linked in: nls_cp437 vfat
> fat usb_storage ipt_TCPMSS ipt_limit
> ip_nat_irc ip_nat_ftp iptable_mangle ipt_LOG
> ipt_MASQUERADE iptable_nat ipt_TOS ipt_REJECT i
> p_conntrack_irc ip_conntrack_ftp ipt_state
> ip_conntrack iptable_filter ip_tables ohci_hcd eh
> ci_hcd pcspkr rtc snd_via82xx snd_ac97_codec
> snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd
> _page_alloc gameport snd_mpu401_uart snd_rawmidi
> snd_seq_device snd soundcore via686a i2c_se
> nsor i2c_core uhci_hcd usbcore tsdev evdev parport_pc
> lp parport ne 8390 8139too mii
> May 27 23:36:15 nova CPU:    0
> May 27 23:36:15 nova EIP:    0060:[<c0166630>]    Not
> tainted VLI
> May 27 23:36:15 nova EFLAGS: 00010213
> (2.6.11.10-ARCH)
> May 27 23:36:15 nova EIP is at drop_buffers+0x20/0xa0
> May 27 23:36:15 nova eax: 00000000   ebx: c1069fc0
> ecx: 00000000   edx: 00000000
> May 27 23:36:15 nova esi: 00000000   edi: caf64e0c
> ebp: c1069fc0   esp: c1709df0
> May 27 23:36:15 nova ds: 007b   es: 007b   ss: 0068
> May 27 23:36:15 nova Process kswapd0 (pid: 118,
> threadinfo=c1708000 task=c16db590)
> May 27 23:36:15 nova Stack: c1709eb4 c1069fc0 00000000
> c1499578 c1709eb4 c01666f9 c1069fc0 c
> 1709e10
> May 27 23:36:15 nova 00000000 c1709f5c c1069fc0
> c149952c c014bff1 c1069fc0 000000d0 00000000
> 
> May 27 23:36:15 nova 00000001 00000000 00000007
> 00000000 c1709e40 c1709e40 00000007 00000001
> 
> May 27 23:36:15 nova Call Trace:
> May 27 23:36:15 nova [<c01666f9>]
> try_to_free_buffers+0x49/0xb0
> May 27 23:36:15 nova [<c014bff1>]
> shrink_list+0x2a1/0x450
> May 27 23:36:15 nova [<c014ad35>]
> __pagevec_release+0x25/0x30
> May 27 23:36:15 nova [<c014c91d>]
> refill_inactive_zone+0x41d/0x4f0
> May 27 23:36:15 nova [<c014c320>]
> shrink_cache+0x180/0x360
> May 27 23:36:15 nova [<c014ca92>]
> shrink_zone+0xa2/0xd0
> May 27 23:36:15 nova [<c014cf1e>]
> balance_pgdat+0x23e/0x3c0
> May 27 23:36:15 nova [<c014d184>] kswapd+0xe4/0x140
> May 27 23:36:15 nova [<c0136240>]
> autoremove_wake_function+0x0/0x60
> May 27 23:36:15 nova [<c01031b2>]
> ret_from_fork+0x6/0x14
> May 27 23:36:15 nova [<c0136240>]
> autoremove_wake_function+0x0/0x60
> May 27 23:36:15 nova [<c014d0a0>] kswapd+0x0/0x140
> May 27 23:36:15 nova [<c0101375>]
> kernel_thread_helper+0x5/0x10
> May 27 23:36:15 nova Code: 00 00 00 00 8d bc 27 00 00
> 00 00 55 57 56 53 83 ec 04 8b 6c 24 18
>  8b 45 00 f6 c4 10 74 7f 8b 7d 0c 89 f9 90 8d b4 26 00
> 00 00 00 <8b> 01 f6 c4 04 74 09 8b 45
>    10 f0 0f ba 68 44 10 8b 11 8b 41 0c
>      May 27 23:36:15 nova <6>note: kswapd0[118] exited
> with preempt_count 1
> 
>     Second opps:
> 
> May 28 04:08:14 nova Unable to handle kernel paging
> request at virtual address dfb50fbc
> May 28 04:08:14 nova printing eip:
> May 28 04:08:14 nova c0166630
> May 28 04:08:14 nova *pde = 00000000
> May 28 04:08:14 nova Oops: 0000 [#1]
> May 28 04:08:14 nova PREEMPT SMP
> May 28 04:08:14 nova Modules linked in: ipt_TCPMSS
> ipt_limit ip_nat_irc ip_nat_ftp iptable_mangle ipt_LOG
> ipt_M
> ASQUERADE iptable_nat ipt_TOS ipt_REJECT
> ip_conntrack_irc ip_conntrack_ftp ipt_state
> ip_conntrack iptable_filte
> r ip_tables ohci_hcd ehci_hcd pcspkr rtc snd_via82xx
> snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm
> snd_timer
> snd_page_alloc gameport snd_mpu401_uart snd_rawmidi
> snd_seq_device snd soundcore via686a i2c_sensor
> i2c_core u
> hci_hcd usbcore tsdev evdev parport_pc lp parport ne
> 8390 8139too mii
> May 28 04:08:14 nova CPU:    0
> May 28 04:08:14 nova EIP:    0060:[<c0166630>]    Not
> tainted VLI
> May 28 04:08:14 nova EFLAGS: 00010202
> (2.6.11.10-ARCH)
> May 28 04:08:14 nova EIP is at drop_buffers+0x20/0xa0
> May 28 04:08:14 nova eax: 20001009   ebx: c1384840
> ecx: dfb50fbc   edx: 00000000
> May 28 04:08:14 nova esi: 00000000   edi: dfb50fbc
> ebp: c1384840   esp: c1709df0
> May 28 04:08:14 nova ds: 007b   es: 007b   ss: 0068
> May 28 04:08:14 nova Process kswapd0 (pid: 118,
> threadinfo=c1708000 task=c16db590)
> May 28 04:08:14 nova Stack: c13b8460 c1384840 00000000
> c1499398 c1709eb4 c01666f9 c1384840 c1709e10
> May 28 04:08:14 nova 00000000 c1709f5c c1384840
> c149934c c014bff1 c1384840 000000d0 00000000
> May 28 04:08:14 nova 00000001 00000000 00000000
> 00000000 c1709e40 c1709e40 00000000 00000001
> May 28 04:08:14 nova Call Trace:
> May 28 04:08:14 nova [<c01666f9>]
> try_to_free_buffers+0x49/0xb0
> May 28 04:08:14 nova [<c014bff1>]
> shrink_list+0x2a1/0x450
> May 28 04:08:14 nova [<c01197cc>]
> recalc_task_prio+0x8c/0x160
> May 28 04:08:14 nova [<c014ad35>]
> __pagevec_release+0x25/0x30
> May 28 04:08:14 nova [<c014c91d>]
> refill_inactive_zone+0x41d/0x4f0
> May 28 04:08:14 nova [<c014c320>]
> shrink_cache+0x180/0x360
> May 28 04:08:14 nova [<c014ca92>]
> shrink_zone+0xa2/0xd0
> May 28 04:08:14 nova [<c014cf1e>]
> balance_pgdat+0x23e/0x3c0
> May 28 04:08:14 nova [<c014d184>] kswapd+0xe4/0x140
> May 28 04:08:14 nova [<c0136240>]
> autoremove_wake_function+0x0/0x60
> May 28 04:08:14 nova [<c01031b2>]
> ret_from_fork+0x6/0x14
> May 28 04:08:14 nova [<c0136240>]
> autoremove_wake_function+0x0/0x60
> May 28 04:08:14 nova [<c014d0a0>] kswapd+0x0/0x140
> May 28 04:08:14 nova [<c0101375>]
> kernel_thread_helper+0x5/0x10
> May 28 04:08:14 nova Code: 00 00 00 00 8d bc 27 00 00
> 00 00 55 57 56 53 83 ec 04 8b 6c 24 18 8b 45 00 f6 c4
> 10
> 74 7f 8b 7d 0c 89 f9 90 8d b4 26 00 00 00 00 <8b> 01
> f6 c4 04 74 09 8b 45 10 f0 0f ba 68 44 10 8b 11 8b 41
> 0c
> May 28 04:08:14 nova <6>note: kswapd0[118] exited with
> preempt_count 1
> 
> 6. Not sure what trigger this, the first opps culprit
> seems to be the usb stick, no idea about the second
> opps.
> 

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/

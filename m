Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTE1MnY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbTE1MnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:43:24 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:8775 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264043AbTE1MnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:43:10 -0400
Date: Wed, 28 May 2003 08:55:04 -0400
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: ppp problems in 2.5.69-bk14
In-reply-to: <Pine.LNX.4.44.0305211051100.22168-100000@bad-sports.com>
To: Kernel List <linux-kernel@vger.kernel.org>
Reply-to: Matthew Harrell 
	  <mharrell-dated-1054558504.3ee06c@bittwiddlers.com>
Message-id: <20030528125503.GA2745@bittwiddlers.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
X-Delivery-Agent: TMDA/0.75 (Ponder)
X-Primary-Address: mharrell@bittwiddlers.com
References: <Pine.LNX.4.44.0305211051100.22168-100000@bad-sports.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Same issue under 2.5.70-bk1


> Hey,
> 
> I got this lovely mess when trying to run ppp under 2.5.69-bk14
> 
> using devfs
> all ppp is modular
> 
> thanks,
> 
> 	/ Brett
> 
> PPP generic driver version 2.4.2
> devfs_mk_cdev: could not append to parent for ppp
> failed to register PPP device (-17)
> Unable to handle kernel paging request at virtual address c38755c0
>  printing eip:
> c0150743
> *pde = 01092067
> *pte = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c0150743>]    Not tainted
> EFLAGS: 00010286
> EIP is at lookup_chrfops+0x83/0xd0
> eax: c38755c0   ebx: c129c600   ecx: c1e4c000   edx: 00000000
> esi: 00000000   edi: 00000000   ebp: 0000006c   esp: c1e4def0
> ds: 007b   es: 007b   ss: 0068
> Process pppd (pid: 402, threadinfo=c1e4c000 task=c145d380)
> Stack: c1e4c000 00000000 0000006c 00000000 c01507da 0000006c 00000000 c2048b20 
>        c2048b20 ffffffed c21adea0 c0150a42 0000006c 00000000 c2048b20 c21adea0 
>        ffffffed c107b220 c01986c9 c21adea0 c2048b20 c2048b20 c21adea0 c10c6084 
> Call Trace:
>  [<c01507da>] get_chrfops+0x4a/0x70
>  [<c0150a42>] chrdev_open+0x22/0xa0
>  [<c01986c9>] devfs_open+0xd9/0x110
>  [<c0147b8a>] dentry_open+0x1da/0x210
>  [<c01479a0>] filp_open+0x50/0x60
>  [<c0147e2b>] sys_open+0x3b/0x70
>  [<c0108df7>] syscall_call+0x7/0xb
> 
> Code: 8b 00 be 01 00 00 00 85 c0 74 24 8b 69 14 45 89 69 14 83 38 
> <6>note: pppd[402] exited with preempt_count 2
> bad: scheduling while atomic!
> Call Trace:
>  [<c0114fc7>] schedule+0x3b7/0x3c0
>  [<c0139ddd>] unmap_vmas+0x1ed/0x260
>  [<c013de66>] exit_mmap+0x66/0x180
>  [<c0116763>] mmput+0x53/0xa0
>  [<c011a19a>] do_exit+0x10a/0x420
>  [<c0109654>] die+0xc4/0xd0
>  [<c0112d51>] do_page_fault+0x111/0x469
>  [<c0125247>] queue_work+0x97/0xb0
>  [<c012516e>] call_usermodehelper+0xbe/0xd0
>  [<c0125060>] __call_usermodehelper+0x0/0x50
>  [<c0112c40>] do_page_fault+0x0/0x469
>  [<c010905d>] error_code+0x2d/0x40
>  [<c0150743>] lookup_chrfops+0x83/0xd0
>  [<c01507da>] get_chrfops+0x4a/0x70
>  [<c0150a42>] chrdev_open+0x22/0xa0
>  [<c01986c9>] devfs_open+0xd9/0x110
>  [<c0147b8a>] dentry_open+0x1da/0x210
>  [<c01479a0>] filp_open+0x50/0x60
>  [<c0147e2b>] sys_open+0x3b/0x70
>  [<c0108df7>] syscall_call+0x7/0xb
> 
> PPP generic driver version 2.4.2
> failed to register PPP device (-16)
> ppp_async: Unknown symbol ppp_channel_index
> ppp_async: Unknown symbol ppp_register_channel
> ppp_async: Unknown symbol ppp_input
> ppp_async: Unknown symbol ppp_input_error
> ppp_async: Unknown symbol ppp_output_wakeup
> ppp_async: Unknown symbol ppp_unregister_channel
> ppp_async: Unknown symbol ppp_unit_number
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
  Matthew Harrell                          May the bluebird of happiness
  Bit Twiddlers, Inc.                       twiddle your bits.
  mharrell@bittwiddlers.com     

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTFOSww (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTFOSww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:52:52 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:190 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262633AbTFOSwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:52:46 -0400
Date: Sun, 15 Jun 2003 21:06:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: CJ <cj@cjcj.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: linux-2.4.21 released
Message-ID: <20030615190632.GB28134@wohnheim.fh-wedel.de>
References: <200306131453.h5DErX47015940@hera.kernel.org> <3EEB4112.9050005@cjcj.com> <20030614155413.GI15099@wohnheim.fh-wedel.de> <3EEB4D59.2040701@cjcj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EEB4D59.2040701@cjcj.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot make much from this, but maybe it won't go overlooked on
linux-net.

On Sat, 14 June 2003 09:29:13 -0700, CJ wrote:
> 
> >>EIP; c02adfa3 <skb_checksum_help+53/80>   <=====
> Trace; c02ae08a <dev_queue_xmit+ba/260>
> Trace; c012c631 <balance_classzone+1f1/210>
> Trace; c031346f <__dev_queue_push_xmit+3f/50>
> Trace; c0313496 <__br_forward_finish+16/40>
> Trace; c031369b <br_flood+bb/e0>
> Trace; c03136f9 <br_flood_forward+19/20>
> Trace; c0313500 <__br_forward+0/40>
> Trace; c0313ea8 <br_handle_frame_finish+58/110>
> Trace; c0314009 <br_handle_frame+a9/120>
> Trace; c02ae639 <netif_receive_skb+d9/190>
> Trace; c0316100 <br_tick+0/30>
> Trace; c0316100 <br_tick+0/30>
> Trace; c0314f58 <br_config_bpdu_generation+28/40>
> Trace; c02ae763 <process_backlog+73/130>
> Trace; c02ae88c <net_rx_action+6c/110>
> Trace; c0109dca <handle_IRQ_event+3a/70>
> Trace; c01192e3 <do_softirq+53/a0>
> Trace; c0109f7c <do_IRQ+9c/b0>
> Trace; c0106e40 <default_idle+0/30>
> Trace; c010c3d8 <call_do_IRQ+5/d>
> Trace; c0106e40 <default_idle+0/30>
> Trace; c0106e64 <default_idle+24/30>
> Trace; c0106ed2 <cpu_idle+42/60>
> Trace; c0105000 <_stext+0/0>
> Code;  c02adfa3 <skb_checksum_help+53/80>
> 00000000 <_EIP>:
> Code;  c02adfa3 <skb_checksum_help+53/80>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c02adfa5 <skb_checksum_help+55/80>
>    2:   df 03                     fild   (%ebx)
> Code;  c02adfa7 <skb_checksum_help+57/80>
>    4:   e3 5a                     jecxz  60 <_EIP+0x60> c02ae003 
>    <dev_queue_xmit+33/260>
> Code;  c02adfa9 <skb_checksum_help+59/80>
>    6:   38 c0                     cmp    %al,%al
> Code;  c02adfab <skb_checksum_help+5b/80>
>    8:   89 c8                     mov    %ecx,%eax
> Code;  c02adfad <skb_checksum_help+5d/80>
>    a:   c1 e1 10                  shl    $0x10,%ecx
> Code;  c02adfb0 <skb_checksum_help+60/80>
>    d:   25 00 00 ff ff            and    $0xffff0000,%eax
> Code;  c02adfb5 <skb_checksum_help+65/80>
>   12:   01 c8                     add    %ecx,%eax
> 
> 
> 
> Jörn Engel wrote:
> >On Sat, 14 June 2003 08:36:50 -0700, CJ wrote:
> >
> >>On an old Tyan Tomcat P200 running as a diskless bridge,
> >>we tried unpatched 2.4.21.  A few seconds after boot:
> >>
> >># kernel BUG at dev.c:991!
> >>invalid operand: 0000
> >>CPU:    0
> >>EIP:    0010:[<c02adfa3>]    Not tainted
> >>EFLAGS: 00010212
> >>eax: 00010001   ebx: c10dfda0   ecx: 36b8c947   edx: 0000002e
> >>esi: 0000ffff   edi: c3e7e030   ebp: c3c55800   esp: c03f5e20
> >>ds: 0018   es: 0018   ss: 0018
> >>Process swapper (pid: 0, stackpage=c03f5000)
> >>Stack: c10dfda0 c03ad840 c3ed15c0 c02ae08a c10dfda0 00000000 00000246 
> >>c012c631
> >>      c039ae30 c10dfda0 00000000 c031346f c10dfda0 c10dfda0 c0313496 
> >>      c10dfda0
> >>      c031396b c10dfda0 c10dfda0 c3e5e000 00000000 51eb815f 00000000 
> >>      c3e92960
> >>Call Trace:    [<c02ae08a>] [<c012c631>] [<c031346f>] [<c0313496>] 
> >>[<c031369b>]
> >> [<c03136f9>] [<c0313500>] [<c0313ea8>] [<c0314009>] [<c02ae639>] 
> >> [<c0316100>]
> >> [<c0316100>] [<c0314f58>] [<c02ae763>] [<c02ae88c>] [<c0109dca>] 
> >> [<c01192e3>]
> >> [<c0109f7c>] [<c0106e40>] [<c010c3d8>] [<c0106e40>] [<c0106e64>] 
> >> [<c0106ed2>]
> >> [<c0105000>]
> >>Code: 0f 0b df 03 e3 5a 38 c0 89 c8 c1 e1 10 25 00 00 ff ff 01 c8
> >><0>Kernel panic: Aiee, killing interrupt handler!
> >>In interrupt handler - not syncing
> >>
> >>Caps lock and Scroll lock blinking
> >
> >
> >Can you run that through ksymoops?
> >What was the last working kernel for the machine?
> >.config for last working kernel? (unless identical)

Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu

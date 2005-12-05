Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVLEN0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVLEN0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 08:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVLEN0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 08:26:00 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:24469 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S1751136AbVLENZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 08:25:59 -0500
Subject: Re: Kernel BUG at page_alloc.c:117!
From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
To: zine el abidine Hamid <zine46@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051205131652.72804.qmail@web30603.mail.mud.yahoo.com>
References: <20051205131652.72804.qmail@web30603.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 05 Dec 2005 14:25:04 +0100
Message-Id: <1133789104.7208.1.camel@noti>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zine,

your kernel is quite old.
Probably it would just help to update to a newer one.
I think on 2.4 the 2.4.32 is the current version.

Dirk

Am Montag, den 05.12.2005, 14:16 +0100 schrieb zine el abidine Hamid:
> Hi,
> 
> 
> I'm using a Linux RedHat kernel 2.4.18-3 and the
> system hung after a while with this error
> (/var/log/messages):
> 
> Dec  1 14:54:58 Republique_ncl_a kernel: ------------[
> cut here ]------------
> Dec  1 14:54:58 Republique_ncl_a kernel: kernel BUG at
> page_alloc.c:117!
> Dec  1 14:54:58 Republique_ncl_a kernel: invalid
> operand: 0000
> Dec  1 14:54:58 Republique_ncl_a kernel: wdpiano
> w83781d via686a lm80 i2c-proc i2c-isa i2c-core auto
> fs parport_pc plip
> Dec  1 14:54:58 Republique_ncl_a kernel: CPU:    0
> Dec  1 14:54:58 Republique_ncl_a kernel: EIP:   
> 0010:[<c01316e7>]    Not tainted
> Dec  1 14:54:58 Republique_ncl_a kernel: EFLAGS:
> 00010282
> Dec  1 14:54:58 Republique_ncl_a kernel:
> Dec  1 14:54:58 Republique_ncl_a kernel: EIP is at
> __free_pages_ok [kernel] 0x57 (2.4.18-3)
> Dec  1 14:54:58 Republique_ncl_a kernel: eax: 00000020
>   ebx: c16502d8   ecx: 00000001   edx: 000019
> 0e
> Dec  1 14:54:58 Republique_ncl_a kernel: esi: 00000000
>   edi: 000001d0   ebp: 00000000   esp: c1755f
> 38
> Dec  1 14:54:58 Republique_ncl_a kernel: ds: 0018  
> es: 0018   ss: 0018
> Dec  1 14:54:58 Republique_ncl_a kernel: Process
> kswapd (pid: 5, stackpage=c1755000)
> Dec  1 14:54:58 Republique_ncl_a kernel: Stack:
> c02250b5 00000075 c013d0e3 ddf7e600 c16502d8 000001d
> 0 c013b23a c16502d8
> Dec  1 14:54:58 Republique_ncl_a kernel:       
> c16502f4 c16502d8 c16502d8 000001d0 000001d0 c012ff8
> b 00000c24 0000019d
> Dec  1 14:54:58 Republique_ncl_a kernel:       
> 00000125 c02c473c 00000c24 00000848 0000000f c013038
> 8 c02c473c 000001d0
> Dec  1 14:54:58 Republique_ncl_a kernel: Call Trace:
> [<c013d0e3>] try_to_free_buffers [kernel] 0xb3
> Dec  1 14:54:58 Republique_ncl_a kernel: [<c013b23a>]
> try_to_release_page [kernel] 0x3a
> Dec  1 14:54:58 Republique_ncl_a kernel: [<c012ff8b>]
> page_launder_zone [kernel] 0x42b
> Dec  1 14:54:58 Republique_ncl_a kernel: [<c0130388>]
> page_launder [kernel] 0x168
> Dec  1 14:54:58 Republique_ncl_a kernel: [<c0130c12>]
> do_try_to_free_pages [kernel] 0x12
> Dec  1 14:54:58 Republique_ncl_a kernel: [<c0130f11>]
> kswapd [kernel] 0x101
> Dec  1 14:54:58 Republique_ncl_a kernel: [<c0105000>]
> stext [kernel] 0x0
> Dec  1 14:54:58 Republique_ncl_a kernel: [<c0107136>]
> kernel_thread [kernel] 0x26
> Dec  1 14:54:58 Republique_ncl_a kernel: [<c0130e10>]
> kswapd [kernel] 0x0
> Dec  1 14:54:58 Republique_ncl_a kernel:
> Dec  1 14:54:58 Republique_ncl_a kernel:
> Dec  1 14:54:58 Republique_ncl_a kernel: Code: 0f 0b
> 5d 58 8b 3d f0 e2 32 c0 89 d8 29 f8 69 c0 b7 6d
>  db b6
> Dec  1 14:54:59 Republique_ncl_a ucd-snmp[12873]:
> Connection from 111.9.3.13
> Dec  1 14:55:30 Republique_ncl_a last message repeated
> 9 times
> Dec  1 14:56:31 Republique_ncl_a last message repeated
> 17 times
> 
> 
> 
> Can anyone explain me what does it mean? What the
> problem?   How can I resolve this problem?
> 
> Thanks.
> 
> Zine. 
> 
> 
> 	
> 
> 	
> 		
> ___________________________________________________________________________ 
> Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
> Téléchargez cette version sur http://fr.messenger.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Dirk Henning Gerdes
Bönnersdyk 47
47803 Krefeld

Tel:  02151-755745
      0174-7776640
Mail: mail@dirk-gerdes.de


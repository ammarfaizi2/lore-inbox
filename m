Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265626AbUBBNDU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 08:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265617AbUBBNDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 08:03:20 -0500
Received: from smtp03.web.de ([217.72.192.158]:33796 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S265626AbUBBNDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 08:03:00 -0500
Message-ID: <401E4A80.4050907@web.de>
Date: Mon, 02 Feb 2004 14:02:56 +0100
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oops in old isdn4linux and 2.6.2-rc3 (was in -rc2 too)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

didn't find any more applicabale mailing list, so here it goes:

card: AVM A1 PCMCIA
kernel: 2.6.2-rc3
isdn options:
CONFIG_ISDN_BOOL=y
CONFIG_ISDN=m
CONFIG_ISDN_NET_SIMPLE=y
CONFIG_ISDN_NET_CISCO=y
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_ISDN_PPP_BSDCOMP=m
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y
CONFIG_ISDN_DRV_LOOP=m
CONFIG_ISDN_DRV_HISAX=m
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
CONFIG_HISAX_MAX_CARDS=2
CONFIG_HISAX_AVM_A1_PCMCIA=y
CONFIG_HISAX_AVM_A1_CS=m

pcmcia options:
CONFIG_PCMCIA=m
CONFIG_YENTA=m
CONFIG_CARDBUS=y
CONFIG_PCMCIA_PROBE=y

When I insert the ISDN card I get the followin oops and the cardmgr 
proces does not respond anymore.
oops output:
Feb  2 13:44:11 styx kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Feb  2 13:44:11 styx kernel: CSLIP: code copyright 1989 Regents of the 
University of California
Feb  2 13:44:12 styx kernel: ISDN subsystem initialized
Feb  2 13:44:12 styx kernel: HiSax: Linux Driver for passive ISDN cards
Feb  2 13:44:12 styx kernel: HiSax: Version 3.5 (module)
Feb  2 13:44:12 styx kernel: HiSax: Layer1 Revision 2.41.6.5
Feb  2 13:44:12 styx kernel: HiSax: Layer2 Revision 2.25.6.4
Feb  2 13:44:12 styx kernel: HiSax: TeiMgr Revision 2.17.6.3
Feb  2 13:44:12 styx kernel: HiSax: Layer3 Revision 2.17.6.5
Feb  2 13:44:12 styx kernel: HiSax: LinkLayer Revision 2.51.6.6
Feb  2 13:44:12 styx kernel: avma1_cs: testing i/o 0x140-0x147
Feb  2 13:44:12 styx kernel: avma1_cs: checking at i/o 0x140, irq 3
Feb  2 13:44:12 styx kernel: get_drv 0: 0 -> 1
Feb  2 13:44:12 styx kernel: HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
Feb  2 13:44:12 styx kernel: HiSax: AVM A1 PCMCIA driver Rev. 2.7.6.2
Feb  2 13:44:12 styx kernel:  printing eip:
Feb  2 13:44:12 styx kernel: d19cd612
Feb  2 13:44:12 styx kernel: Oops: 0000 [#1]
Feb  2 13:44:12 styx kernel: CPU:    0
Feb  2 13:44:12 styx kernel: EIP: 
0060:[__crc_blk_attempt_remerge+2649154/3591710]    Not tainted
Feb  2 13:44:12 styx kernel: EFLAGS: 00010282
Feb  2 13:44:12 styx kernel: EIP is at 0xd19cd612
Feb  2 13:44:12 styx kernel: eax: c4e31000   ebx: d3e9f9a0   ecx: 
00000001   edx: c0315598
Feb  2 13:44:12 styx kernel: esi: d3e96987   edi: cef7385d   ebp: 
cef73894   esp: cef7383c
Feb  2 13:44:12 styx kernel: ds: 007b   es: 007b   ss: 0068
Feb  2 13:44:12 styx kernel: Process cardmgr (pid: 975, 
threadinfo=cef72000 task=cedab900)
Feb  2 13:44:12 styx kernel: Stack: d3e8ebfc c4e31000 d3e9f9a0 76655224 
6f697369 32203a6e 362e372e 2400322e
Feb  2 13:44:12 styx kernel:        cef73800 00000246 cffad758 c4e31000 
cef738ee c4e310d6 cef73894 d3e78c78
Feb  2 13:44:12 styx kernel:        d3e97240 00000001 d3e94294 c4e31000 
cef738ee c4e310d6 cef738bc d3e78e36
Feb  2 13:44:12 styx kernel: Call Trace:
Feb  2 13:44:12 styx kernel: 
[__crc_journal_set_features+2091499/2437465] 
setup_avm_a1_pcmcia+0x4a/0x62 [hisax]
Feb  2 13:44:12 styx kernel: 
[__crc_journal_set_features+2001511/2437465] do_register_isdn+0xe3/0xe9 
[hisax]
Feb  2 13:44:12 styx kernel: 
[__crc_journal_set_features+2001957/2437465] checkcard+0x168/0x1ad [hisax]
Feb  2 13:44:12 styx kernel: 
[__crc_journal_set_features+2002290/2437465] 
HiSax_inithardware+0xc3/0x17e [hisax]
Feb  2 13:44:12 styx kernel: 
[__crc_journal_set_features+2003505/2437465] 
avm_a1_init_pcmcia+0x105/0x125 [hisax]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2665386/3591710] avma1cs_config+0x269/0x38c 
[avma1_cs]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2483938/3591710] set_cis_map+0x3e/0x10b 
[pcmcia_core]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2484415/3591710] read_cis_mem+0x110/0x182 
[pcmcia_core]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2488313/3591710] parse_vers_1+0x5c/0x63 
[pcmcia_core]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2487241/3591710] 
pcmcia_get_next_tuple+0x249/0x2a3 [pcmcia_core]
Feb  2 13:44:12 styx kernel:  [__call_console_drivers+87/89] 
__call_console_drivers+0x57/0x59
Feb  2 13:44:12 styx kernel:  [__wake_up_common+49/80] 
__wake_up_common+0x31/0x50
Feb  2 13:44:12 styx kernel:  [printk+299/380] printk+0x12b/0x17c
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2495383/3591710] do_mem_probe+0xfc/0x1c2 
[pcmcia_core]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2487241/3591710] 
pcmcia_get_next_tuple+0x249/0x2a3 [pcmcia_core]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2486012/3591710] 
pcmcia_get_first_tuple+0x94/0x130 [pcmcia_core]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2665883/3591710] avma1cs_event+0x59/0xb6 
[avma1_cs]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2510239/3591710] 
pcmcia_register_client+0x232/0x282 [pcmcia_core]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2483938/3591710] set_cis_map+0x3e/0x10b 
[pcmcia_core]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2664285/3591710] avma1cs_attach+0x12d/0x1a4 
[avma1_cs]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2665794/3591710] avma1cs_event+0x0/0xb6 
[avma1_cs]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2507122/3591710] pcmcia_bind_device+0x68/0xa7 
[pcmcia_core]
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2226992/3591710] bind_request+0x108/0x228 [ds]
Feb  2 13:44:12 styx kernel:  [capable+36/67] capable+0x24/0x43
Feb  2 13:44:12 styx kernel: 
[__crc_blk_attempt_remerge+2230000/3591710] ds_ioctl+0x52a/0x660 [ds]
Feb  2 13:44:12 styx kernel:  [sock_def_readable+128/130] 
sock_def_readable+0x80/0x82
Feb  2 13:44:12 styx kernel:  [unix_dgram_sendmsg+1134/1364] 
unix_dgram_sendmsg+0x46e/0x554
Feb  2 13:44:12 styx kernel:  [__free_pages_ok+175/183] 
__free_pages_ok+0xaf/0xb7
Feb  2 13:44:12 styx kernel:  [__free_pages+58/72] __free_pages+0x3a/0x48
Feb  2 13:44:12 styx kernel:  [slab_destroy+199/264] slab_destroy+0xc7/0x108
Feb  2 13:44:12 styx kernel:  [free_block+185/205] free_block+0xb9/0xcd
Feb  2 13:44:12 styx kernel:  [cache_flusharray+78/236] 
cache_flusharray+0x4e/0xec
Feb  2 13:44:12 styx kernel:  [zap_pmd_range+75/101] zap_pmd_range+0x4b/0x65
Feb  2 13:44:12 styx kernel:  [unmap_page_range+65/103] 
unmap_page_range+0x41/0x67
Feb  2 13:44:12 styx kernel:  [unmap_vmas+229/522] unmap_vmas+0xe5/0x20a
Feb  2 13:44:12 styx kernel:  [unmap_vma+65/123] unmap_vma+0x41/0x7b
Feb  2 13:44:12 styx kernel:  [unmap_vma_list+29/42] 
unmap_vma_list+0x1d/0x2a
Feb  2 13:44:12 styx kernel:  [do_munmap+321/387] do_munmap+0x141/0x183
Feb  2 13:44:12 styx kernel:  [sys_ioctl+286/675] sys_ioctl+0x11e/0x2a3
Feb  2 13:44:12 styx kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb  2 13:44:12 styx kernel:
Feb  2 13:44:12 styx kernel: Code:  Bad EIP value.

Please help with this issue. TIA!

Greetings,
T.Todorov

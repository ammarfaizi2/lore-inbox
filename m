Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbUA3LCe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUA3LCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:02:34 -0500
Received: from smtp05.web.de ([217.72.192.209]:54562 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262901AbUA3LCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:02:20 -0500
Message-ID: <401A39B7.80007@web.de>
Date: Fri, 30 Jan 2004 12:02:15 +0100
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS in avma1_cs module, kernel 2.6.2-rc2-mm2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

kernel 2.6.2-rc2-mm2 with old ISDN4Linux API, when cardmgr loads the 
avma1_cs module I get the following Oops:

Jan 30 11:40:24 styx kernel: avma1_cs: testing i/o 0x140-0x147
Jan 30 11:40:24 styx kernel: avma1_cs: checking at i/o 0x140, irq 3
Jan 30 11:40:24 styx kernel: get_drv 0: 0 -> 1
Jan 30 11:40:24 styx kernel: HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
Jan 30 11:40:24 styx kernel: HiSax: AVM A1 PCMCIA driver Rev. 2.7.6.2
Jan 30 11:40:24 styx kernel:  printing eip:
Jan 30 11:40:24 styx kernel: d1965612
Jan 30 11:40:24 styx kernel: Oops: 0000 [#1]
Jan 30 11:40:24 styx kernel: PREEMPT
Jan 30 11:40:24 styx kernel: CPU:    0
Jan 30 11:40:24 styx kernel: EIP: 
0060:[__crc_xfrm_state_get_afinfo+38683/2314124]    Not tainted VLI
Jan 30 11:40:24 styx kernel: EFLAGS: 00010282
Jan 30 11:40:24 styx kernel: EIP is at 0xd1965612
Jan 30 11:40:24 styx kernel: eax: ce0e6000   ebx: d1a7a9a0   ecx: 
00000001   edx: c03592d8
Jan 30 11:40:24 styx kernel: esi: d1a71987   edi: cf78985d   ebp: 
cf789894   esp: cf78983c
Jan 30 11:40:24 styx kernel: ds: 007b   es: 007b   ss: 0068
Jan 30 11:40:24 styx kernel: Process cardmgr (pid: 940, 
threadinfo=cf788000 task=cee94200)
Jan 30 11:40:24 styx kernel: Stack: d1a69bfc ce0e6000 d1a7a9a0 76655224 
6f697369 32203a6e 362e372e 2400322e
Jan 30 11:40:24 styx kernel:        cf789800 00000246 cffad758 ce0e6000 
cf7898ee ce0e60d6 cf789894 d1a53c78
Jan 30 11:40:24 styx kernel:        d1a72240 00000001 d1a6f294 ce0e6000 
cf7898ee ce0e60d6 cf7898bc d1a53e36
Jan 30 11:40:24 styx kernel: Call Trace:
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+1105157/2314124] 
setup_avm_a1_pcmcia+0x4a/0x62 [hisax]
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+1015169/2314124] do_register_isdn+0xe3/0xe9 
[hisax]
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+1015615/2314124] checkcard+0x168/0x1ad [hisax]
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+1015948/2314124] 
HiSax_inithardware+0xc3/0x17e [hisax]
Jan 30 11:40:24 styx kernel:  [printk+309/390] printk+0x135/0x186
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+1017163/2314124] 
avm_a1_init_pcmcia+0x105/0x125 [hisax]
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+54915/2314124] avma1cs_config+0x269/0x38c 
[avma1_cs]
Jan 30 11:40:24 styx kernel:  [fbcon_cursor+639/911] 
fbcon_cursor+0x27f/0x38f
Jan 30 11:40:24 styx kernel:  [complement_pos+26/372] 
complement_pos+0x1a/0x174
Jan 30 11:40:24 styx kernel:  [scrup+300/319] scrup+0x12c/0x13f
Jan 30 11:40:24 styx kernel:  [poke_blanked_console+114/194] 
poke_blanked_console+0x72/0xc2
Jan 30 11:40:24 styx kernel:  [try_to_wake_up+160/326] 
try_to_wake_up+0xa0/0x146
Jan 30 11:40:24 styx kernel:  [__call_console_drivers+87/89] 
__call_console_drivers+0x57/0x59
Jan 30 11:40:24 styx kernel:  [__wake_up_common+49/80] 
__wake_up_common+0x31/0x50
Jan 30 11:40:24 styx kernel:  [printk+309/390] printk+0x135/0x186
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+331432/2314124] do_mem_probe+0xfc/0x1c2 
[pcmcia_core]
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+323292/2314124] 
pcmcia_get_next_tuple+0x249/0x2a3 [pcmcia_core]
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+322063/2314124] 
pcmcia_get_first_tuple+0x94/0x130 [pcmcia_core]
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+55412/2314124] avma1cs_event+0x59/0xb6 
[avma1_cs]
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+346354/2314124] 
pcmcia_register_client+0x232/0x282 [pcmcia_core]
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+319931/2314124] set_cis_map+0x3e/0x10b 
[pcmcia_core]
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+53814/2314124] avma1cs_attach+0x12d/0x1a4 
[avma1_cs]
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+55323/2314124] avma1cs_event+0x0/0xb6 
[avma1_cs]
Jan 30 11:40:24 styx kernel: 
[__crc_xfrm_state_get_afinfo+343237/2314124] 
pcmcia_bind_device+0x68/0xa7 [pcmcia_core]
Jan 30 11:40:24 styx kernel:  [__crc_aio_put_req+512435/790293] 
bind_request+0x108/0x228 [ds]
Jan 30 11:40:24 styx kernel:  [capable+36/67] capable+0x24/0x43
Jan 30 11:40:24 styx kernel:  [__crc_aio_put_req+515443/790293] 
ds_ioctl+0x52a/0x660 [ds]
Jan 30 11:40:24 styx kernel:  [sock_def_readable+128/130] 
sock_def_readable+0x80/0x82
Jan 30 11:40:24 styx kernel:  [unix_dgram_sendmsg+1134/1364] 
unix_dgram_sendmsg+0x46e/0x554
Jan 30 11:40:24 styx kernel:  [sock_sendmsg+197/199] sock_sendmsg+0xc5/0xc7
Jan 30 11:40:24 styx kernel:  [proc_read_inode+23/57] 
proc_read_inode+0x17/0x39
Jan 30 11:40:24 styx kernel:  [__mmdrop+54/71] __mmdrop+0x36/0x47
Jan 30 11:40:24 styx kernel:  [schedule+985/1468] schedule+0x3d9/0x5bc
Jan 30 11:40:24 styx kernel:  [pipe_wait+148/167] pipe_wait+0x94/0xa7
Jan 30 11:40:24 styx kernel:  [zap_pmd_range+77/103] zap_pmd_range+0x4d/0x67
Jan 30 11:40:24 styx kernel:  [unmap_page_range+65/103] 
unmap_page_range+0x41/0x67
Jan 30 11:40:24 styx kernel:  [unmap_vmas+229/522] unmap_vmas+0xe5/0x20a
Jan 30 11:40:24 styx kernel:  [unmap_vma+65/123] unmap_vma+0x41/0x7b
Jan 30 11:40:24 styx kernel:  [unmap_vma_list+29/42] 
unmap_vma_list+0x1d/0x2a
Jan 30 11:40:24 styx kernel:  [do_munmap+321/387] do_munmap+0x141/0x183
Jan 30 11:40:24 styx kernel:  [sys_ioctl+286/675] sys_ioctl+0x11e/0x2a3
Jan 30 11:40:24 styx kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 30 11:40:24 styx kernel:  [rpc_getport+127/435] rpc_getport+0x7f/0x1b3
Jan 30 11:40:24 styx kernel:
Jan 30 11:40:24 styx kernel: Code:  Bad EIP value.

The corresponding part of the .config is:
#
# ISDN subsystem
#
CONFIG_ISDN_BOOL=y

#
# Old ISDN4Linux
#
CONFIG_ISDN=m
CONFIG_ISDN_NET_SIMPLE=y
CONFIG_ISDN_NET_CISCO=y
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_ISDN_PPP_BSDCOMP=m
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DRV_LOOP=m

#
# CAPI subsystem
#
# CONFIG_ISDN_CAPI is not set

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=m

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
# CONFIG_HISAX_1TR6 is not set
# CONFIG_HISAX_NI1 is not set
CONFIG_HISAX_MAX_CARDS=2

#
# HiSax supported cards
#
# CONFIG_HISAX_16_0 is not set
# CONFIG_HISAX_16_3 is not set
# CONFIG_HISAX_TELESPCI is not set
# CONFIG_HISAX_S0BOX is not set
# CONFIG_HISAX_AVM_A1 is not set
# CONFIG_HISAX_FRITZPCI is not set
CONFIG_HISAX_AVM_A1_PCMCIA=y
# CONFIG_HISAX_ELSA is not set
# CONFIG_HISAX_IX1MICROR2 is not set
# CONFIG_HISAX_DIEHLDIVA is not set
# CONFIG_HISAX_ASUSCOM is not set
# CONFIG_HISAX_TELEINT is not set
# CONFIG_HISAX_HFCS is not set
# CONFIG_HISAX_SEDLBAUER is not set
# CONFIG_HISAX_SPORTSTER is not set
# CONFIG_HISAX_MIC is not set
# CONFIG_HISAX_NETJET is not set
# CONFIG_HISAX_NETJET_U is not set
# CONFIG_HISAX_NICCY is not set
# CONFIG_HISAX_ISURF is not set
# CONFIG_HISAX_HSTSAPHIR is not set
# CONFIG_HISAX_BKM_A4T is not set
# CONFIG_HISAX_SCT_QUADRO is not set
# CONFIG_HISAX_GAZEL is not set
# CONFIG_HISAX_HFC_PCI is not set
# CONFIG_HISAX_W6692 is not set
# CONFIG_HISAX_HFC_SX is not set
# CONFIG_HISAX_ENTERNOW_PCI is not set
# CONFIG_HISAX_DEBUG is not set
# CONFIG_HISAX_ELSA_CS is not set
CONFIG_HISAX_AVM_A1_CS=m
# CONFIG_HISAX_ST5481 is not set
# CONFIG_HISAX_FRITZ_PCIPNP is not set
# CONFIG_HISAX_FRITZ_CLASSIC is not set
# CONFIG_HISAX_HFCPCI is not set

#
# Active cards
#
# CONFIG_ISDN_DRV_ICN is not set
# CONFIG_ISDN_DRV_PCBIT is not set
# CONFIG_ISDN_DRV_SC is not set
# CONFIG_ISDN_DRV_ACT2000 is not set
# CONFIG_ISDN_DRV_TPAM is not set
# CONFIG_HYSDN is not set

Hope this is enough to tell what's wrong

Greetings,
Todor

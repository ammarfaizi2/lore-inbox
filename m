Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLFNRT>; Wed, 6 Dec 2000 08:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131622AbQLFNQ7>; Wed, 6 Dec 2000 08:16:59 -0500
Received: from mel.alcatel.fr ([212.208.74.132]:21866 "EHLO mel.alcatel.fr")
	by vger.kernel.org with ESMTP id <S129423AbQLFNQw>;
	Wed, 6 Dec 2000 08:16:52 -0500
Message-ID: <3A2E34EF.CADF15EC@vz.cit.alcatel.fr>
Date: Wed, 06 Dec 2000 13:45:35 +0100
From: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>
Organization: xgen@linuxstart.com
X-Mailer: Mozilla 4.7 [fr] (WinNT; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Subject: Looping Oops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the command "ping -f " sent by an Irnet/toshoboe
to my Irnet/Irtty machine running kernel 2.4.0.test11-pre3
I got this Oops
each turn the call trace has 11 more values.


ksymoops 2.3.4 on i586 2.4.0-0.6mdk.  Options used
     -V (default)
     -k ksyms-1 (specified)
     -l modul-1 (specified)
     -o /lib/modules/2.4.0-0.6mdk/ (default)
     -m /usr/src/linux/System.map (default)



irttp_data_request_Rbb400e5c(), No data, or not connected
irnet: ppp_irnet_send(): IrTTP doesn't like this packet !!! (0xFFFFFF95)
Warning: kfree_skb passed an skb still on a list (from c307fe5e).
kernel BUG at skbuff.c:276!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c018a058>]
EFLAGS: 00010296
eax: 0000001c   ebx: c1f13d00   ecx: 00000001   edx: 00000001
esi: c1f13d00   edi: c1a64400   ebp: c1f13d00   esp: c10b7c28
ds: 0018   es: 0018   ss: 0018
Process kapm-idled (pid: 2, stackpage=c10b7000)
Stack: c01e0b61 c01e0c80 00000114 c1a64400 c307fe43 c307fe5e c1f13d00 c1a6bb80
       c1a6bb80 c1d18a44 c1d18a44 c1a64400 00000000 c307b3fb c1a64460 c1f13d00
       c1a64848 c307af1e c1a6bb80 c1a64848 c1a64800 c307b57a c1a6bb80 c1a64848
Call Trace: [<c01e0b61>] [<c01e0c80>] [<c307fe43>] [<c307fe5e>] [<c307b3fb>] [<c307af1e>] [<c307b57a>]
       [<c307beb1>] [<c3080af8>] [<c305d42a>] [<c305d2e6>] [<c307fe31>] [<c307b3fb>] [<c307b386>] [<c307af6d>]
       [<c307ad14>] [<c018f57e>] [<c018ba6c>] [<c01957dd>] [<c0196469>] [<c01accdf>] [<c01acabc>] [<ea000201>]
       [<ea000201>] [<c01ad293>] [<c0189fde>] [<c01ad548>] [<c0192fbf>] [<c019332d>] [<c018bf03>] [<c01197ce>]
       [<c010a138>] [<c0108e60>] [<c010dc8d>] [<c0100018>] [<c010dd80>] [<c010e57f>] [<c01c58fc>] [<c010ee9c>]
       [<c0105000>] [<c010742e>] [<c0107437>]
Code: 0f 0b 83 c4 0c 8b 4c 24 0c 8b 51 2c 85 d2 74 07 ff 4a 04 8b

>>EIP; c018a058 <__kfree_skb+34/160>   <=====
Trace; c01e0b61 <vga_con+821/25c5>
Trace; c01e0c80 <vga_con+940/25c5>
Trace; c307fe43 <[irnet]ppp_irnet_send+1c7/1f4>
Trace; c307fe5e <[irnet]ppp_irnet_send+1e2/1f4>
Trace; c307b3fb <[ppp_generic]ppp_push+3b/98>
Trace; c307af1e <[ppp_generic]ppp_xmit_process+12/d0>
Trace; c307b57a <[ppp_generic]ppp_channel_push+122/134>
Trace; c307beb1 <[ppp_generic]ppp_output_wakeup+11/18>
Trace; c3080af8 <[irnet]irnet_flow_indication+20/24>
Trace; c305d42a <[irda]irttp_run_tx_queue+13a/154>
Trace; c305d2e6 <[irda]irttp_data_request+1be/1c8>
Trace; c307fe31 <[irnet]ppp_irnet_send+1b5/1f4>
Trace; c307b3fb <[ppp_generic]ppp_push+3b/98>
Trace; c307b386 <[ppp_generic]ppp_send_frame+3aa/3e4>
Trace; c307af6d <[ppp_generic]ppp_xmit_process+61/d0>
Trace; c307ad14 <[ppp_generic]ppp_start_xmit+1c0/1fc>
Trace; c018f57e <qdisc_restart+4e/c8>
Trace; c018ba6c <dev_queue_xmit+2c/124>
Trace; c01957dd <ip_output+a5/100>
Trace; c0196469 <ip_build_xmit+27d/31c>
Trace; c01accdf <icmp_reply+19b/1b8>
Trace; c01acabc <icmp_glue_bits+0/88>
Trace; ea000201 <END_OF_CODE+26f7b36e/????>
Trace; ea000201 <END_OF_CODE+26f7b36e/????>
Trace; c01ad293 <icmp_echo+3f/48>
Trace; c0189fde <kfree_skbmem+26/6c>
Trace; c01ad548 <icmp_rcv+a4/dc>
Trace; c0192fbf <ip_local_deliver+e3/184>
Trace; c019332d <ip_rcv+2cd/350>
Trace; c018bf03 <net_rx_action+11b/1d4>
Trace; c01197ce <do_softirq+4e/74>
Trace; c010a138 <do_IRQ+9c/ac>
Trace; c0108e60 <ret_from_intr+0/20>
Trace; c010dc8d <apm_bios_call_simple+35/5c>
Trace; c0100018 <startup_32+18/139>
Trace; c010dd80 <apm_do_idle+14/30>
Trace; c010e57f <apm_mainloop+8f/f0>
Trace; c01c58fc <error_table+4dc/3884>
Trace; c010ee9c <apm+278/29c>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c010742e <kernel_thread+1a/30>
Trace; c0107437 <kernel_thread+23/30>
Code;  c018a058 <__kfree_skb+34/160>
00000000 <_EIP>:
Code;  c018a058 <__kfree_skb+34/160>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c018a05a <__kfree_skb+36/160>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c018a05d <__kfree_skb+39/160>
   5:   8b 4c 24 0c               mov    0xc(%esp,1),%ecx
Code;  c018a061 <__kfree_skb+3d/160>
   9:   8b 51 2c                  mov    0x2c(%ecx),%edx
Code;  c018a064 <__kfree_skb+40/160>
   c:   85 d2                     test   %edx,%edx
Code;  c018a066 <__kfree_skb+42/160>
   e:   74 07                     je     17 <_EIP+0x17> c018a06f <__kfree_skb+4b/160>
Code;  c018a068 <__kfree_skb+44/160>
  10:   ff 4a 04                  decl   0x4(%edx)
Code;  c018a06b <__kfree_skb+47/160>
  13:   8b 00                     mov    (%eax),%eax

Aiee, killing interrupt handler
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0113b13>]
EFLAGS: 00010292
eax: 0000001b   ebx: 00000000   ecx: 00000001   edx: 00000001
esi: fffffff9   edi: 0000000b   ebp: c10b7b34   esp: c10b7ae4
ds: 0018   es: 0018   ss: 0018
Process kapm-idled (pid: 2, stackpage=c10b7000)
Stack: c01c6e61 c01c6fb6 000002ba c01f5160 c10b6000 0000000b 00000001 c10b6000
       00000020 c0115f9a c10b7bf4 c10b6000 0000000b c01184ea c10b6000 c10b6000
       c01f5160 00000000 c10b6000 c1f13d00 c1f13d00 c01187d6 c10b7bf4 00000000
Call Trace: [<c01c6e61>] [<c01c6fb6>] [<c0115f9a>] [<c01184ea>] [<c01187d6>] [<c01094e4>] [<c01092ce>]
       [<c0109563>] [<c01c2ffc>] [<c018a058>] [<c0109f9d>] [<c010a138>] [<c0108ee4>] [<c018a058>] [<c01e0b61>]
       [<c01e0c80>] [<c307fe43>] [<c307fe5e>] [<c307b3fb>] [<c307af1e>] [<c307b57a>] [<c307beb1>] [<c3080af8>]
       [<c305d42a>] [<c305d2e6>] [<c307fe31>] [<c307b3fb>] [<c307b386>] [<c307af6d>] [<c307ad14>] [<c018f57e>]
       [<c018ba6c>] [<c01957dd>] [<c0196469>] [<c01accdf>] [<c01acabc>] [<ea000201>] [<ea000201>] [<c01ad293>]
       [<c0189fde>] [<c01ad548>] [<c0192fbf>] [<c019332d>] [<c018bf03>] [<c01197ce>] [<c010a138>] [<c0108e60>]
       [<c010dc8d>] [<c0100018>] [<c010dd80>] [<c010e57f>] [<c01c58fc>] [<c010ee9c>] [<c0105000>] [<c010742e>]
       [<c0107437>]
Code: 0f 0b 8d 65 bc 5b 5e 5f 89 ec 5d c3 90 55 89 e5 83 ec 20 57

>>EIP; c0113b13 <schedule+493/4a0>   <=====
Trace; c01c6e61 <error_table+1a41/3884>
Trace; c01c6fb6 <error_table+1b96/3884>
Trace; c0115f9a <printk+18e/19c>
Trace; c01184ea <exit_notify+116/214>
Trace; c01187d6 <do_exit+1ee/1f4>
Trace; c01094e4 <do_invalid_op+0/88>
Trace; c01092ce <die+42/44>
Trace; c0109563 <do_invalid_op+7f/88>
Trace; c01c2ffc <stext_lock+1ffc/2ac0>
Trace; c018a058 <__kfree_skb+34/160>
Trace; c0109f9d <handle_IRQ_event+31/5c>
Trace; c010a138 <do_IRQ+9c/ac>
Trace; c0108ee4 <error_code+34/40>

Trace; c018a058 <__kfree_skb+34/160>
Trace; c01e0b61 <vga_con+821/25c5>
Trace; c01e0c80 <vga_con+940/25c5>
Trace; c307fe43 <[irnet]ppp_irnet_send+1c7/1f4>
Trace; c307fe5e <[irnet]ppp_irnet_send+1e2/1f4>
Trace; c307b3fb <[ppp_generic]ppp_push+3b/98>
Trace; c307af1e <[ppp_generic]ppp_xmit_process+12/d0>
Trace; c307b57a <[ppp_generic]ppp_channel_push+122/134>
Trace; c307beb1 <[ppp_generic]ppp_output_wakeup+11/18>
Trace; c3080af8 <[irnet]irnet_flow_indication+20/24>
Trace; c305d42a <[irda]irttp_run_tx_queue+13a/154>
Trace; c305d2e6 <[irda]irttp_data_request+1be/1c8>
Trace; c307fe31 <[irnet]ppp_irnet_send+1b5/1f4>
Trace; c307b3fb <[ppp_generic]ppp_push+3b/98>
Trace; c307b386 <[ppp_generic]ppp_send_frame+3aa/3e4>
Trace; c307af6d <[ppp_generic]ppp_xmit_process+61/d0>
Trace; c307ad14 <[ppp_generic]ppp_start_xmit+1c0/1fc>
Trace; c018f57e <qdisc_restart+4e/c8>
Trace; c018ba6c <dev_queue_xmit+2c/124>
Trace; c01957dd <ip_output+a5/100>
Trace; c0196469 <ip_build_xmit+27d/31c>
Trace; c01accdf <icmp_reply+19b/1b8>
Trace; c01acabc <icmp_glue_bits+0/88>
Trace; ea000201 <END_OF_CODE+26f7b36e/????>
Trace; ea000201 <END_OF_CODE+26f7b36e/????>
Trace; c01ad293 <icmp_echo+3f/48>
Trace; c0189fde <kfree_skbmem+26/6c>
Trace; c01ad548 <icmp_rcv+a4/dc>
Trace; c0192fbf <ip_local_deliver+e3/184>
Trace; c019332d <ip_rcv+2cd/350>
Trace; c018bf03 <net_rx_action+11b/1d4>
Trace; c01197ce <do_softirq+4e/74>
Trace; c010a138 <do_IRQ+9c/ac>
Trace; c0108e60 <ret_from_intr+0/20>
Trace; c010dc8d <apm_bios_call_simple+35/5c>
Trace; c0100018 <startup_32+18/139>
Trace; c010dd80 <apm_do_idle+14/30>
Trace; c010e57f <apm_mainloop+8f/f0>
Trace; c01c58fc <error_table+4dc/3884>
Trace; c010ee9c <apm+278/29c>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c010742e <kernel_thread+1a/30>
Trace; c0107437 <kernel_thread+23/30>
Code;  c0113b13 <schedule+493/4a0>
00000000 <_EIP>:
Code;  c0113b13 <schedule+493/4a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0113b15 <schedule+495/4a0>
   2:   8d 65 bc                  lea    0xffffffbc(%ebp),%esp
Code;  c0113b18 <schedule+498/4a0>
   5:   5b                        pop    %ebx
Code;  c0113b19 <schedule+499/4a0>
   6:   5e                        pop    %esi
Code;  c0113b1a <schedule+49a/4a0>
   7:   5f                        pop    %edi
Code;  c0113b1b <schedule+49b/4a0>
   8:   89 ec                     mov    %ebp,%esp
Code;  c0113b1d <schedule+49d/4a0>
   a:   5d                        pop    %ebp
Code;  c0113b1e <schedule+49e/4a0>
   b:   c3                        ret
Code;  c0113b1f <schedule+49f/4a0>
   c:   90                        nop
Code;  c0113b20 <__wake_up+0/140>
   d:   55                        push   %ebp
Code;  c0113b21 <__wake_up+1/140>
   e:   89 e5                     mov    %esp,%ebp
Code;  c0113b23 <__wake_up+3/140>
  10:   83 ec 20                  sub    $0x20,%esp
Code;  c0113b26 <__wake_up+6/140>
  13:   57                        push   %edi

Aiee, killing interrupt handler
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0113b13>]
EFLAGS: 00010286
eax: 0000001b   ebx: 00000000   ecx: 00000001   edx: 00000001
esi: fffffff9   edi: 0000000b   ebp: c10b79f0   esp: c10b79a0
ds: 0018   es: 0018   ss: 0018
Process kapm-idled (pid: 2, stackpage=c10b7000)
Stack: c01c6e61 c01c6fb6 000002ba 00000000 c10b6000 0000000b 00000001 c10b6000
       00000020 c0115f9a c10b7ab0 c10b6000 0000000b c01184ea c10b6000 c10b6000
       00000000 00000000 c10b6000 c10b7b34 c10b7b34 c01187d6 c10b7ab0 00000000
Call Trace: [<c01c6e61>] [<c01c6fb6>] [<c0115f9a>] [<c01184ea>] [<c01187d6>] [<c01094e4>] [<c01092ce>]
       [<c0109563>] [<c01c2ffc>] [<c0113b13>] [<c0109f9d>] [<c010a138>] [<c0108ee4>] [<c0113b13>] [<c01c6e61>]
       [<c01c6fb6>] [<c0115f9a>] [<c01184ea>] [<c01187d6>] [<c01094e4>] [<c01092ce>] [<c0109563>] [<c01c2ffc>]
       [<c018a058>] [<c0109f9d>] [<c010a138>] [<c0108ee4>] [<c018a058>] [<c01e0b61>] [<c01e0c80>] [<c307fe43>]
       [<c307fe5e>] [<c307b3fb>] [<c307af1e>] [<c307b57a>] [<c307beb1>] [<c3080af8>] [<c305d42a>] [<c305d2e6>]
       [<c307fe31>] [<c307b3fb>] [<c307b386>] [<c307af6d>] [<c307ad14>] [<c018f57e>] [<c018ba6c>] [<c01957dd>]
       [<c0196469>] [<c01accdf>] [<c01acabc>] [<ea000201>] [<ea000201>] [<c01ad293>] [<c0189fde>] [<c01ad548>]
       [<c0192fbf>] [<c019332d>] [<c018bf03>] [<c01197ce>] [<c010a138>] [<c0108e60>] [<c010dc8d>] [<c0100018>]
       [<c010dd80>] [<c010e57f>] [<c01c58fc>] [<c010ee9c>] [<c0105000>] [<c010742e>] [<c0107437>]
Code: 0f 0b 8d 65 bc 5b 5e 5f 89 ec 5d c3 90 55 89 e5 83 ec 20 57

>>EIP; c0113b13 <schedule+493/4a0>   <=====
Trace; c01c6e61 <error_table+1a41/3884>
Trace; c01c6fb6 <error_table+1b96/3884>
Trace; c0115f9a <printk+18e/19c>
Trace; c01184ea <exit_notify+116/214>
Trace; c01187d6 <do_exit+1ee/1f4>
Trace; c01094e4 <do_invalid_op+0/88>
Trace; c01092ce <die+42/44>
Trace; c0109563 <do_invalid_op+7f/88>
Trace; c01c2ffc <stext_lock+1ffc/2ac0>
Trace; c0113b13 <schedule+493/4a0>
Trace; c0109f9d <handle_IRQ_event+31/5c>
Trace; c010a138 <do_IRQ+9c/ac>

Trace; c0108ee4 <error_code+34/40>
Trace; c0113b13 <schedule+493/4a0>
Trace; c01c6e61 <error_table+1a41/3884>
Trace; c01c6fb6 <error_table+1b96/3884>
Trace; c0115f9a <printk+18e/19c>
Trace; c01184ea <exit_notify+116/214>
Trace; c01187d6 <do_exit+1ee/1f4>
Trace; c01094e4 <do_invalid_op+0/88>
Trace; c01092ce <die+42/44>
Trace; c0109563 <do_invalid_op+7f/88>
Trace; c01c2ffc <stext_lock+1ffc/2ac0>

Trace; c018a058 <__kfree_skb+34/160>
Trace; c0109f9d <handle_IRQ_event+31/5c>
Trace; c010a138 <do_IRQ+9c/ac>
Trace; c0108ee4 <error_code+34/40>
Trace; c018a058 <__kfree_skb+34/160>
Trace; c01e0b61 <vga_con+821/25c5>
Trace; c01e0c80 <vga_con+940/25c5>



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbULRG1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbULRG1D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 01:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbULRG1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 01:27:02 -0500
Received: from customers.imt.ru ([212.16.0.33]:39429 "HELO smtp.direct.ru")
	by vger.kernel.org with SMTP id S262844AbULRG0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 01:26:39 -0500
Date: Sat, 18 Dec 2004 09:27:30 +0300
From: Crazy AMD K7 <snort2004@mail.ru>
X-Mailer: The Bat! (v1.46d)
Reply-To: Crazy AMD K7 <snort2004@mail.ru>
X-Priority: 3 (Normal)
Message-ID: <1131604877.20041218092730@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: do_IRQ: stack overflow: 872..
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------3F3C2342240EF6D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------3F3C2342240EF6D
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit

Hi!
I have found a few days ago strange messages in /var/log/messages
More than 10 times there was do_IRQ: stack overflow: (nimber).... followed
with code. If need I can send all this data. I have run
ksymoops with only first 3 cases. Here is the first, the second and
the third are in attachment.
After that oopses my system continued to work.

uname uname -a
Linux linux 2.4.28 #2 Втр Ноя 30 15:43:35 MSK 2004 i686 unknown
gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)
I have applies ebtables_brnf patch (http://bridge.sf.net) and a
small add to it. The problem occur a few days later I have installed a
new hdd.


My system works as a bridge.
Processor AMDK7-900
RAM 512Mb
HDD IDE 200+200Gb
NIC Compex RE100TX(rtl8139 chipset)


If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux linux 2.4.28 #2 Втр Ноя 30 15:43:35 MSK 2004 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.18
e2fsprogs              1.27
reiserfsprogs          3.x.0j
quota-tools            3.01.
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded


ksymoops 2.4.4 on i686 2.4.28.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.28/ (default)
     -m /boot/System.map-2.4.28-2 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Dec 14 21:23:49 localhost kernel: c0262414 00000368 00000002 c0325640 00000028 c03256f0 c010a508 00000002 
Dec 14 21:23:49 localhost kernel:        00000028 000001f3 c0325640 00000028 c03256f0 00000079 00000018 00000018 
Dec 14 21:23:49 localhost kernel:        ffffff0a c01c17ba 00000010 00000286 c01d0025 00000079 000001f3 00000028 
Dec 14 21:23:49 localhost kernel: Call Trace:    [<c010a508>] [<c01c17ba>] [<c01d0025>] [<c01c9c0d>] [<c01c9ee2>]
Dec 14 21:23:49 localhost kernel:   [<c01ca35f>] [<c01ce520>] [<c0108079>] [<c0108208>] [<c010a508>] [<c02576bb>]
Dec 14 21:23:49 localhost kernel:   [<c0208dc8>] [<c020777b>] [<c020790d>] [<c01be170>] [<c0108208>] [<c010822c>]
Dec 14 21:23:49 localhost kernel:   [<c020afd5>] [<c02530e0>] [<c02146fc>] [<c020b1de>] [<c02530e0>] [<c024642c>]
Dec 14 21:23:49 localhost kernel:   [<c0253199>] [<c02130b3>] [<c02530e0>] [<c02530e0>] [<c021342e>] [<c0213460>]
Dec 14 21:23:49 localhost kernel:   [<c0253199>] [<c02130b3>] [<c0256e10>] [<c02530e0>] [<c0244098>] [<c02530e0>]
Dec 14 21:23:49 localhost kernel:   [<c02130b3>] [<c02530e0>] [<c02530e0>] [<c021342e>] [<c02530e0>] [<c02130b3>]
Dec 14 21:23:49 localhost kernel:   [<c02531b0>] [<c02531e9>] [<c02530e0>] [<c0213460>] [<c01be188>] [<c02531b0>]
Dec 14 21:23:49 localhost kernel:   [<c0256cbf>] [<c02531b0>] [<c02146c4>] [<c02531b0>] [<c02130b3>] [<c02531b0>]
Dec 14 21:23:49 localhost kernel:   [<c02531b0>] [<c021342e>] [<c02531b0>] [<c020777b>] [<c020790d>] [<c025322a>]
Dec 14 21:23:49 localhost kernel:   [<c02531b0>] [<c02532ab>] [<c025276a>] [<c020b02e>] [<c025279d>] [<c020b255>]
Dec 14 21:23:49 localhost kernel:   [<c0244098>] [<c021e9e7>] [<c02530e0>] [<c02530e0>] [<c021342e>] [<c021e940>]
Dec 14 21:23:49 localhost kernel:   [<c0256f61>] [<c021e940>] [<c02130b3>] [<c021e940>] [<c021e940>] [<c021342e>]
Dec 14 21:23:49 localhost kernel:   [<c021e940>] [<c0213460>] [<c021d649>] [<c021e940>] [<c02531b0>] [<c02130b3>]
Dec 14 21:23:49 localhost kernel:   [<c02531b0>] [<c021eb60>] [<c0246498>] [<c021ea40>] [<c0256f61>] [<c021ea40>]
Dec 14 21:23:49 localhost kernel:   [<c02130b3>] [<c021ea40>] [<c021ea40>] [<c021342e>] [<c021ea40>] [<c02146c4>]
Dec 14 21:23:49 localhost kernel:   [<c021dac1>] [<c021ea40>] [<c01be188>] [<c020afd5>] [<c02146c4>] [<c024642c>]
Dec 14 21:23:49 localhost kernel:   [<c0253199>] [<c020b1de>] [<c023296d>] [<c022db29>] [<c02292c1>] [<c0228b18>]
Dec 14 21:23:49 localhost kernel:   [<c022e5e1>] [<c0256e10>] [<c022accb>] [<c022b929>] [<c022bd67>] [<c02530e0>]
Dec 14 21:23:49 localhost kernel:   [<c02130b3>] [<c02530e0>] [<c02530e0>] [<c021342e>] [<c02530e0>] [<c02130b3>]
Dec 14 21:23:49 localhost kernel:   [<c02531b0>] [<c02531e9>] [<c02530e0>] [<c0213460>] [<c02088f5>] [<c0233719>]
Dec 14 21:23:49 localhost kernel:   [<c023366e>] [<c0233bc4>] [<c0244098>] [<c021acb0>] [<c02463ac>] [<c021ad67>]
Dec 14 21:23:49 localhost kernel:   [<c021acb0>] [<c021acb0>] [<c021342e>] [<c021acb0>] [<c0213460>] [<c02560c0>]
Dec 14 21:23:49 localhost kernel:   [<c024642c>] [<c021ade0>] [<c021a93c>] [<c021acb0>] [<c02560c0>] [<c02188fd>]
Dec 14 21:23:49 localhost kernel:   [<c021ade0>] [<c021ade0>] [<c021af4b>] [<c0253b70>] [<c02568c0>] [<c021ade0>]
Dec 14 21:23:49 localhost kernel:   [<c0256e3b>] [<c02130b3>] [<c021ade0>] [<c021ade0>] [<c021342e>] [<c021ade0>]
Dec 14 21:23:49 localhost kernel:   [<c021d649>] [<c021e940>] [<c021ac7d>] [<c021ade0>] [<c0207212>] [<c0250f2c>]
Dec 14 21:23:49 localhost kernel:   [<c0253b70>] [<c02075a1>] [<c020b7df>] [<c020b87d>] [<c020b99c>] [<c0108079>]
Dec 14 21:23:49 localhost kernel:   [<c01176cb>] [<c010823c>] [<c010a508>] [<c015f13b>] [<c0158728>] [<c021ade0>]
Dec 14 21:23:49 localhost kernel:   [<c021ade0>] [<c021af4b>] [<c016320b>] [<c015ec35>] [<c0132e86>] [<c015ec97>]
Dec 14 21:23:49 localhost kernel:   [<c0158ab0>] [<c021ac7d>] [<c016320b>] [<c0158a53>] [<c0158b57>] [<c0158c2c>]
Dec 14 21:23:49 localhost kernel:   [<c015ef55>] [<c014312e>] [<c015384a>] [<c016320b>] [<c015ec35>] [<c015f29d>]
Dec 14 21:23:49 localhost kernel:   [<c0158728>] [<c0158791>] [<c01ce520>] [<c01d01d7>] [<c016320b>] [<c015ec35>]
Dec 14 21:23:49 localhost kernel:   [<c0132e86>] [<c012b094>] [<c015ec97>] [<c016320b>] [<c015ec35>] [<c0155b79>]
Dec 14 21:23:49 localhost kernel:   [<c0155e95>] [<c01297f5>] [<c0132bf8>] [<c0132c09>] [<c0132e86>] [<c0155d03>]
Dec 14 21:23:49 localhost kernel:   [<c015656d>] [<c0132e86>] [<c01330b1>] [<c01566c9>] [<c0133616>] [<c0164f07>]
Dec 14 21:23:49 localhost kernel:   [<c0133ecd>] [<c0156670>] [<c0156b1c>] [<c0156670>] [<c01297f5>] [<c012339d>]
Dec 14 21:23:49 localhost kernel:   [<c0125ec5>] [<c0126320>] [<c015467f>] [<c0131175>] [<c013eea8>] [<c0116feb>]
Dec 14 21:23:49 localhost kernel:   [<c0106cb3>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c010a508 <call_do_IRQ+5/d>
Trace; c01c17ba <ide_outb+a/10>
Trace; c01d0025 <__ide_do_rw_disk+155/520>
Trace; c01c9c0d <ide_start_request+18d/1c0>
Trace; c01c9ee2 <ide_do_request+272/2b0>
Trace; c01ca35f <ide_intr+df/100>
Trace; c01ce520 <ide_dma_intr+0/a0>
Trace; c0108079 <handle_IRQ_event+39/60>
Trace; c0108208 <do_IRQ+88/d0>
Trace; c010a508 <call_do_IRQ+5/d>
Trace; c02576bb <_mmx_memcpy+2b/150>
Trace; c0208dc8 <skb_copy_and_csum_dev+78/d0>
Trace; c020777b <kfree_skbmem+b/60>
Trace; c020790d <__kfree_skb+13d/150>
Trace; c01be170 <rtl8139_start_xmit+50/100>
Trace; c0108208 <do_IRQ+88/d0>
Trace; c010822c <do_IRQ+ac/d0>
Trace; c020afd5 <dev_queue_xmit_nit+15/a0>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c02146fc <qdisc_restart+4c/d0>
Trace; c020b1de <dev_queue_xmit+fe/260>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c024642c <ipt_route_hook+1c/20>
Trace; c0253199 <br_dev_queue_push_xmit+b9/d0>
Trace; c02130b3 <nf_iterate+33/90>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c021342e <nf_hook_slow+ae/140>
Trace; c0213460 <nf_hook_slow+e0/140>
Trace; c0253199 <br_dev_queue_push_xmit+b9/d0>
Trace; c02130b3 <nf_iterate+33/90>
Trace; c0256e10 <br_nf_post_routing+140/150>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c0244098 <ipt_do_table+308/450>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c02130b3 <nf_iterate+33/90>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c021342e <nf_hook_slow+ae/140>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c02130b3 <nf_iterate+33/90>
Trace; c02531b0 <br_forward_finish+0/40>
Trace; c02531e9 <br_forward_finish+39/40>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c0213460 <nf_hook_slow+e0/140>
Trace; c01be188 <rtl8139_start_xmit+68/100>
Trace; c02531b0 <br_forward_finish+0/40>
Trace; c0256cbf <br_nf_local_out+19f/1b0>
Trace; c02531b0 <br_forward_finish+0/40>
Trace; c02146c4 <qdisc_restart+14/d0>
Trace; c02531b0 <br_forward_finish+0/40>
Trace; c02130b3 <nf_iterate+33/90>
Trace; c02531b0 <br_forward_finish+0/40>
Trace; c02531b0 <br_forward_finish+0/40>
Trace; c021342e <nf_hook_slow+ae/140>
Trace; c02531b0 <br_forward_finish+0/40>
Trace; c020777b <kfree_skbmem+b/60>
Trace; c020790d <__kfree_skb+13d/150>
Trace; c025322a <__br_deliver+3a/40>
Trace; c02531b0 <br_forward_finish+0/40>
Trace; c02532ab <br_deliver+2b/50>
Trace; c025276a <__br_dev_xmit+6a/90>
Trace; c020b02e <dev_queue_xmit_nit+6e/a0>
Trace; c025279d <br_dev_xmit+d/10>
Trace; c020b255 <dev_queue_xmit+175/260>
Trace; c0244098 <ipt_do_table+308/450>
Trace; c021e9e7 <ip_finish_output2+a7/100>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c021342e <nf_hook_slow+ae/140>
Trace; c021e940 <ip_finish_output2+0/100>
Trace; c0256f61 <ip_sabotage_out+111/130>
Trace; c021e940 <ip_finish_output2+0/100>
Trace; c02130b3 <nf_iterate+33/90>
Trace; c021e940 <ip_finish_output2+0/100>
Trace; c021e940 <ip_finish_output2+0/100>
Trace; c021342e <nf_hook_slow+ae/140>
Trace; c021e940 <ip_finish_output2+0/100>
Trace; c0213460 <nf_hook_slow+e0/140>
Trace; c021d649 <ip_output+139/150>
Trace; c021e940 <ip_finish_output2+0/100>
Trace; c02531b0 <br_forward_finish+0/40>
Trace; c02130b3 <nf_iterate+33/90>
Trace; c02531b0 <br_forward_finish+0/40>
Trace; c021eb60 <ip_queue_xmit2+120/1f7>
Trace; c0246498 <ipt_local_hook+68/b0>
Trace; c021ea40 <ip_queue_xmit2+0/1f7>
Trace; c0256f61 <ip_sabotage_out+111/130>
Trace; c021ea40 <ip_queue_xmit2+0/1f7>
Trace; c02130b3 <nf_iterate+33/90>
Trace; c021ea40 <ip_queue_xmit2+0/1f7>
Trace; c021ea40 <ip_queue_xmit2+0/1f7>
Trace; c021342e <nf_hook_slow+ae/140>
Trace; c021ea40 <ip_queue_xmit2+0/1f7>
Trace; c02146c4 <qdisc_restart+14/d0>
Trace; c021dac1 <ip_queue_xmit+461/4b0>
Trace; c021ea40 <ip_queue_xmit2+0/1f7>
Trace; c01be188 <rtl8139_start_xmit+68/100>
Trace; c020afd5 <dev_queue_xmit_nit+15/a0>
Trace; c02146c4 <qdisc_restart+14/d0>
Trace; c024642c <ipt_route_hook+1c/20>
Trace; c0253199 <br_dev_queue_push_xmit+b9/d0>
Trace; c020b1de <dev_queue_xmit+fe/260>
Trace; c023296d <tcp_v4_send_check+6d/b0>
Trace; c022db29 <tcp_transmit_skb+549/670>
Trace; c02292c1 <tcp_clean_rtx_queue+221/320>
Trace; c0228b18 <tcp_fastretrans_alert+468/620>
Trace; c022e5e1 <tcp_write_xmit+151/290>
Trace; c0256e10 <br_nf_post_routing+140/150>
Trace; c022accb <tcp_data_queue+3bb/970>
Trace; c022b929 <__tcp_data_snd_check+49/d0>
Trace; c022bd67 <tcp_rcv_established+137/8d0>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c02130b3 <nf_iterate+33/90>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c021342e <nf_hook_slow+ae/140>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c02130b3 <nf_iterate+33/90>
Trace; c02531b0 <br_forward_finish+0/40>
Trace; c02531e9 <br_forward_finish+39/40>
Trace; c02530e0 <br_dev_queue_push_xmit+0/d0>
Trace; c0213460 <nf_hook_slow+e0/140>
Trace; c02088f5 <skb_checksum+45/240>
Trace; c0233719 <tcp_v4_do_rcv+29/100>
Trace; c023366e <tcp_v4_checksum_init+7e/100>
Trace; c0233bc4 <tcp_v4_rcv+3d4/620>
Trace; c0244098 <ipt_do_table+308/450>
Trace; c021acb0 <ip_local_deliver_finish+0/130>
Trace; c02463ac <ipt_hook+1c/20>
Trace; c021ad67 <ip_local_deliver_finish+b7/130>
Trace; c021acb0 <ip_local_deliver_finish+0/130>
Trace; c021acb0 <ip_local_deliver_finish+0/130>
Trace; c021342e <nf_hook_slow+ae/140>
Trace; c021acb0 <ip_local_deliver_finish+0/130>
Trace; c0213460 <nf_hook_slow+e0/140>
Trace; c02560c0 <br_nf_pre_routing_finish+0/1f0>
Trace; c024642c <ipt_route_hook+1c/20>
Trace; c021ade0 <ip_rcv_finish+0/1a0>
Trace; c021a93c <ip_local_deliver+17c/190>
Trace; c021acb0 <ip_local_deliver_finish+0/130>
Trace; c02560c0 <br_nf_pre_routing_finish+0/1f0>
Trace; c02188fd <ip_route_input+3d/130>
Trace; c021ade0 <ip_rcv_finish+0/1a0>
Trace; c021ade0 <ip_rcv_finish+0/1a0>
Trace; c021af4b <ip_rcv_finish+16b/1a0>
Trace; c0253b70 <br_handle_frame_finish+0/110>
Trace; c02568c0 <br_nf_pre_routing+330/350>
Trace; c021ade0 <ip_rcv_finish+0/1a0>
Trace; c0256e3b <ip_sabotage_in+1b/30>
Trace; c02130b3 <nf_iterate+33/90>
Trace; c021ade0 <ip_rcv_finish+0/1a0>
Trace; c021ade0 <ip_rcv_finish+0/1a0>
Trace; c021342e <nf_hook_slow+ae/140>
Trace; c021ade0 <ip_rcv_finish+0/1a0>
Trace; c021d649 <ip_output+139/150>
Trace; c021e940 <ip_finish_output2+0/100>
Trace; c021ac7d <ip_rcv+32d/360>
Trace; c021ade0 <ip_rcv_finish+0/1a0>
Trace; c0207212 <sock_def_readable+22/50>
Trace; c0250f2c <packet_rcv+ec/260>
Trace; c0253b70 <br_handle_frame_finish+0/110>
Trace; c02075a1 <alloc_skb+d1/190>
Trace; c020b7df <netif_receive_skb+17f/1b0>
Trace; c020b87d <process_backlog+6d/120>
Trace; c020b99c <net_rx_action+6c/100>
Trace; c0108079 <handle_IRQ_event+39/60>
Trace; c01176cb <do_softirq+4b/90>
Trace; c010823c <do_IRQ+bc/d0>
Trace; c010a508 <call_do_IRQ+5/d>
Trace; c015f13b <journal_dirty_metadata+1b/1a0>
Trace; c0158728 <ext3_do_update_inode+328/3c0>
Trace; c021ade0 <ip_rcv_finish+0/1a0>
Trace; c021ade0 <ip_rcv_finish+0/1a0>
Trace; c021af4b <ip_rcv_finish+16b/1a0>
Trace; c016320b <journal_cancel_revoke+fb/170>
Trace; c015ec35 <do_get_write_access+4b5/4e0>
Trace; c0132e86 <bread+16/80>
Trace; c015ec97 <journal_get_write_access+37/50>
Trace; c0158ab0 <ext3_reserve_inode_write+30/b0>
Trace; c021ac7d <ip_rcv+32d/360>
Trace; c016320b <journal_cancel_revoke+fb/170>
Trace; c0158a53 <ext3_mark_iloc_dirty+23/50>
Trace; c0158b57 <ext3_mark_inode_dirty+27/40>
Trace; c0158c2c <ext3_dirty_inode+bc/100>
Trace; c015ef55 <journal_get_undo_access+f5/120>
Trace; c014312e <__mark_inode_dirty+2e/90>
Trace; c015384a <ext3_new_block+aa/830>
Trace; c016320b <journal_cancel_revoke+fb/170>
Trace; c015ec35 <do_get_write_access+4b5/4e0>
Trace; c015f29d <journal_dirty_metadata+17d/1a0>
Trace; c0158728 <ext3_do_update_inode+328/3c0>
Trace; c0158791 <ext3_do_update_inode+391/3c0>
Trace; c01ce520 <ide_dma_intr+0/a0>
Trace; c01d01d7 <__ide_do_rw_disk+307/520>
Trace; c016320b <journal_cancel_revoke+fb/170>
Trace; c015ec35 <do_get_write_access+4b5/4e0>
Trace; c0132e86 <bread+16/80>
Trace; c012b094 <__alloc_pages+74/2c0>
Trace; c015ec97 <journal_get_write_access+37/50>
Trace; c016320b <journal_cancel_revoke+fb/170>
Trace; c015ec35 <do_get_write_access+4b5/4e0>
Trace; c0155b79 <ext3_alloc_block+19/20>
Trace; c0155e95 <ext3_alloc_branch+55/2d0>
Trace; c01297f5 <lru_cache_add+65/70>
Trace; c0132bf8 <getblk+28/60>
Trace; c0132c09 <getblk+39/60>
Trace; c0132e86 <bread+16/80>
Trace; c0155d03 <ext3_get_branch+53/d0>
Trace; c015656d <ext3_get_block_handle+1bd/2c0>
Trace; c0132e86 <bread+16/80>
Trace; c01330b1 <create_buffers+61/f0>
Trace; c01566c9 <ext3_get_block+59/60>
Trace; c0133616 <__block_prepare_write+e6/300>
Trace; c0164f07 <__jbd_kmalloc+27/a0>
Trace; c0133ecd <block_prepare_write+1d/40>
Trace; c0156670 <ext3_get_block+0/60>
Trace; c0156b1c <ext3_prepare_write+7c/120>
Trace; c0156670 <ext3_get_block+0/60>
Trace; c01297f5 <lru_cache_add+65/70>
Trace; c012339d <add_to_page_cache_unique+9d/b0>
Trace; c0125ec5 <do_generic_file_write+255/3e0>
Trace; c0126320 <generic_file_write+f0/110>
Trace; c015467f <ext3_file_write+1f/b0>
Trace; c0131175 <sys_write+95/f0>
Trace; c013eea8 <sys_select+468/480>
Trace; c0116feb <sys_gettimeofday+1b/a0>
Trace; c0106cb3 <system_call+33/38>


2 warnings issued.  Results may not be reliable.

Thank you,
Pasha
------------3F3C2342240EF6D
Content-Type: application/x-gzip; name="sto2.out.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sto2.out.txt.gz"

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
BqiRkUsVb+/u/gR0RVeDKjwAAA==

------------3F3C2342240EF6D
Content-Type: application/x-gzip; name="sto3.out.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sto3.out.txt.gz"

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

------------3F3C2342240EF6D--



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbTLBBaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 20:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbTLBBaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 20:30:10 -0500
Received: from www.stereoconnection.CA ([216.16.235.58]:27559 "EHLO
	nic.NetDirect.CA") by vger.kernel.org with ESMTP id S264275AbTLBB2z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 20:28:55 -0500
Date: Mon, 1 Dec 2003 20:28:53 -0500
From: Chris Frey <cdfrey@netdirect.ca>
To: linux-kernel@vger.kernel.org
Subject: [2.4.23] compile / link error in net/ipv4/netfilter
Message-ID: <20031201202853.A31914@netdirect.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using gcc 3.2.3.

When compiling 2.4.23, it stops during the compile with these errors:

gcc -D__KERNEL__ -I/home/cdfrey/kernel/linux-2.4.23-cube/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=ip_queue  -c -o ip_queue.o ip_queue.c
rm -f netfilter.o
ld -m elf_i386  -r -o netfilter.o ip_conntrack.o ip_conntrack_ftp.o ip_conntrack_irc.o ip_nat_ftp.o ip_nat_irc.o ip_tables.o iptable_filter.o iptable_mangle.o iptable_nat.o ipt_limit.o ipt_mark.o ipt_mac.o ipt_multiport.o ipt_owner.o ipt_tos.o ipt_ah.o ipt_esp.o ipt_length.o ipt_ttl.o ipt_state.o ipt_unclean.o ipt_tcpmss.o ipt_REJECT.o ipt_MIRROR.o ipt_TOS.o ipt_MARK.o ipt_MASQUERADE.o ipt_REDIRECT.o ip_nat_snmp_basic.o ipt_LOG.o ipt_ULOG.o ipt_TCPMSS.o arp_tables.o arptable_filter.o ipchains.o ipfwadm.o ip_queue.o
ipchains.o(.text.init+0xa0): In function `ip_conntrack_init':
: multiple definition of `ip_conntrack_init'
ip_conntrack.o(.text.init+0x20): first defined here
ipchains.o(.text+0x81c0): In function `ip_nat_cleanup':
: multiple definition of `ip_nat_cleanup'
iptable_nat.o(.text+0x2830): first defined here
ipchains.o(.text+0x77c0): In function `place_in_hashes':
: multiple definition of `place_in_hashes'
iptable_nat.o(.text+0x1e30): first defined here
ipchains.o(.text+0x8b60): In function `ip_nat_seq_adjust':
: multiple definition of `ip_nat_seq_adjust'
iptable_nat.o(.text+0x31d0): first defined here
ipchains.o(.data+0x480): multiple definition of `ip_ct_icmp_timeout'
ip_conntrack.o(.data+0x840): first defined here
ipchains.o(.data+0x1cc): multiple definition of `ip_ct_tcp_timeout_syn_recv'
ip_conntrack.o(.data+0x58c): first defined here
ipchains.o(.data+0x4fc): multiple definition of `protos'
iptable_nat.o(.data+0x120): first defined here
ipchains.o(.text+0x3c90): In function `ip_conntrack_expect_related':
: multiple definition of `ip_conntrack_expect_related'
ip_conntrack.o(.text+0x2e30): first defined here
ipchains.o(.data+0x504): multiple definition of `helpers'
iptable_nat.o(.data+0x128): first defined here
ipchains.o(.data+0x420): multiple definition of `ip_ct_udp_timeout'
ip_conntrack.o(.data+0x7e0): first defined here
ipchains.o(.data+0xa0): multiple definition of `ip_conntrack_lock'
ip_conntrack.o(.data+0x460): first defined here
ipchains.o(.text+0x6a50): In function `ip_nat_used_tuple':
: multiple definition of `ip_nat_used_tuple'
iptable_nat.o(.text+0x10c0): first defined here
ipchains.o(.text+0x52b0): In function `ip_ct_selective_cleanup':
: multiple definition of `ip_ct_selective_cleanup'
ip_conntrack.o(.text+0x4450): first defined here
ipchains.o(.text+0x8410): In function `ip_nat_mangle_tcp_packet':
: multiple definition of `ip_nat_mangle_tcp_packet'
iptable_nat.o(.text+0x2a80): first defined here
ipchains.o(.data+0x1d8): multiple definition of `ip_ct_tcp_timeout_close_wait'
ip_conntrack.o(.data+0x598): first defined here
ipchains.o(.data+0xa8): multiple definition of `ip_conntrack_expect_tuple_lock'
ip_conntrack.o(.data+0x468): first defined here
ipchains.o(.data+0x5a0): multiple definition of `ip_nat_protocol_tcp'
iptable_nat.o(.data+0x1c0): first defined here
ipchains.o(.text+0x8720): In function `ip_nat_mangle_udp_packet':
: multiple definition of `ip_nat_mangle_udp_packet'
iptable_nat.o(.text+0x2d90): first defined here
ipchains.o(.text+0x7990): In function `do_bindings':
: multiple definition of `do_bindings'
iptable_nat.o(.text+0x2000): first defined here
ipchains.o(.data+0x1d0): multiple definition of `ip_ct_tcp_timeout_established'
ip_conntrack.o(.data+0x590): first defined here
ipchains.o(.data+0x1e4): multiple definition of `ip_ct_tcp_timeout_close'
ip_conntrack.o(.data+0x5a4): first defined here
ipchains.o(.text+0x7230): In function `ip_nat_setup_info':
: multiple definition of `ip_nat_setup_info'
iptable_nat.o(.text+0x18a0): first defined here
ipchains.o(.text+0x54c0): In function `ip_conntrack_put':
: multiple definition of `ip_conntrack_put'
ip_conntrack.o(.text+0x4660): first defined here
ipchains.o(.text+0x3a70): In function `invert_tuplepr':
: multiple definition of `invert_tuplepr'
ip_conntrack.o(.text+0x2c10): first defined here
ipchains.o(.text+0x4ab0): In function `ip_conntrack_helper_register':
: multiple definition of `ip_conntrack_helper_register'
ip_conntrack.o(.text+0x3c50): first defined here
ipchains.o(.text+0x38e0): In function `ip_conntrack_in':
: multiple definition of `ip_conntrack_in'
ip_conntrack.o(.text+0x2a80): first defined here
ipchains.o(.text+0x6990): In function `find_nat_proto':
: multiple definition of `find_nat_proto'
iptable_nat.o(.text+0x1000): first defined here
ipchains.o(.text+0x5590): In function `ip_conntrack_expect_put':
: multiple definition of `ip_conntrack_expect_put'
ip_conntrack.o(.text+0x4730): first defined here
ipchains.o(.text+0x54f0): In function `get_tuple':
: multiple definition of `get_tuple'
ip_conntrack.o(.text+0x4690): first defined here
ipchains.o(.data+0x140): multiple definition of `ip_conntrack_generic_protocol'
ip_conntrack.o(.data+0x500): first defined here
ipchains.o(.data+0x540): multiple definition of `unknown_nat_protocol'
iptable_nat.o(.data+0x160): first defined here
ipchains.o(.text+0x4fb0): In function `ip_ct_gather_frags':
: multiple definition of `ip_ct_gather_frags'
ip_conntrack.o(.text+0x4150): first defined here
ipchains.o(.data+0xd0): multiple definition of `ip_conntrack_max'
ip_conntrack.o(.data+0x490): first defined here
ipchains.o(.data+0x424): multiple definition of `ip_ct_udp_timeout_stream'
ip_conntrack.o(.data+0x7e4): first defined here
ipchains.o(.data+0x4f4): multiple definition of `ip_nat_lock'
iptable_nat.o(.data+0x118): first defined here
ipchains.o(.text.init+0x430): In function `ip_nat_init':
: multiple definition of `ip_nat_init'
iptable_nat.o(.text.init+0x90): first defined here
ipchains.o(.text+0x3180): In function `ip_ct_find_helper':
: multiple definition of `ip_ct_find_helper'
ip_conntrack.o(.text+0x2320): first defined here
ipchains.o(.text+0x4e80): In function `ip_ct_refresh':
: multiple definition of `ip_ct_refresh'
ip_conntrack.o(.text+0x4020): first defined here
ipchains.o(.text+0x1c90): In function `ip_conntrack_expect_find_get':
: multiple definition of `ip_conntrack_expect_find_get'
ip_conntrack.o(.text+0xe30): first defined here
ipchains.o(.text+0x7f20): In function `icmp_reply_translation':
: multiple definition of `icmp_reply_translation'
iptable_nat.o(.text+0x2590): first defined here
ipchains.o(.data+0x1d4): multiple definition of `ip_ct_tcp_timeout_fin_wait'
ip_conntrack.o(.data+0x594): first defined here
ipchains.o(.text+0x1b00): In function `ip_ct_find_proto':
: multiple definition of `ip_ct_find_proto'
ip_conntrack.o(.text+0xca0): first defined here
ipchains.o(.text+0x6930): In function `ip_nat_cheat_check':
: multiple definition of `ip_nat_cheat_check'
iptable_nat.o(.text+0xfa0): first defined here
ipchains.o(.text+0x2790): In function `__ip_conntrack_confirm':
: multiple definition of `__ip_conntrack_confirm'
ip_conntrack.o(.text+0x1930): first defined here
ipchains.o(.text+0x2660): In function `ip_conntrack_find_get':
: multiple definition of `ip_conntrack_find_get'
ip_conntrack.o(.text+0x1800): first defined here
ipchains.o(.text+0x2760): In function `ip_conntrack_get':
: multiple definition of `ip_conntrack_get'
ip_conntrack.o(.text+0x1900): first defined here
ipchains.o(.text+0x9060): In function `ip_nat_helper_unregister':
: multiple definition of `ip_nat_helper_unregister'
iptable_nat.o(.text+0x36d0): first defined here
ipchains.o(.text+0x7660): In function `replace_in_hashes':
: multiple definition of `replace_in_hashes'
iptable_nat.o(.text+0x1cd0): first defined here
ipchains.o(.data+0x1e0): multiple definition of `ip_ct_tcp_timeout_time_wait'
ip_conntrack.o(.data+0x5a0): first defined here
ipchains.o(.data+0xcc): multiple definition of `ip_conntrack_htable_size'
ip_conntrack.o(.data+0x48c): first defined here
ipchains.o(.text+0x3ab0): In function `ip_conntrack_unexpect_related':
: multiple definition of `ip_conntrack_unexpect_related'
ip_conntrack.o(.text+0x2c50): first defined here
ipchains.o(.data+0x3e0): multiple definition of `ip_conntrack_protocol_tcp'
ip_conntrack.o(.data+0x7a0): first defined here
ipchains.o(.data+0x600): multiple definition of `ip_nat_protocol_udp'
iptable_nat.o(.data+0x220): first defined here
ipchains.o(.text+0x4bf0): In function `ip_conntrack_helper_unregister':
: multiple definition of `ip_conntrack_helper_unregister'
ip_conntrack.o(.text+0x3d90): first defined here
ipchains.o(.data+0x1c8): multiple definition of `ip_ct_tcp_timeout_syn_sent'
ip_conntrack.o(.data+0x588): first defined here
ipchains.o(.data+0x440): multiple definition of `ip_conntrack_protocol_udp'
ip_conntrack.o(.data+0x800): first defined here
ipchains.o(.data+0x1dc): multiple definition of `ip_ct_tcp_timeout_last_ack'
ip_conntrack.o(.data+0x59c): first defined here
ipchains.o(.text+0x8c50): In function `ip_nat_helper_register':
: multiple definition of `ip_nat_helper_register'
iptable_nat.o(.text+0x32c0): first defined here
ipchains.o(.data+0xb0): multiple definition of `ip_conntrack_destroyed'
ip_conntrack.o(.data+0x470): first defined here
ipchains.o(.text+0x1a40): In function `__ip_ct_find_proto':
: multiple definition of `__ip_ct_find_proto'
ip_conntrack.o(.text+0xbe0): first defined here
ipchains.o(.text+0x2ca0): In function `ip_conntrack_tuple_taken':
: multiple definition of `ip_conntrack_tuple_taken'
ip_conntrack.o(.text+0x1e40): first defined here
ipchains.o(.data+0x120): multiple definition of `ip_ct_generic_timeout'
ip_conntrack.o(.data+0x4e0): first defined here
ipchains.o(.data+0x660): multiple definition of `ip_nat_protocol_icmp'
iptable_nat.o(.data+0x280): first defined here
ipchains.o(.text+0x2da0): In function `icmp_error_track':
: multiple definition of `icmp_error_track'
ip_conntrack.o(.text+0x1f40): first defined here
ipchains.o(.text+0x5440): In function `ip_conntrack_cleanup':
: multiple definition of `ip_conntrack_cleanup'
ip_conntrack.o(.text+0x45e0): first defined here
ipchains.o(.text+0x4840): In function `ip_conntrack_alter_reply':
: multiple definition of `ip_conntrack_alter_reply'
ip_conntrack.o(.text+0x39e0): first defined here
ipchains.o(.text+0x4490): In function `ip_conntrack_change_expect':
: multiple definition of `ip_conntrack_change_expect'
ip_conntrack.o(.text+0x3630): first defined here
ipchains.o(.data+0x4c0): multiple definition of `ip_conntrack_protocol_icmp'
ip_conntrack.o(.data+0x880): first defined here
ipchains.o(.data+0xbc): multiple definition of `protocol_list'
ip_conntrack.o(.data+0x47c): first defined here
ipchains.o(.data+0xb4): multiple definition of `ip_conntrack_expect_list'
ip_conntrack.o(.data+0x474): first defined here
ipchains.o(.bss+0x4): multiple definition of `ip_conntrack_hash'
ip_conntrack.o(.bss+0x4): first defined here
ipchains.o(.data+0x524): multiple definition of `ip_nat_seqofs_lock'
iptable_nat.o(.data+0x148): first defined here
ipfwadm.o(.text.init+0xa0): In function `ip_conntrack_init':
: multiple definition of `ip_conntrack_init'
ip_conntrack.o(.text.init+0x20): first defined here
ipfwadm.o(.text+0x81c0): In function `ip_nat_cleanup':
: multiple definition of `ip_nat_cleanup'
iptable_nat.o(.text+0x2830): first defined here
ipfwadm.o(.text+0x77c0): In function `place_in_hashes':
: multiple definition of `place_in_hashes'
iptable_nat.o(.text+0x1e30): first defined here
ipfwadm.o(.text+0x8b60): In function `ip_nat_seq_adjust':
: multiple definition of `ip_nat_seq_adjust'
iptable_nat.o(.text+0x31d0): first defined here
ipfwadm.o(.text+0x0): In function `register_firewall':
: multiple definition of `register_firewall'
ipchains.o(.text+0x0): first defined here
ipfwadm.o(.data+0x480): multiple definition of `ip_ct_icmp_timeout'
ip_conntrack.o(.data+0x840): first defined here
ipfwadm.o(.data+0x1cc): multiple definition of `ip_ct_tcp_timeout_syn_recv'
ip_conntrack.o(.data+0x58c): first defined here
ipfwadm.o(.data+0x4fc): multiple definition of `protos'
iptable_nat.o(.data+0x120): first defined here
ipfwadm.o(.text+0x3c90): In function `ip_conntrack_expect_related':
: multiple definition of `ip_conntrack_expect_related'
ip_conntrack.o(.text+0x2e30): first defined here
ipfwadm.o(.data+0x504): multiple definition of `helpers'
iptable_nat.o(.data+0x128): first defined here
ipfwadm.o(.data+0x420): multiple definition of `ip_ct_udp_timeout'
ip_conntrack.o(.data+0x7e0): first defined here
ipfwadm.o(.data+0xa0): multiple definition of `ip_conntrack_lock'
ip_conntrack.o(.data+0x460): first defined here
ipfwadm.o(.text+0x6a50): In function `ip_nat_used_tuple':
: multiple definition of `ip_nat_used_tuple'
iptable_nat.o(.text+0x10c0): first defined here
ipfwadm.o(.text+0x52b0): In function `ip_ct_selective_cleanup':
: multiple definition of `ip_ct_selective_cleanup'
ip_conntrack.o(.text+0x4450): first defined here
ipfwadm.o(.text+0x8410): In function `ip_nat_mangle_tcp_packet':
: multiple definition of `ip_nat_mangle_tcp_packet'
iptable_nat.o(.text+0x2a80): first defined here
ipfwadm.o(.data+0x1d8): multiple definition of `ip_ct_tcp_timeout_close_wait'
ip_conntrack.o(.data+0x598): first defined here
ipfwadm.o(.data+0xa8): multiple definition of `ip_conntrack_expect_tuple_lock'
ip_conntrack.o(.data+0x468): first defined here
ipfwadm.o(.data+0x5a0): multiple definition of `ip_nat_protocol_tcp'
iptable_nat.o(.data+0x1c0): first defined here
ipfwadm.o(.text+0x8720): In function `ip_nat_mangle_udp_packet':
: multiple definition of `ip_nat_mangle_udp_packet'
iptable_nat.o(.text+0x2d90): first defined here
ipfwadm.o(.text+0x7990): In function `do_bindings':
: multiple definition of `do_bindings'
iptable_nat.o(.text+0x2000): first defined here
ipfwadm.o(.data+0x1d0): multiple definition of `ip_ct_tcp_timeout_established'
ip_conntrack.o(.data+0x590): first defined here
ipfwadm.o(.text+0x1410): In function `check_for_demasq':
: multiple definition of `check_for_demasq'
ipchains.o(.text+0x1410): first defined here
ipfwadm.o(.data+0x1e4): multiple definition of `ip_ct_tcp_timeout_close'
ip_conntrack.o(.data+0x5a4): first defined here
ipfwadm.o(.text.init+0x20): In function `masq_init':
: multiple definition of `masq_init'
ipchains.o(.text.init+0x20): first defined here
ipfwadm.o(.text+0x7230): In function `ip_nat_setup_info':
: multiple definition of `ip_nat_setup_info'
iptable_nat.o(.text+0x18a0): first defined here
ipfwadm.o(.text+0x54c0): In function `ip_conntrack_put':
: multiple definition of `ip_conntrack_put'
ip_conntrack.o(.text+0x4660): first defined here
ipfwadm.o(.text+0x3a70): In function `invert_tuplepr':
: multiple definition of `invert_tuplepr'
ip_conntrack.o(.text+0x2c10): first defined here
ipfwadm.o(.text+0x4ab0): In function `ip_conntrack_helper_register':
: multiple definition of `ip_conntrack_helper_register'
ip_conntrack.o(.text+0x3c50): first defined here
ipfwadm.o(.text+0x38e0): In function `ip_conntrack_in':
: multiple definition of `ip_conntrack_in'
ip_conntrack.o(.text+0x2a80): first defined here
ipfwadm.o(.text+0x6990): In function `find_nat_proto':
: multiple definition of `find_nat_proto'
iptable_nat.o(.text+0x1000): first defined here
ipfwadm.o(.text+0x5590): In function `ip_conntrack_expect_put':
: multiple definition of `ip_conntrack_expect_put'
ip_conntrack.o(.text+0x4730): first defined here
ipfwadm.o(.text+0x1390): In function `check_for_masq_error':
: multiple definition of `check_for_masq_error'
ipchains.o(.text+0x1390): first defined here
ipfwadm.o(.text+0x54f0): In function `get_tuple':
: multiple definition of `get_tuple'
ip_conntrack.o(.text+0x4690): first defined here
ipfwadm.o(.data+0x140): multiple definition of `ip_conntrack_generic_protocol'
ip_conntrack.o(.data+0x500): first defined here
ipfwadm.o(.data+0x540): multiple definition of `unknown_nat_protocol'
iptable_nat.o(.data+0x160): first defined here
ipfwadm.o(.text+0x4fb0): In function `ip_ct_gather_frags':
: multiple definition of `ip_ct_gather_frags'
ip_conntrack.o(.text+0x4150): first defined here
ipfwadm.o(.data+0xd0): multiple definition of `ip_conntrack_max'
ip_conntrack.o(.data+0x490): first defined here
ipfwadm.o(.data+0x424): multiple definition of `ip_ct_udp_timeout_stream'
ip_conntrack.o(.data+0x7e4): first defined here
ipfwadm.o(.data+0x4f4): multiple definition of `ip_nat_lock'
iptable_nat.o(.data+0x118): first defined here
ipfwadm.o(.text+0xafe0): In function `ip_fw_ctl':
: multiple definition of `ip_fw_ctl'
ipchains.o(.text+0xb250): first defined here
ld: Warning: size of symbol `ip_fw_ctl' changed from 1120 in ipchains.o to 567 in ipfwadm.o
ipfwadm.o(.text+0x1080): In function `do_masquerade':
: multiple definition of `do_masquerade'
ipchains.o(.text+0x1080): first defined here
ipfwadm.o(.text.init+0x430): In function `ip_nat_init':
: multiple definition of `ip_nat_init'
iptable_nat.o(.text.init+0x90): first defined here
ipfwadm.o(.text+0x3180): In function `ip_ct_find_helper':
: multiple definition of `ip_ct_find_helper'
ip_conntrack.o(.text+0x2320): first defined here
ipfwadm.o(.text+0x4e80): In function `ip_ct_refresh':
: multiple definition of `ip_ct_refresh'
ip_conntrack.o(.text+0x4020): first defined here
ipfwadm.o(.text+0x1c90): In function `ip_conntrack_expect_find_get':
: multiple definition of `ip_conntrack_expect_find_get'
ip_conntrack.o(.text+0xe30): first defined here
ipfwadm.o(.text+0x7f20): In function `icmp_reply_translation':
: multiple definition of `icmp_reply_translation'
iptable_nat.o(.text+0x2590): first defined here
ipfwadm.o(.text+0x1630): In function `ip_fw_masq_timeouts':
: multiple definition of `ip_fw_masq_timeouts'
ipchains.o(.text+0x1630): first defined here
ipfwadm.o(.data+0x1d4): multiple definition of `ip_ct_tcp_timeout_fin_wait'
ip_conntrack.o(.data+0x594): first defined here
ipfwadm.o(.text+0x1b00): In function `ip_ct_find_proto':
: multiple definition of `ip_ct_find_proto'
ip_conntrack.o(.text+0xca0): first defined here
ipfwadm.o(.text+0x6930): In function `ip_nat_cheat_check':
: multiple definition of `ip_nat_cheat_check'
iptable_nat.o(.text+0xfa0): first defined here
ipfwadm.o(.text+0xa90): In function `do_redirect':
: multiple definition of `do_redirect'
ipchains.o(.text+0xa90): first defined here
ipfwadm.o(.text+0x2790): In function `__ip_conntrack_confirm':
: multiple definition of `__ip_conntrack_confirm'
ip_conntrack.o(.text+0x1930): first defined here
ipfwadm.o(.text+0x2660): In function `ip_conntrack_find_get':
: multiple definition of `ip_conntrack_find_get'
ip_conntrack.o(.text+0x1800): first defined here
ipfwadm.o(.text+0x2760): In function `ip_conntrack_get':
: multiple definition of `ip_conntrack_get'
ip_conntrack.o(.text+0x1900): first defined here
ipfwadm.o(.text+0x50): In function `unregister_firewall':
: multiple definition of `unregister_firewall'
ipchains.o(.text+0x50): first defined here
ipfwadm.o(.text+0x9060): In function `ip_nat_helper_unregister':
: multiple definition of `ip_nat_helper_unregister'
iptable_nat.o(.text+0x36d0): first defined here
ipfwadm.o(.text+0x7660): In function `replace_in_hashes':
: multiple definition of `replace_in_hashes'
iptable_nat.o(.text+0x1cd0): first defined here
ipfwadm.o(.data+0x1e0): multiple definition of `ip_ct_tcp_timeout_time_wait'
ip_conntrack.o(.data+0x5a0): first defined here
ipfwadm.o(.data+0xcc): multiple definition of `ip_conntrack_htable_size'
ip_conntrack.o(.data+0x48c): first defined here
ipfwadm.o(.text+0x3ab0): In function `ip_conntrack_unexpect_related':
: multiple definition of `ip_conntrack_unexpect_related'
ip_conntrack.o(.text+0x2c50): first defined here
ipfwadm.o(.text+0xb570): In function `ipfw_input_check':
: multiple definition of `ipfw_input_check'
ipchains.o(.text+0xba10): first defined here
ld: Warning: size of symbol `ipfw_input_check' changed from 87 in ipchains.o to 57 in ipfwadm.o
ipfwadm.o(.data+0x3e0): multiple definition of `ip_conntrack_protocol_tcp'
ip_conntrack.o(.data+0x7a0): first defined here
ipfwadm.o(.data+0x600): multiple definition of `ip_nat_protocol_udp'
iptable_nat.o(.data+0x220): first defined here
ipfwadm.o(.text+0xef0): In function `check_for_unredirect':
: multiple definition of `check_for_unredirect'
ipchains.o(.text+0xef0): first defined here
ipfwadm.o(.text+0x4bf0): In function `ip_conntrack_helper_unregister':
: multiple definition of `ip_conntrack_helper_unregister'
ip_conntrack.o(.text+0x3d90): first defined here
ipfwadm.o(.data+0x1c8): multiple definition of `ip_ct_tcp_timeout_syn_sent'
ip_conntrack.o(.data+0x588): first defined here
ipfwadm.o(.data+0x440): multiple definition of `ip_conntrack_protocol_udp'
ip_conntrack.o(.data+0x800): first defined here
ipfwadm.o(.data+0x1dc): multiple definition of `ip_ct_tcp_timeout_last_ack'
ip_conntrack.o(.data+0x59c): first defined here
ipfwadm.o(.text+0x8c50): In function `ip_nat_helper_register':
: multiple definition of `ip_nat_helper_register'
iptable_nat.o(.text+0x32c0): first defined here
ipfwadm.o(.data+0xb0): multiple definition of `ip_conntrack_destroyed'
ip_conntrack.o(.data+0x470): first defined here
ipfwadm.o(.text+0x1a40): In function `__ip_ct_find_proto':
: multiple definition of `__ip_ct_find_proto'
ip_conntrack.o(.text+0xbe0): first defined here
ipfwadm.o(.text+0x2ca0): In function `ip_conntrack_tuple_taken':
: multiple definition of `ip_conntrack_tuple_taken'
ip_conntrack.o(.text+0x1e40): first defined here
ipfwadm.o(.data+0x120): multiple definition of `ip_ct_generic_timeout'
ip_conntrack.o(.data+0x4e0): first defined here
ipfwadm.o(.data+0x660): multiple definition of `ip_nat_protocol_icmp'
iptable_nat.o(.data+0x280): first defined here
ipfwadm.o(.text+0x19e0): In function `masq_cleanup':
: multiple definition of `masq_cleanup'
ipchains.o(.text+0x19e0): first defined here
ipfwadm.o(.text+0xb5f0): In function `ipfw_forward_check':
: multiple definition of `ipfw_forward_check'
ipchains.o(.text+0xbaf0): first defined here
ld: Warning: size of symbol `ipfw_forward_check' changed from 90 in ipchains.o to 57 in ipfwadm.o
ipfwadm.o(.text+0xda0): In function `check_for_redirect':
: multiple definition of `check_for_redirect'
ipchains.o(.text+0xda0): first defined here
ipfwadm.o(.text+0x2da0): In function `icmp_error_track':
: multiple definition of `icmp_error_track'
ip_conntrack.o(.text+0x1f40): first defined here
ipfwadm.o(.text+0x5440): In function `ip_conntrack_cleanup':
: multiple definition of `ip_conntrack_cleanup'
ip_conntrack.o(.text+0x45e0): first defined here
ipfwadm.o(.text+0x4840): In function `ip_conntrack_alter_reply':
: multiple definition of `ip_conntrack_alter_reply'
ip_conntrack.o(.text+0x39e0): first defined here
ipfwadm.o(.text+0x4490): In function `ip_conntrack_change_expect':
: multiple definition of `ip_conntrack_change_expect'
ip_conntrack.o(.text+0x3630): first defined here
ipfwadm.o(.data+0x4c0): multiple definition of `ip_conntrack_protocol_icmp'
ip_conntrack.o(.data+0x880): first defined here
ipfwadm.o(.data+0x6b0): multiple definition of `ipfw_ops'
ipchains.o(.data+0x684): first defined here
ipfwadm.o(.data+0xbc): multiple definition of `protocol_list'
ip_conntrack.o(.data+0x47c): first defined here
ipfwadm.o(.text+0xb5b0): In function `ipfw_output_check':
: multiple definition of `ipfw_output_check'
ipchains.o(.text+0xba70): first defined here
ld: Warning: size of symbol `ipfw_output_check' changed from 124 in ipchains.o to 57 in ipfwadm.o
ipfwadm.o(.data+0xb4): multiple definition of `ip_conntrack_expect_list'
ip_conntrack.o(.data+0x474): first defined here
ipfwadm.o(.text+0xb7b0): In function `ipfw_init_or_cleanup':
: multiple definition of `ipfw_init_or_cleanup'
ipchains.o(.text+0xbb50): first defined here
ld: Warning: size of symbol `ipfw_init_or_cleanup' changed from 407 in ipchains.o to 400 in ipfwadm.o
ipfwadm.o(.bss+0x4): multiple definition of `ip_conntrack_hash'
ip_conntrack.o(.bss+0x4): first defined here
ipfwadm.o(.data+0x524): multiple definition of `ip_nat_seqofs_lock'
iptable_nat.o(.data+0x148): first defined here
make[3]: *** [netfilter.o] Error 1
make[3]: Leaving directory `/home/cdfrey/kernel/linux-2.4.23-cube/net/ipv4/netfilter'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/home/cdfrey/kernel/linux-2.4.23-cube/net/ipv4/netfilter'
make[1]: *** [_subdir_ipv4/netfilter] Error 2
make[1]: Leaving directory `/home/cdfrey/kernel/linux-2.4.23-cube/net'
make: *** [_dir_net] Error 2



Here is .config:

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_ISA is not set
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_TCIC is not set
# CONFIG_I82092 is not set
CONFIG_I82365=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y

#
# ACPI Support
#
# CONFIG_ACPI is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_STATS is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_TFTP is not set
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
# CONFIG_IP_NF_MATCH_RECENT is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
# CONFIG_IP_NF_MATCH_HELPER is not set
CONFIG_IP_NF_MATCH_STATE=y
# CONFIG_IP_NF_MATCH_CONNTRACK is not set
CONFIG_IP_NF_MATCH_UNCLEAN=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=y
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
# CONFIG_IP_NF_TARGET_ECN is not set
# CONFIG_IP_NF_TARGET_DSCP is not set
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
# CONFIG_IP_NF_ARP_MANGLE is not set
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPFWADM=y
CONFIG_IP_NF_NAT_NEEDED=y

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_ARCNET_COM20020_CS is not set
# CONFIG_PCMCIA_IBMTR is not set
CONFIG_PCMCIA_XIRCOM=y
# CONFIG_PCMCIA_XIRTULIP is not set
# CONFIG_NET_PCMCIA_RADIO is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
# CONFIG_DRM is not set

#
# PCMCIA character devices
#
# CONFIG_PCMCIA_SERIAL_CS is not set
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
CONFIG_SOUND_FUSION=y
CONFIG_SOUND_CS4281=y
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=y
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_AD1889 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
CONFIG_SOUND_CS4232=y
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
# CONFIG_SOUND_SB is not set
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_KAHLUA is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set
# CONFIG_SOUND_AD1980 is not set
# CONFIG_SOUND_WM97XX is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=0

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
# CONFIG_FW_LOADER is not set


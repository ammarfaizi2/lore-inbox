Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVAOSMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVAOSMr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 13:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVAOSMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 13:12:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23709 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261926AbVAOSMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 13:12:43 -0500
Date: Sat, 15 Jan 2005 13:13:20 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.29-rc3
Message-ID: <20050115151320.GB7397@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here goes the third release candidate.

This one comes out to release a bunch of pending networking fixes from 
David Miller: netfilter, sctp, ipvs, etc.

Also changes the tty ldisc locking patches to not export a couple of API functions 
as GPL, because that breaks compatibility with older modutils.

This will become final if no problems appear.

Please help with testing!


Summary of changes from v2.4.29-rc2 to v2.4.29-rc3
============================================

<raivis:mt.lv>:
  o [NEIGH]: Calculate hash_val after possible table growth, not before

<scott:sonic.net>:
  o Fix net neighbour hash bug

David S. Miller:
  o [TG3]: Return 0 when PHY read times out, not all-ones
  o [TG3]: Fix signedness issues in PHY read/write loops
  o [TG3]: Update driver version and reldate
  o [INET_ECN]: Add INET_ECN_* enumeration from 2.6.x

Hideaki Yoshifuji:
  o [IPV6]: Fix tunnel list locking in sit.c

Jamal Hadi Salim:
  o [NET]: Add ETH_P_MPLS_* and ARPHRD_INFINIBAND defines from 2.6.x

Marcelo Tosatti:
  o Adrian/Arjan/Marcelo: change tty_wakeup/tty_ldisc_flush to non-GPL export for compat reasons and change requirement to modutils 2.4.10
  o Changed VERSION to 2.4.29-rc3

Olaf Kirch:
  o [NET]: Fix CMSG32_OK macros

Patrick McHardy:
  o [NETFILTER]: Associate locally generated ICMP errors with conntrack of original packet
  o [NETFILTER]: Remove CONFIG_IP_NF_NAT_LOCAL config option
  o [NETFILTER]: Save a level of indentation in icmp_reply_translation
  o [NETFILTER]: Apply PRE_ROUTING manips in LOCAL_OUT for locally generated icmp errors
  o [NETFILTER]: Verify NAT manips have been applied before reversing them in icmp_reply_translation
  o [NETFILTER]: Release dst_entry in PRE_ROUTING after NAT
  o [NETFILTER]: Fix stack leakage in iptables/ip6_tables

Phil Oester:
  o [NETFILTER]: revert MASQUERADE optimization for mostly static IPs

Sridhar Samudrala:
  o [SCTP] Fix potential null pointer dereference in sctp_err_lookup()
  o [SCTP] Code cleanup: remove unused code and make needlessly global code static
  o [SCTP] Treat ICMP protocol unreachable errors from non-SCTP capable hosts as ABORTs.
  o [SCTP] Validate and respond to invalid chunk/parameter lengths
  o [SCTP] Implementation of SCTP Implementer's Guide Section 2.35
  o [SCTP] Clean up the T3_rtx timer when deleting a transport
  o [SCTP] Fix bug in setting ephemeral port in the bind address
  o [SCTP] Fix misc. issues in SCTP_PEER_ADDR_PARAMS set socket option
  o [SCTP] Remove sk_xxx macros to be consistent with the rest of networking code and to avoid backporting issues.
  o [SCTP] Fix sctp_getladdrs() to return valid local addresses on an endpoint that is bound to INADDR_ANY or inaddr6_any.

Thomas Graf:
  o [PKT_SCHED]: dsmark should ignore ECN bits

Wensong Zhang:
  o [IPVS]: change to run master/backup sync daemon at a time

Yasuyuki Kozakai:
  o [NETFILTER]: Backport fixes for ip6t_LOG
  o [NETFILTER]: Backport fixes for ip6t_dst
  o [NETFILTER]: Fix check for ESP header size in ip6t_esp
  o [NETFILTER]: Backport fixes for ip6t_eui64
  o [NETFILTER]: Backport fixes for ip6t_frag
  o [NETFILTER]: Backport fixes for ip6t_hbh
  o [NETFILTER]: Backport fixes for ip6t_ipv6header
  o [NETFILTER]: Backport fixes for ip6t_multiport
  o [NETFILTER]: Backport fixes for ip6t_rt
  o [NETFILTER]: Backport fixes for ip6tables


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319249AbSH2Q2V>; Thu, 29 Aug 2002 12:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319251AbSH2Q2V>; Thu, 29 Aug 2002 12:28:21 -0400
Received: from cairu.terra.com.br ([200.176.3.19]:6318 "EHLO
	cairu.terra.com.br") by vger.kernel.org with ESMTP
	id <S319249AbSH2Q2U>; Thu, 29 Aug 2002 12:28:20 -0400
Date: Thu, 29 Aug 2002 13:32:39 -0300
From: Christian Reis <kiko@async.com.br>
To: linux-kernel@vger.kernel.org
Subject: DCC masquerading broken in 2.4.19?
Message-ID: <20020829133239.C7981@blackjesus.async.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

I'm getting messages like this in my logs, along with DCC sends from the
local network to external hosts failing:

Aug 29 12:44:27 anthem kernel: Forged DCC command from 192.168.99.3: 200.206.134.238:2049
Aug 29 12:44:29 anthem kernel: IN=eth1 OUT= MAC=00:04:75:7d:2b:6b:00:80:37:d9:4f:90:08:00 SRC=200.158.184.167 DST=200.206.134.238 LEN=60 TOS=0x00 PREC=0x00 TTL=60 ID=3428 DF PROTO=TCP SPT=35838 DPT=2049 WINDOW=5808 RES=0x00 SYN URGP=0 
Aug 29 12:44:35 anthem kernel: IN=eth1 OUT= MAC=00:04:75:7d:2b:6b:00:80:37:d9:4f:90:08:00 SRC=200.158.184.167 DST=200.206.134.238 LEN=60 TOS=0x00 PREC=0x00 TTL=60 ID=3429 DF PROTO=TCP SPT=35838 DPT=2049 WINDOW=5808 RES=0x00 SYN URGP=0 
[...]

anthem:~$ lsmod 
Module                  Size  Used by
ipt_MASQUERADE          1232   1 (autoclean)
ipt_LOG                 3184   2 (autoclean)
ipt_limit                912   3 (autoclean)
ipt_state                560  28 (autoclean)
iptable_filter          1696   1 (autoclean)
ip_conntrack_irc        2560   0 (unused)
ip_conntrack_ftp        3440   0 (unused)
ip_nat_irc              2416   0 (unused)
ip_nat_ftp              3120   0 (unused)
iptable_nat            13552   3 [ipt_MASQUERADE ip_nat_irc ip_nat_ftp]
ip_conntrack           13792   4 [ipt_MASQUERADE ipt_state ip_conntrack_irc ip_conntrack_ftp ip_nat_irc ip_nat_ftp iptable_nat]
ip_tables              10880   8 (autoclean) [ipt_MASQUERADE ipt_LOG ipt_limit ipt_state iptable_filter iptable_nat]

iptables is 1.2.6a, and I think at least i've applied all pending-patches.

Has anything changed noticeably? lsmod tells me I am all set, so what
could it be? 

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL

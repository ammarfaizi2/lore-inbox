Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVACDwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVACDwm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 22:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVACDwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 22:52:39 -0500
Received: from smtpout3.compass.net.nz ([203.97.97.135]:43913 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S261289AbVACDwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 22:52:33 -0500
Date: Mon, 3 Jan 2005 16:52:39 +1300 (NZDT)
From: steve@perfectpc.co.nz
X-X-Sender: sk@localhost
Reply-To: steve@perfectpc.co.nz
To: linux-kernel@vger.kernel.org
Subject: iptable_nat: Unknown symbol need_ip_conntrack
Message-ID: <Pine.LNX.4.60.0501031641250.32415@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I found these log in dmesg output but not sure how to get rid of them :-)

NET: Registered protocol family 17
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (511 buckets, 4088 max) - 332 bytes per conntrack
ip_conntrack_ftp: Unknown symbol ip_conntrack_expect_related
ip_conntrack_ftp: Unknown symbol ip_conntrack_helper_register
ip_conntrack_ftp: Unknown symbol ip_conntrack_expect_put
ip_conntrack_ftp: Unknown symbol ip_conntrack_expect_alloc
ip_conntrack_ftp: Unknown symbol ip_conntrack_helper_unregister
iptable_nat: Unknown symbol ip_ct_protos
iptable_nat: Unknown symbol ip_ct_selective_cleanup
iptable_nat: Unknown symbol invert_tuplepr
iptable_nat: Unknown symbol ip_ct_gather_frags
iptable_nat: Unknown symbol ip_conntrack_untracked
iptable_nat: Unknown symbol ip_conntrack_htable_size
iptable_nat: Unknown symbol ip_conntrack_tcp_update
iptable_nat: Unknown symbol ip_conntrack_destroyed
iptable_nat: Unknown symbol need_ip_conntrack
iptable_nat: Unknown symbol ip_conntrack_tuple_taken
iptable_nat: Unknown symbol ip_conntrack_alter_reply

Kernel 2.6.10-ac2 . Apart from this, the system appears to be normal; iptables
works as expected. (why the modules is still inserted with Unknown symbol...?)

One more thing, the same system if I run 2.4.27 kernel I got a lot of
message like:

MASQUERADE: Route sent us somewhere else.

and of course thing do not work properly. But with 2.6.10-ac1 and ac2
these log are gone. Is it problem with 2.4.27 ? (iptables and iproute2)

Should I worried? Did I do anything wrong?

Kind regards,

Steve Kieu


####################
Output of lsmod is:

sk@perfectpc-fw:~$ lsmod
Module                  Size  Used by
ipt_MARK                 608  10 
ipt_MASQUERADE           928  3 
ipt_REDIRECT             608  2 
ipt_REJECT              3808  6 
ipt_state                416  14 
iptable_mangle           896  1 
iptable_nat            15272  3 ipt_MASQUERADE,ipt_REDIRECT
ip_conntrack_ftp       69104  0 
iptable_filter          1440  1 
ip_conntrack           26548  4 ipt_MASQUERADE,ipt_state,iptable_nat,ip_conntrack_ftp
ip_tables              11040  8 ipt_MARK,ipt_MASQUERADE,ipt_REDIRECT,ipt_REJECT,ipt_state,iptable_mangle,iptable_nat,iptable_filter
af_packet              10888  8 
ppp_synctty             4960  0 
ethertap                1612  0 
tun                     3616  1 
sha1                    7264  0 
arc4                     640  0 
ppp_mppe_mppc          12580  0 
ppp_async               6112  2 
ppp_generic            17876  11 ppp_synctty,ppp_mppe_mppc,ppp_async
slhc                    4480  1 ppp_generic
crc_ccitt                864  1 ppp_async
ne2k_pci                3744  0 
8390                    5600  1 ne2k_pci
8139too                10912  0 
via_rhine              10852  0 
crc32                   2816  3 8390,8139too,via_rhine
3c59x                  24008  0 
atkbd                   8336  0 
i8042                   5376  0 
serio                   5064  4 atkbd,i8042
floppy                 42384  0 
ipv6                  179968  18

More info. on request.

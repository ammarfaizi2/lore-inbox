Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbTDZGjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 02:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbTDZGjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 02:39:11 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:29863 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S264629AbTDZGjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 02:39:07 -0400
Date: Fri, 25 Apr 2003 23:51:19 -0700
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: missing #includes?
Message-Id: <20030425235119.6f337e70.randy.dunlap@verizon.net>
Organization: YPO4
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__25_Apr_2003_23:51:19_-0700_08704f98"
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [4.64.196.31] at Sat, 26 Apr 2003 01:51:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Fri__25_Apr_2003_23:51:19_-0700_08704f98
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I wrote a trivial bash script to check if <sourcefiles> #include
<headerfile> when <symbol> is used.   Run it at top of kernel tree,
like so:

$ check-header  STACK_MAGIC   linux/kernel.h
error: linux/kernel.h not found in ./arch/h8300/kernel/traps.c


What's the preferred thing to do here?  I would like to see explicit
#includes when symbols are used.  Is that what others expect also?

However, it makes for quite a large list of missing includes.

-- 
~Randy


Here are 2 more examples.

$ check-header  KERN_EMERG    linux/kernel.h
error: linux/kernel.h not found in ./arch/ppc64/kernel/ras.c
error: linux/kernel.h not found in ./drivers/s390/cio/device_fsm.c
error: linux/kernel.h not found in ./drivers/s390/block/dasd_3990_erp.c
error: linux/kernel.h not found in ./drivers/s390/s390mach.c
error: linux/kernel.h not found in ./drivers/char/watchdog/pcwd.c
error: linux/kernel.h not found in ./drivers/char/agp/intel-agp.c
error: linux/kernel.h not found in ./drivers/base/power.c
error: linux/kernel.h not found in ./drivers/net/oaknet.c
error: linux/kernel.h not found in ./fs/reiserfs/prints.c
error: linux/kernel.h not found in ./fs/ext3/inode.c
error: linux/kernel.h not found in ./fs/jbd/journal.c
error: linux/kernel.h not found in ./fs/jbd/transaction.c
error: linux/kernel.h not found in ./kernel/sys.c
error: linux/kernel.h not found in ./kernel/panic.c

$ check-header  NIPQUAD   linux/kernel.h
error: linux/kernel.h not found in ./net/ipv4/netfilter/ip_conntrack_core.c
error: linux/kernel.h not found in ./net/ipv4/netfilter/ip_nat_core.c
error: linux/kernel.h not found in ./net/ipv4/netfilter/ip_tables.c
error: linux/kernel.h not found in ./net/ipv4/netfilter/ip_nat_tftp.c
error: linux/kernel.h not found in ./net/ipv4/netfilter/ip_nat_rule.c
error: linux/kernel.h not found in ./net/ipv4/netfilter/ip_conntrack_standalone.c
error: linux/kernel.h not found in ./net/ipv4/netfilter/ipt_TCPMSS.c
error: linux/kernel.h not found in ./net/ipv4/netfilter/ipt_MASQUERADE.c
error: linux/kernel.h not found in ./net/ipv4/netfilter/ip_conntrack_amanda.c
error: linux/kernel.h not found in ./net/ipv4/netfilter/ip_nat_ftp.c
error: linux/kernel.h not found in ./net/ipv4/netfilter/ip_conntrack_irc.c
error: linux/kernel.h not found in ./net/ipv4/netfilter/ip_conntrack_ftp.c
error: linux/kernel.h not found in ./net/ipv4/netfilter/ipchains_core.c
error: linux/kernel.h not found in ./net/ipv4/netfilter/ipt_LOG.c
error: linux/kernel.h not found in ./net/ipv4/udp.c
error: linux/kernel.h not found in ./net/ipv4/ip_fragment.c
error: linux/kernel.h not found in ./net/ipv4/tcp_ipv4.c
error: linux/kernel.h not found in ./net/ipv4/tcp_input.c
error: linux/kernel.h not found in ./net/ipv4/ipcomp.c
error: linux/kernel.h not found in ./net/ipv4/tcp_timer.c
error: linux/kernel.h not found in ./net/core/netfilter.c
error: linux/kernel.h not found in ./net/sunrpc/svcsock.c
error: linux/kernel.h not found in ./net/bridge/netfilter/ebt_log.c
error: linux/kernel.h not found in ./net/atm/mpoa_caches.c
error: linux/kernel.h not found in ./net/sctp/protocol.c
error: linux/kernel.h not found in ./net/sctp/sm_sideeffect.c
error: linux/kernel.h not found in ./fs/afs/proc.c
error: linux/kernel.h not found in ./fs/cifs/connect.c


--Multipart_Fri__25_Apr_2003_23:51:19_-0700_08704f98
Content-Type: application/octet-stream;
 name="check-header"
Content-Disposition: attachment;
 filename="check-header"
Content-Transfer-Encoding: base64

IyEgL2Jpbi9zaAojIENvcHlyaWdodCAoQykgMjAwMyBSYW5keSBEdW5sYXAKIyBHUEwgdmVyc2lv
biAyIGxpY2Vuc2UuCiMgY2hlY2sgZm9yIGZpbGVzIHRoYXQgdXNlIDxzeW1ib2w+IGZyb20gPGhl
YWRlcmZpbGU+IHdpdGhvdXQgI2luY2x1ZGUtaW5nCiMJdGhlIGhlYWRlciBmaWxlOwojIGUuZy4s
IGZvciBmaWxlcyB0aGF0IHVzZSBLRVJOX0RFQlVHIGZyb20gPGxpbnV4L2tlcm5lbC5oPgojIG9y
ICAgIGZvciBmaWxlcyB0aGF0IHVzZSBLRVJORUxfVkVSU0lPTiBmcm9tIDxsaW51eC92ZXJzaW9u
Lmg+CgpzeW1ib2w9JDEKaGZpbGU9JDIKCmlmIFsgIiRzeW1ib2wiID09ICIiIF07IHRoZW4KCWVj
aG8gInVzYWdlOiBjaGVjay1oZWFkZXIgc3ltYm9sIGhlYWRlcmZpbGUiCglleGl0IDEKZmkKaWYg
WyAiJGhmaWxlIiA9PSAiIiBdOyB0aGVuCgllY2hvICJ1c2FnZTogY2hlY2staGVhZGVyIHN5bWJv
bCBoZWFkZXJmaWxlIgoJZXhpdCAxCmZpCgpmaWxlbmFtZXM9JChmaW5kIC4gLW5hbWUgXCpcLmMg
fCB4YXJncyBncmVwIC1sIFxcXDwkc3ltYm9sXFxcPikKCmZvciBmaWxlIGluICRmaWxlbmFtZXMg
OyBkbwoKCWZvdW5kPWBncmVwIC1sICRoZmlsZSAkZmlsZWAKCWVycj0kPwoJaWYgWyAkZXJyICE9
IDAgXTsgdGhlbgoJCWVjaG8gImVycm9yOiAkaGZpbGUgbm90IGZvdW5kIGluICRmaWxlIgoJZmkK
CmRvbmUK

--Multipart_Fri__25_Apr_2003_23:51:19_-0700_08704f98--

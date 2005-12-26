Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbVLZQNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVLZQNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 11:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVLZQNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 11:13:37 -0500
Received: from main.gmane.org ([80.91.229.2]:33506 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751034AbVLZQNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 11:13:37 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: What is this GPF about?
Date: Tue, 27 Dec 2005 01:13:29 +0900
Message-ID: <dop4ra$lpm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I was experimenting eith IPSec on this machine, but does not seem to be related.

2005-12-26T07:26:57+0900 (alert) [kernel] general protection fault: 6c60 [#1]

The MSG below is from dmesg:

general protection fault: 6c60 [#1]
Modules linked in: xfrm_user deflate zlib_deflate zlib_inflate aes_i586 des sha256 sha1 crypto_null
af_key esp6 esp4 ah6 ah4 nfsd exportfs lockd nfs_acl sunrpc w83l785ts asb100 hwmon_vid hwmon
i2c_nforce2 i2c_core ppp_synctty ppp_async crc_ccitt ppp_generic slhc ipt_TCPMSS iptable_nat
ipt_REJECT ipt_state iptable_filter iptable_mangle ip_tables ext3 jbd mbcache ip_nat_ftp ip_nat
ip_conntrack_ftp ip_conntrack nfnetlink forcedeth via_rhine ehci_hcd ohci_hcd usbcore md5 ipv6
CPU:    0
EIP:    0060:[<c018156d>]    Not tainted VLI
EFLAGS: 00010202   (2.6.14.4-K01_AthlonXP_server)
EIP is at load_elf_binary+0x65d/0xd40
eax: 00000000   ebx: ce395200   ecx: 00002afc   edx: 0804aafc
esi: f3992b00   edi: 00000002   ebp: f41a0260   esp: dae89eb8
ds: 007b   es: 007b   ss: 0068
Process qmail-queue (pid: 13956, threadinfo=dae88000 task=d1277090)
Stack: f51e6c60 08048000 f3992b00 00000005 00001812 c14b78c0 08048000 00002afc
       08048000 00000000 08048000 00001812 00000005 f3992ac0 00000001 00000000
       00000000 08048000 00000000 08048000 e5bc6fec 00000000 00000009 00000000
Call Trace:
 [<c0160334>] copy_strings+0x174/0x200
 [<c01613c7>] search_binary_handler+0x67/0x1e0
 [<c01616d9>] do_execve+0x199/0x240
 [<c0101d8c>] sys_execve+0x3c/0x80
 [<c0103149>] syscall_call+0x7/0xb
Code: 39 d0 72 54 8b 54 24 18 03 54 24 1c 3b 54 24 60 8b 44 24 60 0f 47 c2 89 44 24 60 31 c0 39 54
24 48 0f 92 c0 85 46 18 8b 44 24 48 <0f> 45 c2 39 54 24 40 0f 43 54 24 40 89 44 24 48 89 54 24 40 8b

The qmail-send log didn't notice anything unusual.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|


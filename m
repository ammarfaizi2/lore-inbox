Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbTE0Nsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 09:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTE0Nsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 09:48:52 -0400
Received: from mail.gmx.de ([213.165.65.60]:23771 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263579AbTE0Nsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 09:48:50 -0400
Message-ID: <3ED36FD5.10005@gmx.net>
Date: Tue, 27 May 2003 16:01:57 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Werner.Beck@Lidl.de
CC: linux-kernel@vger.kernel.org
Subject: Re: Antwort: Re: Oops in Kernel 2.4.21-rc1
References: <OF8A85BDF9.FDFE6CE9-ONC1256D33.004946F5-C1256D33.00497FC6@eu.lidl.net>
In-Reply-To: <OF8A85BDF9.FDFE6CE9-ONC1256D33.004946F5-C1256D33.00497FC6@eu.lidl.net>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner.Beck@Lidl.de wrote:
> could that be the process mandb and aaa_base which where affected by the
> oops? How to disable this "feature"?

Open /etc/rc.config and try to find something like REINIT_MANDB and
DELETE_OLD_CATMAN and RUN_UPDATEDB. Set all of them to "no".

> Werner.Beck@Lidl.de wrote:
> 
>>Hello,
>>I encountered a Kernel oops on two different PCs, both a configured
>>identical. The system uses an ISDN connection to an Internet ISP and then
>>establishes a VPN tunnel based on PPTP.
>>As far as I can see in /var/log/messages the problem occurred on both
>>system at the same time at 00:15, but not at the same day and not every
>>day. No special program is running at that time. Basically it is a SuSE
>>7.3 distribution, I made a Kernel upgrade.
>>Hardware is a Fujitsu Siemens N300 PC with an IDE (7200 Rpm), Intel 845GI
>>Motherboard, an ISDN PBX connected via USB to dial-up, the connection
>>wasn't established when the system oopsed.
>>Attached are some information.

Are you sure that you used the right System.map? Was this the first
Oops? Only the first Oops of a kernel is meaningful. All Oopses after
that are mostly useless for tracking down the bug.

ksymoops 2.4.2 on i686 2.4.21-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-rc1/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol GPLONLY_ide_build_dmatable not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_destroy_dmatable
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_dma_intr not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_get_best_pio_mode
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
GPLONLY_ide_pci_register_driver not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
GPLONLY_ide_pci_unregister_driver not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_pio_timings not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_set_xfer_rate not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_dma not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_pci_device
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_ide_setup_pci_devices
not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ip_conntrack symbol
GPLONLY_ip_conntrack_expect_find_get not found in
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.21-rc1/ker
Warning (compare_maps): ip_conntrack symbol
GPLONLY_ip_conntrack_expect_put not found in
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.21-rc1/kernel/n
Warning (compare_maps): ip_conntrack symbol
GPLONLY_ip_conntrack_find_get not found in
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.21-rc1/kernel/net
Warning (compare_maps): ip_conntrack symbol GPLONLY_ip_conntrack_put not
found in
/lib/modules/2.4.21-rc1/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.21-rc1/kernel/net/ipv4
May 27 00:15:10 DE-BC4212 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
May 27 00:15:10 DE-BC4212 kernel: c012bb98
May 27 00:15:10 DE-BC4212 kernel: *pde = 00000000
May 27 00:15:10 DE-BC4212 kernel: Oops: 0000
May 27 00:15:10 DE-BC4212 kernel: CPU:    0
May 27 00:15:10 DE-BC4212 kernel: EIP:    0010:[kmem_cache_reap+212/504]
   Not tainted
May 27 00:15:10 DE-BC4212 kernel: EFLAGS: 00010007
May 27 00:15:10 DE-BC4212 kernel: eax: 00000000   ebx: 00000000   ecx:
c12efea0   edx: c12efeb0
May 27 00:15:10 DE-BC4212 kernel: esi: 00000000   edi: 00000002   ebp:
00000004   esp: cf731f58
May 27 00:15:10 DE-BC4212 kernel: ds: 0018   es: 0018   ss: 0018
May 27 00:15:10 DE-BC4212 kernel: Process kswapd (pid: 5,
stackpage=cf731000)
May 27 00:15:10 DE-BC4212 kernel: Stack: 00000020 000001d0 00000020
00000006 c12efea0 c02f56ac 00000000 00000000
May 27 00:15:10 DE-BC4212 kernel:        00000000 00000000 c012c9b8
00000006 000001d0 c02b6ed4 00000000 c02b6ed4
May 27 00:15:10 DE-BC4212 kernel:        c012ca52 00000020 c02b6ed4
00000001 cf730000 c012cb55 c02b6e20 00000000
May 27 00:15:10 DE-BC4212 kernel: Call Trace:    [shrink_caches+28/132]
[try_to_free_pages_zone+50/80] [kswapd_balance_pgdat+69/144]
[kswapd_balance+22/44] [kswapd+163/204]
May 27 00:15:10 DE-BC4212 kernel: Code: 8b 00 47 39 d0 75 f9 89 fa 89 f1
d3 e2 85 db 74 14 8d 04 95
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
   2:   47                        inc    %edi
Code;  00000002 Before first symbol
   3:   39 d0                     cmp    %edx,%eax
Code;  00000004 Before first symbol
   5:   75 f9                     jne    0 <_EIP>
Code;  00000006 Before first symbol
   7:   89 fa                     mov    %edi,%edx
Code;  00000008 Before first symbol
   9:   89 f1                     mov    %esi,%ecx
Code;  0000000a Before first symbol
   b:   d3 e2                     shl    %cl,%edx
Code;  0000000c Before first symbol
   d:   85 db                     test   %ebx,%ebx
Code;  0000000e Before first symbol
   f:   74 14                     je     25 <_EIP+0x25> 00000024 Before
first symbol
Code;  00000010 Before first symbol
  11:   8d 04 95 00 00 00 00      lea    0x0(,%edx,4),%eax


Regards,
Carl-Daniel


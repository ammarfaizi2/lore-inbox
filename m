Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284186AbRLWXQf>; Sun, 23 Dec 2001 18:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284176AbRLWXQ0>; Sun, 23 Dec 2001 18:16:26 -0500
Received: from johnson.mail.mindspring.net ([207.69.200.177]:48906 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S284147AbRLWXQV>; Sun, 23 Dec 2001 18:16:21 -0500
Message-ID: <3C26676A.3E4237C3@mindspring.com>
Date: Sun, 23 Dec 2001 15:23:22 -0800
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.17.. multiple oops 's
Content-Type: multipart/mixed;
 boundary="------------1364B82ECCA4CEF265BB1344"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1364B82ECCA4CEF265BB1344
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Well I was able to restore my system after the oopses but it was a
little disconcerning.

I had three oopses.  One while using X and logged into the internet, and
then the other two after that trying to rm -rf on a directory.

Attached are the outputs of the oopses if you have any questions about
this feel free to ask.

uname -r = 2.4.17
OS = RH 7.2
glibc = /lib/libc-2.2.4.so

if you'd like my .config just ask

the weird thing was I got this message about mtab on reboot with crc io
error and had to bring the machine to init 1 and umount / and then
manually run fsck.ext3 (yes ext3 fs) with the -f switch.

Joe
not on the list

--------------1364B82ECCA4CEF265BB1344
Content-Type: text/plain; charset=us-ascii;
 name="oops_2.4.17"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops_2.4.17"

Unable to handle kernel paging request at virtual address ab6589d8
printing eip:
 c0140b58
 *pde = 00000000
 Oops: 0002
 CPU:    0
 EIP:    0010:[prune_dcache+40/320]    Not tainted
 EIP:    0010:[<c0140b58>]    Not tainted
 EFLAGS: 00010212
 eax: c0211efc   ebx: cf4ce500   ecx: cf4ce458   edx: ab6589d8
 esi: cf4ce440   edi: cdfe0080   ebp: 000007e0   esp: c1839f58
 ds: 0018   es: 0018   ss: 0018
 Process kswapd (pid: 5, stackpage=c1839000)
 Stack: 00000008 000001d0 0000000e 00000005 c0140ecb 00000fd7 c012aa6b 00000005
      000001d0 00000005 000001d0 c0211248 c1838000 0002e4d6 c0211248 c012aacc
      0000000e c021125c c0211248 00000001 c012ab83 c02111a0 00000000 c1839fe0
 Call Trace: [shrink_dcache_memory+27/64] [shrink_caches+107/144] [try_to_free_pages+60/96] [kswapd_balance_pgdat+83/176] [kswapd_balance+22/48]
 Call Trace: [<c0140ecb>] [<c012aa6b>] [<c012aacc>] [<c012ab83>] [<c012abf6>]
  [kswapd+167/208] [_stext+0/48] [kernel_thread+35/48]
  [<c012ad17>] [<c0105000>] [<c0105733>]

 Code: 89 02 89 1b 89 5b 04 8d 73 e8 8b 46 54 a8 08 74 27 24 f7 89

###########################################################
  <1>Unable to handle kernel paging request at virtual address ab6589d8
  printing eip:
 c0140e50
 *pde = 00000000
 Oops: 0000
 CPU:    0
 EIP:    0010:[select_parent+64/128]    Not tainted
 EIP:    0010:[<c0140e50>]    Not tainted
 EFLAGS: 00010202
 eax: c6072758   ebx: c60727c0   ecx: c60727d8   edx: ab6589d8
 esi: c6072760   edi: df6ff8c0   ebp: 00000001   esp: c52d3f40
 ds: 0018   es: 0018   ss: 0018
 Process rm (pid: 2610, stackpage=c52d3000)
 Stack: df6ff8c0 d660857c df6ff8c0 d6608500 df6ff8e8 df6ff8c0 c0140ea6 df6ff8c0
        df6ff8c0 c013a760 df6ff8c0 d660857c c013a8b1 df6ff8c0 df6ff8c0 df6ff8c0
        c54fe000 c52d3fa4 c013aa0f d6608500 df6ff8c0 c52d2000 00000000 bfffeae0
 Call Trace: [shrink_dcache_parent+22/32] [d_unhash+32/80] [vfs_rmdir+289/448] [sys_rmdir+191/256] [system_call+51/56]
 Call Trace: [<c0140ea6>] [<c013a760>] [<c013a8b1>] [<c013aa0f>] [<c0106ecb>]

 Code: 8b 02 89 48 04 89 43 18 89 51 04 89 0a 8d 43 28 39 43 28 75
############################################################
  <1>Unable to handle kernel paging request at virtual address ab6589d8
  printing eip:
 c0140e50
 *pde = 00000000
 Oops: 0000
 CPU:    0
 EIP:    0010:[select_parent+64/128]    Not tainted
 EIP:    0010:[<c0140e50>]    Not tainted
 EFLAGS: 00010202
 eax: dadc0e58   ebx: dadc0ec0   ecx: dadc0ed8   edx: ab6589d8
 esi: dadc0e60   edi: db9f5140   ebp: 00000001   esp: d14b1f40
 ds: 0018   es: 0018   ss: 0018
 Process rm (pid: 2615, stackpage=d14b1000)
 Stack: db9f5140 d10545fc db9f5140 d1054580 db9f5168 db9f5140 c0140ea6 db9f5140
        db9f5140 c013a760 db9f5140 d10545fc c013a8b1 db9f5140 db9f5140 db9f5140
        d40de000 d14b1fa4 c013aa0f d1054580 db9f5140 d14b0000 00000000 bffff330
 Call Trace: [shrink_dcache_parent+22/32] [d_unhash+32/80] [vfs_rmdir+289/448] [sys_rmdir+191/256] [system_call+51/56]
 Call Trace: [<c0140ea6>] [<c013a760>] [<c013a8b1>] [<c013aa0f>] [<c0106ecb>]

 Code: 8b 02 89 48 04 89 43 18 89 51 04 89 0a 8d 43 28 39 43 28 75


--------------1364B82ECCA4CEF265BB1344--


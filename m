Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292936AbSBVR1A>; Fri, 22 Feb 2002 12:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292941AbSBVR0z>; Fri, 22 Feb 2002 12:26:55 -0500
Received: from harddata.com ([216.123.194.198]:14096 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S292936AbSBVR0p> convert rfc822-to-8bit;
	Fri, 22 Feb 2002 12:26:45 -0500
Date: Fri, 22 Feb 2002 10:26:41 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: "Bad pmd" storm with 2.4.18-rc1
Message-ID: <20020222102641.A32047@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



After 2.4.18-rc1 was up roughly 80 hours on Alpha (Nautilus, UP1500),
and seemed to be doing ok, I collected in a span of few minutes the
following in my logs and after that the box become unusable; only fit
enough to sync disks and reboot with a help of MagicSysRq keys.

Irrelevant stuff edited from log entries for a better readability.


 swap_dup: Bad swap file entry 120180d40
 VM: killing process bash(7919)
 07.
 memory.c:98: bad pmd 0000000120210aa0.
 memory.c:98: bad pmd 0000000120210ae0.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120211030.
 memory.c:98: bad pmd 0000000120072d30.
 memory.c:98: bad pmd 0000000000000107.
 memory.c:98: bad pmd 0000000120210f50.
 memory.c:98: bad pmd 0000000000000061.
 memory.c:98: bad pmd 00000001202109a0.
 memory.c:98: bad pmd 0000000120210f90.
 memory.c:98: bad pmd 0000000120072d30.
 memory.c:98: bad pmd 1b0c0000000000ae.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 000000012012d500.
 memory.c:98: bad pmd 00000001201f6670.
 memory.c:98: bad pmd 0000000000000239.
 memory.c:98: bad pmd 00000000000000c2.
 memory.c:98: bad pmd 0000000000000051.
 memory.c:98: bad pmd 0000000120211360.
 memory.c:98: bad pmd 00000001200abcf0.
 memory.c:98: bad pmd 1b1700b300000000.
 memory.c:98: bad pmd 0000000000000007.
 memory.c:98: bad pmd 0000000120210fd0.
 memory.c:98: bad pmd 0000000120210f90.
 memory.c:98: bad pmd 0000000000000002.
 memory.c:98: bad pmd 0000000000000031.
 memory.c:98: bad pmd 00000001202110b0.
 memory.c:98: bad pmd 0000000120073870.
 memory.c:98: bad pmd 1b3b000900000003.
 memory.c:98: bad pmd 0000000000000002.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120211220.
 memory.c:98: bad pmd 0000000120211120.
 memory.c:98: bad pmd 0000000120074b50.
 memory.c:98: bad pmd 1b3c007d0000000f.
 memory.c:98: bad pmd 000000000000010e.
 memory.c:98: bad pmd 0000000120211080.
 memory.c:98: bad pmd 0000000000000031.
 memory.c:98: bad pmd 0000000120211120.
 memory.c:98: bad pmd 0000000120073870.
 memory.c:98: bad pmd 1b3e000900000003.
 memory.c:98: bad pmd 0000000000002022.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 00000001202112e0.
 memory.c:98: bad pmd 00000001202111e0.
 memory.c:98: bad pmd 0000000120074b50.
 memory.c:98: bad pmd 1b3f007d00000010.
 memory.c:98: bad pmd 0000000000000127.
 memory.c:98: bad pmd 00000001202110f0.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 00000001202111a0.
 memory.c:98: bad pmd 0000000120072f30.
 memory.c:98: bad pmd 1b53000700000000.
 memory.c:98: bad pmd 0000000000001002.
 memory.c:98: bad pmd 0000000120135940.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 00000001202111e0.
 memory.c:98: bad pmd 0000000120075220.
 memory.c:98: bad pmd 1b54008600000011.
 memory.c:98: bad pmd 0000000000000137.
 memory.c:98: bad pmd 0000000120211160.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 00000001202112e0.
 memory.c:98: bad pmd 00000001200987a0.
 memory.c:98: bad pmd 1b55008300000012.
 memory.c:98: bad pmd 0000000000000127.
 memory.c:98: bad pmd 00000001202111a0.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120211160.
 memory.c:98: bad pmd 00000001200731f0.
 memory.c:98: bad pmd 1b3d00a200000000.
 memory.c:98: bad pmd 0000000000000127.
 memory.c:98: bad pmd 00000001202110b0.
 memory.c:98: bad pmd 00000001202110f0.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 00000001202112e0.
 memory.c:98: bad pmd 0000000120072d30.
 memory.c:98: bad pmd 0000000000000127.
 memory.c:98: bad pmd 0000000120211220.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120211360.
 memory.c:98: bad pmd 0000000120072d30.
 memory.c:98: bad pmd 0000000000000107.
 memory.c:98: bad pmd 0000000120211030.
 memory.c:98: bad pmd 0000000000000051.
 memory.c:98: bad pmd 0000000120211360.
 memory.c:98: bad pmd 00000001200a7810.
 memory.c:98: bad pmd 1b40009a00000000.
 memory.c:98: bad pmd 0000000000000287.
 memory.c:98: bad pmd 0000000120211330.
 memory.c:98: bad pmd 0000000120211260.
 memory.c:98: bad pmd 0000000000000002.
 memory.c:98: bad pmd 0000000000000031.
 memory.c:98: bad pmd 0000000120211080.
 memory.c:98: bad pmd 00000001202113a0.
 memory.c:98: bad pmd 0000000120072d70.
 memory.c:98: bad pmd 1b3a000300000000.
 memory.c:98: bad pmd 0000000000000002.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 00000001202113e0.
 memory.c:98: bad pmd 00000001200a7ab0.
 memory.c:98: bad pmd 1b41009b00000013.
 memory.c:98: bad pmd 0000000000000107.
 memory.c:98: bad pmd 00000001202112e0.
 memory.c:98: bad pmd 00000001202109a0.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120211080.
 memory.c:98: bad pmd 0000000120211260.
 memory.c:98: bad pmd 0000000120072d30.
 memory.c:98: bad pmd 0000000000000107.
 memory.c:98: bad pmd 00000001202112a0.
 memory.c:98: bad pmd 0000000000000051.
 memory.c:98: bad pmd 0000000120211ba0.
 memory.c:98: bad pmd 0000000120211ba0.
 memory.c:98: bad pmd 000000012009a300.
 memory.c:98: bad pmd 1b42009200000014.
 memory.c:98: bad pmd 0000000000000205.
 memory.c:98: bad pmd 0000000120211430.
 memory.c:98: bad pmd 0000000120211360.
 memory.c:98: bad pmd 0000000000000002.
 memory.c:98: bad pmd 0000000000000031.
 memory.c:98: bad pmd 0000000120210390.
 memory.c:98: bad pmd 0000000120210540.
 memory.c:98: bad pmd 0000000120072d70.
 memory.c:98: bad pmd 1b33000300000000.
 memory.c:98: bad pmd 0000000000000002.
 memory.c:98: bad pmd 0000000000000061.
 memory.c:98: bad pmd 0000000120211430.
 memory.c:98: bad pmd 00000001202113e0.
 memory.c:98: bad pmd 0000000120072bb0.
 memory.c:98: bad pmd 1b3200ae00000000.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 000000012012d500.
 memory.c:98: bad pmd 00000001201f6670.
 memory.c:98: bad pmd 000000000000023a.
 memory.c:98: bad pmd 00000000000000c2.
 memory.c:98: bad pmd 0000000000000031.
 memory.c:98: bad pmd 0000000120211740.
 memory.c:98: bad pmd 0000000120211700.
 memory.c:98: bad pmd 0000000120073870.
 memory.c:98: bad pmd 1b44000900000006.
 memory.c:98: bad pmd 0000000000000002.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120211b20.
 memory.c:98: bad pmd 0000000120072c60.
 memory.c:98: bad pmd 1b46000600000000.
 memory.c:98: bad pmd 0000000000001002.
 memory.c:98: bad pmd 00000001202072a0.
 memory.c:98: bad pmd 0000000000000021.
 memory.c:98: bad pmd 0000000100000017.
 memory.c:98: bad pmd 0000000000000017.
 memory.c:98: bad pmd 0000000000000071.
 memory.c:98: bad pmd 0000000120211620.
 memory.c:98: bad pmd 00000001202115c0.
 memory.c:98: bad pmd 0000000120211680.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 00000001201125d0.
 memory.c:98: bad pmd 0000000000000002.
 memory.c:98: bad pmd 0000000000000061.
 memory.c:98: bad pmd 00000001202072b0.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 00000001202072a0.
 memory.c:98: bad pmd 00000000000000c4.
 memory.c:98: bad pmd 00000001201ebe80.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120109da0.
 memory.c:98: bad pmd 00000000002a0000.
 memory.c:98: bad pmd 00000001202072a0.
 memory.c:98: bad pmd 0000000120211660.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 0000000000000021.
 memory.c:98: bad pmd 0000000000000017.
 memory.c:98: bad pmd 0000000000000021.
 memory.c:98: bad pmd 0000000000000017.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120109be8.
 memory.c:98: bad pmd 0000000002000000.
 memory.c:98: bad pmd 00000001202072a0.
 memory.c:98: bad pmd 00000001202116e0.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 0000000000000021.
 memory.c:98: bad pmd 0000000000000017.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120211780.
 memory.c:98: bad pmd 0000000120072d30.
 memory.c:98: bad pmd 000000000000000f.
 memory.c:98: bad pmd 0000000000000106.
 memory.c:98: bad pmd 00000001202114f0.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120211b20.
 memory.c:98: bad pmd 0000000120072fb0.
 memory.c:98: bad pmd 1b45009f00000000.
 memory.c:98: bad pmd 0000000000000106.
 memory.c:98: bad pmd 00000001202114c0.
 memory.c:98: bad pmd 00000001202114f0.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120211b20.
 memory.c:98: bad pmd 00000001202118a0.
 memory.c:98: bad pmd 0000000120072d30.
 memory.c:98: bad pmd 0000000000000106.
 memory.c:98: bad pmd 0000000120211740.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120211800.
 memory.c:98: bad pmd 0000000120072b30.
 memory.c:98: bad pmd 1b4a000500000000.
 memory.c:98: bad pmd 0000000000004002.
 memory.c:98: bad pmd 0000000120207290.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120211a90.
 memory.c:98: bad pmd 0000000120211a90.
 memory.c:98: bad pmd 00000001200aff10.
 memory.c:98: bad pmd 1b4b013500000000.
 memory.c:98: bad pmd 0000000000000106.
 memory.c:98: bad pmd 00000001202117c0.
 memory.c:98: bad pmd 0000000000000061.
 memory.c:98: bad pmd 00000001202117c0.
 memory.c:98: bad pmd 0000000120211800.
 memory.c:98: bad pmd 0000000120072bb0.
 memory.c:98: bad pmd 1b4900ae00000000.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 000000012012d500.
 memory.c:98: bad pmd 00000001201f6670.
 memory.c:98: bad pmd 000000000000023a.
 memory.c:98: bad pmd 00000000000000c6.
 memory.c:98: bad pmd 0000000000000051.
 memory.c:98: bad pmd 000000012020fe30.
 memory.c:98: bad pmd 0000000120078440.
 memory.c:98: bad pmd 1b5100b200000000.
 memory.c:98: bad pmd 000000000000000c.
 memory.c:98: bad pmd 0000000120211af0.
 memory.c:98: bad pmd 0000000120211a50.
 memory.c:98: bad pmd 0000000000000005.
 memory.c:98: bad pmd 0000000000000021.
 memory.c:98: bad pmd 6d616e20656d6f53.
 memory.c:98: bad pmd 6e20657261207365.
 memory.c:98: bad pmd 007367617420746f.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120211a50.
 memory.c:98: bad pmd 0000000120072f30.
 memory.c:98: bad pmd 1b4f000700000000.
 memory.c:98: bad pmd 0000000000004002.
 memory.c:98: bad pmd 0000000120131430.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 00000001202119d0.
 memory.c:98: bad pmd 0000000120072d30.
 memory.c:98: bad pmd 0000000000000011.
 memory.c:98: bad pmd 0000000000000106.
 memory.c:98: bad pmd 0000000120211910.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 0000000120211910.
 memory.c:98: bad pmd 0000000120211950.
 memory.c:98: bad pmd 0000000120072b30.
 memory.c:98: bad pmd 1b4e000500000000.
 memory.c:98: bad pmd 0000000000000022.
 memory.c:98: bad pmd 00000001202072d0.
 memory.c:98: bad pmd 0000000000000051.
 memory.c:98: bad pmd 0000000120211a50.
 memory.c:98: bad pmd 0000000120072d30.
 memory.c:98: bad pmd 000000000000008d.
 memory.c:98: bad pmd 0000000000000004.
 memory.c:98: bad pmd 0000000120211a20.
 memory.c:98: bad pmd 0000000120211950.
 memory.c:98: bad pmd 0000000000000002.
 memory.c:98: bad pmd 0000000000000031.
 memory.c:98: bad pmd 0000000120211990.
 memory.c:98: bad pmd 0000000120211990.
 memory.c:98: bad pmd 0000000120072d70.
 memory.c:98: bad pmd 1b4d000300000000.
 memory.c:98: bad pmd 0000000000000002.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 00000001202118a0.
 memory.c:98: bad pmd 000000012007b170.
 memory.c:98: bad pmd 1b5000a600000015.
 memory.c:98: bad pmd 0000000000002144.
 memory.c:98: bad pmd 00000001202119d0.
 memory.c:98: bad pmd 0000000000000061.
 memory.c:98: bad pmd 0000000120211a20.
 memory.c:98: bad pmd 0000000120211a50.
 memory.c:98: bad pmd 0000000120072bb0.
 memory.c:98: bad pmd 1b4c00ae00000000.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 000000012012d500.
 memory.c:98: bad pmd 00000001201f6670.
 memory.c:98: bad pmd 000000000000023a.
 memory.c:98: bad pmd 00000000000000c7.
 memory.c:98: bad pmd 0000000000000031.
 memory.c:98: bad pmd 0000000120211840.
 memory.c:98: bad pmd 0000000120211840.
 memory.c:98: bad pmd 0000000120077e90.
 memory.c:98: bad pmd 1b4800b100000000.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 000000012020fe30.
 memory.c:98: bad pmd 0000000120072fb0.
 memory.c:98: bad pmd 1b47009f00000000.
 memory.c:98: bad pmd 0000000000000104.
 memory.c:98: bad pmd 0000000120211780.
 memory.c:98: bad pmd 0000000120211af0.
 memory.c:98: bad pmd 0000000000000041.
 memory.c:98: bad pmd 000000012020fd30.
 memory.c:98: bad pmd 0000000120072d30.
 memory.c:98: bad pmd 000000000000010c.
 memory.c:98: bad pmd 0000000120211b20.
 memory.c:98: bad pmd 0000000000000061.
 memory.c:98: bad pmd 00000001202114c0.
 memory.c:98: bad pmd 0000000120211b60.
 memory.c:98: bad pmd 0000000120072bb0.
 memory.c:98: bad pmd 1b4300ae00000000.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 000000012012d500.
 memory.c:98: bad pmd 00000001201f6670.
 memory.c:98: bad pmd 000000000000023c.
 memory.c:98: bad pmd 00000000000000c4.
 memory.c:98: bad pmd 0000000000000101.
 memory.c:98: bad pmd 0000000120111f80.
 memory.c:98: bad pmd 0000000120202a30.
 memory.c:98: bad pmd 0000000120202a50.
 memory.c:98: bad pmd 0000000120202a70.
 memory.c:98: bad pmd 0000000120111f80.
 memory.c:98: bad pmd 0000000120111f80.
 memory.c:98: bad pmd 0000000120202ab0.
 memory.c:98: bad pmd 0000000120111f80.
            last message repeated 22 times
 memory.c:98: bad pmd 00000000000003d1.
 memory.c:98: bad pmd 000000012020fe70.
 memory.c:98: bad pmd ffffffffffffffff.
 memory.c:98: bad pmd 0000000000000003.
 memory.c:98: bad pmd 000000012020fe70.
 memory.c:98: bad pmd 0000000000000002.
 memory.c:98: bad pmd 00000001202120d0.
 memory.c:98: bad pmd 0000000000000003.
 memory.c:98: bad pmd 0000000000000003.
 memory.c:98: bad pmd 00000001202120d0.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 0000000120212180.
 memory.c:98: bad pmd 0000000000000003.
 memory.c:98: bad pmd 0000000000000003.
 memory.c:98: bad pmd 0000000120212180.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 0000000120212100.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 0000000000000003.
 memory.c:98: bad pmd 0000000120212100.
 memory.c:98: bad pmd 00000001202125d0.
 memory.c:98: bad pmd ffffffffffffffff.
 memory.c:98: bad pmd 0000000000000003.
 memory.c:98: bad pmd 00000001202125d0.
 memory.c:98: bad pmd 0000000000000002.
 memory.c:98: bad pmd 0000000120213f40.
 memory.c:98: bad pmd 0000000000000017.
 memory.c:98: bad pmd 000000000000001d.
 memory.c:98: bad pmd 0000000120213f40.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 0000000120214df0.
 memory.c:98: bad pmd 0000000000000017.
 memory.c:98: bad pmd 000000000000001d.
 memory.c:98: bad pmd 0000000120214df0.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 0000000120212660.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 0000000000000003.
 memory.c:98: bad pmd 0000000120212660.
 memory.c:98: bad pmd 0000000120212cc0.
 memory.c:98: bad pmd 0000000000000001.
 memory.c:98: bad pmd 0000000000000003.
 memory.c:98: bad pmd 0000000120212cc0.
 memory.c:98: bad pmd 0000000000000002.
 memory.c:98: bad pmd 00000001201f8710.
 memory.c:98: bad pmd 0000000000000003.
 memory.c:98: bad pmd 0000000000000003.
 swap_free: Bad swap file entry 74706f2074726f68
 swap_free: Bad swap file entry 73252063252d5b00
 swap_free: Bad swap file entry 735500706c656800
 swap_free: Bad swap file entry 4954504f5b200020
 swap_free: Bad swap file entry 2d20732560207972
 swap_free: Bad swap file entry 6620676e6148000a
 swap_free: Bad swap file entry 6568207369687420
 swap_free: Bad swap file entry 7473696c20706c
 swap_free: Bad swap file entry 72676f727020746e
 swap_free: Bad swap file entry 4f525245204d4152
 swap_free: Bad swap file entry 6576206f4e202952
 swap_free: Bad swap file entry 6e6b206e6f697372
 swap_free: Bad swap file entry 616d206f6f54203a
 swap_free: Bad swap file entry 6d7567726120796e
 swap_free: Bad swap file entry 5500656d616e2068
 swap_free: Bad swap file entry 73206e776f6e6b6e
 swap_free: Bad swap file entry 74736f4800726f72
 swap_free: Bad swap file entry 6f6c20656d616e20
 swap_free: Bad swap offset entry 6b6e55006572756c
 swap_free: Bad swap file entry 736f68206e776f6e
 swap_free: Bad swap file entry 766c6f7365520074
 swap_free: Bad swap file entry 65206f6e28203020
 swap_free: Bad swap file entry 65520029726f7272
 swap_free: Bad swap file entry 206c616e7265746e
 swap_free: Bad swap offset entry 434f4c00726f7272
 swap_free: Bad swap file entry 65722f6374652f00
 swap_free: Bad swap file entry 6863726165730066
 swap_free: Bad swap file entry 726573656d616e00
 swap_free: Bad swap file entry 74726f7300726576
 swap_free: Bad swap offset entry 74706f007473696c
 swap_free: Bad swap offset entry 6f646e00766e6500
 swap_free: Bad swap file entry 656d6974003a7374
 swap_free: Bad swap file entry 7461746f72003674
 swap_free: Bad swap file entry 726564726f657200
 swap_free: Bad swap file entry 6c61666f6f707300
 swap_free: Bad swap file entry 707865203a642520
 swap_free: Bad swap file entry 66202c6563697672
 swap_free: Bad swap file entry 6d20796669636570
 swap_free: Bad swap file entry 7672657320642520
 swap_free: Bad swap file entry 642520656e696c20
 swap_free: Bad swap file entry 64207473696c203a
 swap_free: Bad swap file entry 6c6f6620746f6e20
 swap_free: Bad swap file entry 7962206465776f6c
 swap_free: Bad swap file entry 64726f7779656b20
 swap_free: Bad swap file entry 6e696c203a732500
 swap_free: Bad swap file entry 65707320746f6e6e
 swap_free: Bad swap file entry 64206d6972742064
 swap_free: Bad swap file entry 74696d696c656420
 swap_free: Bad swap file entry 69616d6f64207962
 swap_free: Bad swap file entry 6e7261776f6e006e
 swap_free: Bad swap file entry 6e696c203a732500
 swap_free: Bad swap file entry 6020646574636570
 swap_free: Bad swap file entry 696c203a7325000a
 swap_free: Bad swap file entry 62203a642520656e
 swap_free: Bad swap file entry a2773256020646e
 swap_free: Bad swap file entry 6e696c203a732500
 swap_free: Bad swap file entry 7420676e69726f6e
 swap_free: Bad swap file entry 20676e696c696172
 swap_free: Bad swap file entry 4552000a27732560
 swap_free: Bad swap file entry 2f00464e4f435f54
 swap_free: Bad swap file entry 455200666e6f632e
 swap_free: Bad swap file entry 524544524f5f56
 swap_free: Bad swap file entry 535f564c4f534552
 swap_free: Bad swap file entry 4548435f464f4f50
 swap_free: Bad swap file entry 49544c554d5f56
 swap_free: Bad swap file entry 525f564c4f534552
 swap_free: Bad swap file entry 445f4d4952545f44
 swap_free: Bad swap file entry 414d4f445f4d4952
 swap_free: Bad swap offset entry 696c610073726568
 swap_free: Bad swap file entry 656c69665f73736e
 swap_free: Bad swap file entry 4e5b2073696e0066
 swap_free: Bad swap file entry 205d6e7275746572
 swap_free: Bad swap file entry 6c690073656c6966
 swap_free: Bad swap file entry 7473206c6167656c
 swap_free: Bad swap file entry 736e62696c007478
 swap_free: Bad swap file entry 5353454343555300
 swap_free: Bad swap file entry 4c494156414e5500
 swap_free: Bad swap file entry 4e554f46544f4e00
 swap_free: Bad swap file entry 4147415952540044
 swap_free: Bad swap file entry 4e49544e4f43004e
 swap_free: Bad swap file entry 6e0073656c696620
 swap_free: Bad swap file entry 2500786c23252d00
 swap_free: Bad swap file entry 2e64252e64252e64
 swap_free: Bad swap file entry 6874656700725f32
 swap_free: Bad swap file entry 6e6574736f68646e
 swap_free: Bad swap file entry 736f687465670074
 swap_free: Bad swap file entry 6700725f746e6574
 swap_free: Bad swap file entry 657300725f726464
 swap_free: Bad swap file entry 746e6574656e74
 swap_free: Bad swap file entry 74656e7465670074
 swap_free: Bad swap file entry 616e796274656e74
 swap_free: Bad swap file entry 6e79626f746f7270
 swap_free: Bad swap file entry 746e656f746f72
 swap_free: Bad swap file entry 79626f746f727074
 swap_free: Bad swap file entry 6700725f656d616e
 swap_free: Bad swap file entry 6700725f656d616e
 swap_free: Bad swap file entry 7300725f74726f70
 swap_free: Bad swap file entry 726573646e650074
 swap_free: Bad swap offset entry 74656700746e6576
 swap_free: Bad swap file entry 6370727465730072
 swap_free: Bad swap file entry 656700746e656370
 swap_free: Bad swap file entry 5f746e6563707274
 swap_free: Bad swap file entry 6370727465670072
 swap_free: Bad swap file entry 725f656d616e7962
 swap_free: Bad swap file entry 6263707274656700
 swap_free: Bad swap file entry 736f687465670072
 swap_free: Bad swap file entry 2500725f6e6f7474
 swap_free: Bad swap file entry 3a78253a78253a78
 swap_free: Bad swap file entry 686f746e74656700
 swap_free: Bad swap file entry 776f6e6b6e55203a
 swap_free: Bad swap file entry a74736f68206e
 swap_free: Bad swap file entry 6567203a646d6372
 swap_free: Bad swap file entry 666e697264646174
 swap_free: Bad swap file entry 69207374726f7020
 swap_free: Bad swap file entry 72000a657375206e
 swap_free: Bad swap file entry 7463656e6e6f6300
 swap_free: Bad swap file entry 72646461206f7420
 swap_free: Bad swap file entry 20676e6979725400
 swap_free: Bad swap file entry 7474657328206574
 swap_free: Bad swap file entry 203a297272656474
 swap_free: Bad swap file entry 28206c6c6f70203a
 swap_free: Bad swap file entry a6d25203a2972
 swap_free: Bad swap file entry 7270203a6c6c6f70
 swap_free: Bad swap file entry 697563726963206e
 swap_free: Bad swap file entry a70757465732074
 swap_free: Bad swap file entry 61203a646d637200
 swap_free: Bad swap file entry 6f746f7270203a74
 swap_free: Bad swap file entry a6d25203a732520
 swap_free: Bad swap file entry 6620746174736c00
 swap_free: Bad swap file entry 7273752f3d5f006e
 swap_dup: Bad swap file entry 120111e08
 VM: killing process bash(7925)
 swap_dup: Bad swap file entry 120111e08
 VM: killing process bash(7925)
 swap_free: Bad swap file entry 120741740
 swap_free: Bad swap file entry 12070d840
 swap_free: Bad swap file entry 1201119e0
 swap_free: Bad swap file entry 120053b34
 swap_free: Bad swap file entry 120053158
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 120740090
 swap_free: Bad swap file entry 120740740
 swap_free: Bad swap file entry 1200a27bc
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 120740740
 swap_free: Bad swap file entry 120740f80
 swap_free: Bad swap file entry 12070d840
 swap_free: Bad swap file entry 1201119e0
 swap_free: Bad swap file entry 120053b34
 swap_free: Bad swap file entry 120053158
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 12073f500
 swap_free: Bad swap file entry 12073ff80
 swap_free: Bad swap file entry 1200a27bc
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 12073ff80
 swap_free: Bad swap file entry 1207407c0
 swap_free: Bad swap file entry 12070d840
 swap_free: Bad swap file entry 1201119e0
 swap_free: Bad swap file entry 120053b34
 swap_free: Bad swap file entry 120053158
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 12073ed40
 swap_free: Bad swap file entry 12073f3f0
 swap_free: Bad swap file entry 1200a27bc
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 12073f3f0
 swap_free: Bad swap file entry 120740000
 swap_free: Bad swap file entry 12070d840
 swap_free: Bad swap file entry 1201119e0
 swap_free: Bad swap file entry 120053b34
 swap_free: Bad swap file entry 120053158
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 12073e580
 swap_free: Bad swap file entry 12073ec30
 swap_free: Bad swap file entry 1200a27bc
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 12073ec30
 swap_free: Bad swap file entry 12073f470
 swap_free: Bad swap file entry 12070d840
 swap_free: Bad swap file entry 1201119e0
 swap_free: Bad swap file entry 120053b34
 swap_free: Bad swap file entry 120053158
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 12073ddc0
 swap_free: Bad swap file entry 12073e470
 swap_free: Bad swap file entry 1200a27bc
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 12073e470
 swap_free: Bad swap file entry 12073ecb0
 swap_free: Bad swap file entry 12070d840
 swap_free: Bad swap file entry 1201119e0
 swap_free: Bad swap file entry 120053b34
 swap_free: Bad swap file entry 120053158
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 12073d600
 swap_free: Bad swap file entry 12073dcb0
 swap_free: Bad swap file entry 1200a27bc
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 12073dcb0
 swap_free: Bad swap file entry 12073e4f0
 swap_free: Bad swap file entry 12070d840
 swap_free: Bad swap file entry 1201119e0
 swap_free: Bad swap file entry 120053b34
 swap_free: Bad swap file entry 120053158
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 12073ce40
 swap_free: Bad swap file entry 12073d4f0
 swap_free: Bad swap file entry 1200a27bc
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 12073d4f0
 swap_free: Bad swap file entry 12073dd30
 swap_free: Bad swap file entry 12070d840
 swap_free: Bad swap file entry 1201119e0
 swap_free: Bad swap file entry 1207e5400
 swap_free: Bad swap file entry 11fffec80
 swap_free: Bad swap file entry 1201116e0
 swap_free: Bad swap file entry 120053b34
 swap_free: Bad swap file entry 1200a27bc
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 1202150f0
 swap_free: Bad swap file entry 120821090
 swap_free: Bad swap file entry 1201119e0
 swap_free: Bad swap file entry 120053b34
 swap_free: Bad swap file entry 120820bb0
 swap_free: Bad swap file entry 120053158
 swap_free: Bad swap file entry 120111e08
 swap_free: Bad swap file entry 120820af0
 swap_free: Bad swap file entry 120821120
 swap_free: Bad swap file entry 1200a27bc
 swap_free: Bad swap file entry 120111e08
 VM: killing process bash(7927)
 swap_free: Bad swap file entry 400000004
             last message repeated 9 times
 swap_free: Bad swap file entry 200000002
 swap_free: Bad swap file entry 400000004
 swap_free: Bad swap file entry 400000004
 swap_free: Bad swap file entry 200000002
 swap_free: Bad swap file entry 400000004
 swap_free: Bad swap file entry 400000004
 swap_free: Bad swap file entry 200000002
 swap_free: Bad swap file entry 400000004
 swap_free: Bad swap file entry 400000004
 swap_free: Bad swap file entry 200000002
 swap_free: Bad swap file entry ffffffff00000000

If you think that various "Bad swap file entry" look suspicious
that is because they are. :-)  The most obvious things decode
as follows (all null characters replaced in an output by "ZzZ"
string not to blow up some mail clients and "Z" character does
not occur otherwise in the original data):

hort opt
ZzZ[-%c %s
ZzZhelpZzZUs
 ZzZ [OPTI
ry `%s -

ZzZHang f
 this he
ZzZlp list
nt progr
RAM ERRO
R) No ve
rsion kn
: Too ma
ny argum
h nameZzZU
nknown s
rorZzZHost
 name lo
lureZzZUnk
nown hos
tZzZResolv
 0 (no e
rror)ZzZRe
nternal 
rrorZzZLOC
ZzZ/etc/re
fZzZsearch
ZzZnameser
verZzZsort
listZzZopt
ZzZenvZzZndo
ts:ZzZtime
t6ZzZrotat
ZzZreorder
ZzZspoofal
 %d: exp
rvice, f
pecify m
 %d serv
 line %d
: list d
 not fol
lowed by
 keyword
ZzZ%s: lin
nnot spe
d trim d
 delimit
by domai
nZzZnowarn
ZzZ%s: lin
pected `

ZzZ%s: li
ne %d: b
FV2w¢
ZzZ%s: lin
noring t
railing 
`%s'
ZzZRE
T_CONFZzZ/
.confZzZRE
ZzZV_ORDER
RESOLV_S
POOF_CHE
ZzZV_MULTI
RESOLV_R
D_TRIM_D
RIM_DOMA
hersZzZali
nss_file
fZzZnis [N
return] 
filesZzZil
legal st
xtZzZlibns
ZzZSUCCESS
ZzZUNAVAIL
ZzZNOTFOUN
DZzZTRYAGA
NZzZCONTIN
 filesZzZn
ZzZ-%#lxZzZ%
d.%d.%d.
2_rZzZgeth
ndhosten
tZzZgethos
tent_rZzZg
ddr_rZzZse
ZzZtnetent
tZzZgetnet
tnetbyna
protobyn
ZzZrotoent
tprotoby
name_rZzZg
name_rZzZg
port_rZzZs
tZzZendser
ventZzZget
rZzZsetrpc
pcentZzZge
trpcent_
rZzZgetrpc
byname_r
ZzZgetrpcb
rZzZgethos
tton_rZzZ%
x:%x:%x:
ZzZgetntoh
: Unknow
ZzZ‚ö6G§
rcmd: ge
taddrinf
 ports i
n use
ZzZr
ZzZconnect
 to addr
ZzZTrying 
te (sett
tderr): 
: poll (
ZzZ—¢RÒ¦
poll: pr
n circui
2WFW§
ZzZrcmd: a
t: proto
ZzZR2§RÒ¦
ZzZlstat f
nZzZ_=/usr

Hm.... 

   Michal


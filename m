Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSFLUT3>; Wed, 12 Jun 2002 16:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSFLUT2>; Wed, 12 Jun 2002 16:19:28 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:23546 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S313563AbSFLUT1>; Wed, 12 Jun 2002 16:19:27 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15623.44235.134423.210640@wombat.chubb.wattle.id.au>
Date: Thu, 13 Jun 2002 06:19:23 +1000
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH, TRIVIAL] Fix argument of BLKGETSIZE64 
In-Reply-To: <17385.1023889628@redhat.com>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Woodhouse <dwmw2@infradead.org> writes:

David> peter@chubb.wattle.id.au said:
>> This issue is that when I try to use the BLKGETSZ64 ioctl from a
>> user space program, the version of linux/fs.h shipped with
>> glibc-2.2.5 contains a u64 type.

>> You could argue that this is a glibc bug.

David> I do indeed. I further argue that it has no business being
David> discussed on the kernel mailing list, just because the kernel
David> happens to have a header with a similar name.

The header in question *defines* the kernel to userspace interface.
As such it is a kernel issue.  Any interface exposed to userspace must
use types that are common to userspace and the kernel.  u64 is kernel
only, therefore has no business being used in an ioctl declaration.

--
Peter C					    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.


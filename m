Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317537AbSHHJ35>; Thu, 8 Aug 2002 05:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317538AbSHHJ35>; Thu, 8 Aug 2002 05:29:57 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:6538 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S317537AbSHHJ3z>; Thu, 8 Aug 2002 05:29:55 -0400
Date: Thu, 8 Aug 2002 02:33:35 -0700
To: linux-kernel@vger.kernel.org
Cc: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: bad: schedule() with irqs disabled!
Message-ID: <20020808093335.GA11179@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Looks like some critical section got botched.

I don't do bug reports very often, so don't know exactly if this is
helpful. If somebody would like point me to something more exact, I'll
be happy to help out trying to trigger this again.

It happened under very high IDE activity, heavy VM and file system IO.

================================

bad: schedule() with irqs disabled!
d2895d5c c024a360 c1521580 d2895d84 c0110c58 00000001 c02fabf8 fffffffa 
       d2895d80 00000046 d2895d94 c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
       d2894000 00000003 c02b3060 00000002 00000246 c0203c30 d4625e94 d2789460 
Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
   [<c020e450>] [<c021bd7e>] [<c021be2d>] [<c021e00c>] [<c0220514>] [<c022d21c>] 
   [<c01f7297>] [<c01f7f47>] [<c010a561>] [<c01082c2>] [<c01f6469>] [<c01f763e>] 
   [<c01f7660>] [<c01f7bc4>] [<c0106de3>] 
bad: schedule() with irqs disabled!
d2895d5c c024a360 c1521580 d2895d84 c0110c58 00000001 c02fabf8 fffffffa 
       d2895d80 00000046 d2895d94 c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
       d2894000 00000003 c02b3060 00000002 00000246 c0203c30 d4625c94 d2789aa0 
Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
   [<c020e450>] [<c021bd7e>] [<c021be2d>] [<c021e00c>] [<c0220514>] [<c022d21c>] 
   [<c01f7297>] [<c01f7f47>] [<c01f6469>] [<c01f763e>] [<c01f7660>] [<c01f7bc4>] 
   [<c0106de3>] 
bad: schedule() with irqs disabled!
d2895d5c c024a360 c1521580 d2895d84 c0110c58 00000001 c02fabf8 fffffffa 
       d2895d80 00000046 d2895d94 c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
       d2894000 00000003 c02b3060 00000002 00000246 c0203c30 d4625c94 d27895a0 
Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
   [<c020e450>] [<c0106f28>] [<c021bd7e>] [<c021be2d>] [<c021e00c>] [<c0220514>] 
   [<c022d21c>] [<c01f7297>] [<c01f7f47>] [<c010a561>] [<c01f6469>] [<c01f763e>] 
   [<c01f7660>] [<c01f7bc4>] [<c0106de3>] 
bad: schedule() with irqs disabled!
c3701d64 c024a360 c1521580 c3701d8c c0110c58 00000001 c02fabf0 fffffffc 
       c3701d88 00000046 c3701d9c c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
       c3700000 00000003 d7cf6800 00000002 00000246 c0203c30 d4625e9c c8f096c0 
Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
   [<c020e450>] [<c0106f28>] [<c0210018>] [<c021be09>] [<c021be2d>] [<c021e223>] 
   [<c0213250>] [<c0213dfe>] [<c01dbec6>] [<c022d601>] [<c01f6649>] [<c01f674b>] 
   [<c01358cb>] [<c0135aa6>] [<c0106de3>] 
bad: schedule() with irqs disabled!
cb8e7d64 c024a360 c1521580 cb8e7d8c c0110c58 00000001 c02fabf0 fffffffc 
       cb8e7d88 00000046 cb8e7d9c c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
       cb8e6000 00000003 d7cf6800 00000002 00000246 c0203c30 d4625e9c d707bda0 
Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
   [<c020e450>] [<c021bd7e>] [<c021be2d>] [<c021e223>] [<c0213250>] [<c0213dfe>] 
   [<c022d601>] [<c01f6649>] [<c01f674b>] [<c014475f>] [<c01358cb>] [<c0135aa6>] 
   [<c0106de3>] 
bad: schedule() with irqs disabled!
cf9d5d5c c024a360 c1521580 cf9d5d84 c0110c58 00000001 c02fabf8 fffffffa 
       cf9d5d80 00000046 cf9d5d94 c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
       cf9d4000 00000003 c02b3060 00000002 00000246 c0203c30 d4625e94 c6442d40 
Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
   [<c020e450>] [<c021bd7e>] [<c021be2d>] [<c021e00c>] [<c0220514>] [<c022d21c>] 
   [<c01f7297>] [<c01f7f47>] [<c01f6469>] [<c01f763e>] [<c01f7660>] [<c01f7bc4>] 
   [<c0106de3>] 

================================


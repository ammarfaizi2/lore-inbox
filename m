Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261848AbSJ2Mvt>; Tue, 29 Oct 2002 07:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261849AbSJ2Mvt>; Tue, 29 Oct 2002 07:51:49 -0500
Received: from tomts23.bellnexxia.net ([209.226.175.185]:42646 "EHLO
	tomts23-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261848AbSJ2Mvs>; Tue, 29 Oct 2002 07:51:48 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [long]2.5.44-mm3 UP went into unexpected trashing
To: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Tue, 29 Oct 2002 07:53:15 -0500
References: <20021024211633.A21583@in.ibm.com> <20021025002228.A14712C2DD@lists.samba.org> <20021025175705.A14451@in.ibm.com> <3DB98823.67FDBEF3@digeo.com> <20021025235222.A25786@in.ibm.com> <20021026212434.A24376@in.ibm.com>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20021029125315.DA0F47819@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

> Well, my earlier find_first_bit() implementation was completely bogus.
> My sanity has now returned and I coded this patch below that fixes
> find_find_bit() to return "size" if all bits are zero. I have tested it
> extensively in userspace and it boots 2.5.44-mm5 which crashed with the
> earlier version of the bitops_fix patch. I have coded the assembly routine
> as optimal as I could think of and without introducing any new
> branches or memory loads.
> 
> Along with this patch, I applied the larger_cpu_mask patch to -mm5
> and sanity tested both UP and SMP kernels for dcache leaks in a 4CPU P3
> box. An ls -lR and subsequent unmounting of that filesystems showed that
> the dentries were correctly getting returned the dcache slab and
> that indicates that the larger_cpu_mask patch no longer breaks RCU.
> I will do some more testing with this combination later with
> rcu_stats applied on this tree (just to be sure), but so far it looks
> good.

-mm5 with this patch is working fine here.

Thanks
Ed Tomlinson



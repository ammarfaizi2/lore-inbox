Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbTCPGqB>; Sun, 16 Mar 2003 01:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262462AbTCPGqB>; Sun, 16 Mar 2003 01:46:01 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:37253 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S262449AbTCPGqA>; Sun, 16 Mar 2003 01:46:00 -0500
Date: Sat, 15 Mar 2003 22:56:50 -0800
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.5.64-mjb4 (scalability / NUMA patchset)
Message-ID: <20030316065650.GA8164@gnuppy.monkey.org>
References: <169550000.1046895443@[10.10.2.4]> <475260000.1047172886@[10.10.2.4]> <85960000.1047532556@[10.10.2.4]> <10770000.1047787269@[10.10.2.4]> <20030316044524.GA6757@gnuppy.monkey.org> <12150000.1047793549@[10.10.2.4]> <20030316063151.GA7114@gnuppy.monkey.org> <19840000.1047797300@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19840000.1047797300@[10.10.2.4]>
User-Agent: Mutt/1.5.3i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 10:48:21PM -0800, Martin J. Bligh wrote:
> # CONFIG_SMP is not set
> CONFIG_X86_SUMMIT=y
> 
> That'll probably confuse the snot out of it ;-)
> I'll try to add a dependency to the config file, but for now, can
> you turn SMP on, and check that fixes it?

Yeah, that fixes it. I don't even know how that options was turned on
in the first place, but:

mm/slab.c: In function `kmem_cache_size':
mm/slab.c:1968: `SLAB_STORE_USER' undeclared (first use in this
function)
mm/slab.c:1968: (Each undeclared identifier is reported only once
mm/slab.c:1968: for each function it appears in.)
make[2]: *** [mm/slab.o] Error 1
make[1]: *** [mm] Error 2
make: *** [vmlinux] Error 2

bill


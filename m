Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292852AbSCGLJc>; Thu, 7 Mar 2002 06:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293487AbSCGLJX>; Thu, 7 Mar 2002 06:09:23 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:38827 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S292852AbSCGLJG>;
	Thu, 7 Mar 2002 06:09:06 -0500
Date: Thu, 7 Mar 2002 06:09:04 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Voluspa <voluspa@bigfoot.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6-pre3 Kernel panic: VFS: Unable to mount root fs on 03:02
In-Reply-To: <20020307114845.530abcfa.voluspa@bigfoot.com>
Message-ID: <Pine.GSO.4.21.0203070601100.26116-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Mar 2002, Voluspa wrote:

> only show enforced differences, I could boot into 2.5.6-pre2 tonight (about 6 hours from now) and dump whatever info you need - if it is deemed necessary. Otherwise I'll just enjoy the -ac series until a -preX turns up that is bootable.

Very interesting...

It boots fine from ext2 on IDE here.  Do you have any oddities in
.config? (e.g. something silly enabled - CONFIG_PREEMPT, etc.)

Bug looks very odd.  -EFAULT from mount(2) done by a thread that
runs with equivalent of set_fs(KERNEL_DS)...

.config might be really useful.  Or not - it may boil down to checking
which path it actually takes and where does -EFAULT come from.


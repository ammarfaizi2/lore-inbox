Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313170AbSC1Osm>; Thu, 28 Mar 2002 09:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313171AbSC1Osc>; Thu, 28 Mar 2002 09:48:32 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54694 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313170AbSC1OsS>;
	Thu, 28 Mar 2002 09:48:18 -0500
Date: Thu, 28 Mar 2002 09:48:14 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Nikita Danilov <Nikita@Namesys.COM>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <15523.10878.394037.864862@laputa.namesys.com>
Message-ID: <Pine.GSO.4.21.0203280946230.24447-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Mar 2002, Nikita Danilov wrote:

> Explicit initialization always leaves room for some "pad" field inserted
> by compiler for alignment to be left with garbage. This is more than
> just annoyance when structure is something that will be written to the
> disk. Reiserfs had such problems.

If your structure will be written on disk you'd better have full control
over alignment - otherwise you are risking incompatibilities between
platforms and compiler versions.


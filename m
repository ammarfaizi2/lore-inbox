Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313386AbSC2IHI>; Fri, 29 Mar 2002 03:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313387AbSC2IG6>; Fri, 29 Mar 2002 03:06:58 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:44020 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S313386AbSC2IGw>;
	Fri, 29 Mar 2002 03:06:52 -0500
Date: Fri, 29 Mar 2002 09:06:37 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
Message-ID: <20020329080637.GA5814@win.tue.nl>
In-Reply-To: <3CA356AE.2E61F712@zip.com.au> <Pine.GSO.4.21.0203281838310.25746-100000@weyl.math.psu.edu> <3CA3B48F.25F9042D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2002 at 04:25:51PM -0800, Andrew Morton wrote:

> BTW, ext3 keeps a kdev_t on-disk for external journals.

A kdev_t is conceptually a struct block_device *.
Points to allocated kernel space.
Writing such an animal to disk is completely pointless.
You want to apply some conversion function first,
even when that conversion function may be the identity
in the setup where a kdev_t has integral type. And make
sure that the resulting integer can hold at least 64 bits.

Andries

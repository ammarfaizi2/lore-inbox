Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269832AbRHDIPj>; Sat, 4 Aug 2001 04:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269831AbRHDIPa>; Sat, 4 Aug 2001 04:15:30 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:51465 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269832AbRHDIPW>; Sat, 4 Aug 2001 04:15:22 -0400
Date: Sat, 4 Aug 2001 05:53:07 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010804055307.H16516@emma1.emma.line.org>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010804111645.C17925@weta.f00f.org> <Pine.GSO.4.21.0108031916580.5264-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0108031916580.5264-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2001, Alexander Viro wrote:

> It has nothing to bindings/mount/etc. fsync /a/b/c. While c is written
> out, mv a/b/c /a/d/c. While d is written out, mv a/d/c a/b/c && mv a/d e/d
> Through all these renames /a remained the grandparent of c. You won't sync it -
> you sync c, then d, then e, then root.

Which looks like the right thing, what used to be a/b/c is now e/d/c --
and you synced c, d, and e.

-- 
Matthias Andree

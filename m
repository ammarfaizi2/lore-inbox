Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285373AbRLGCBt>; Thu, 6 Dec 2001 21:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285372AbRLGCBk>; Thu, 6 Dec 2001 21:01:40 -0500
Received: from dsl-213-023-043-086.arcor-ip.net ([213.23.43.86]:11271 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285370AbRLGCBg>;
	Thu, 6 Dec 2001 21:01:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>
Subject: Re: [PATCH] Revised extended attributes interface
Date: Fri, 7 Dec 2001 03:03:43 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <E16C0PD-0000ot-00@starship.berlin> <20011207101517.B46546@wobbly.melbourne.sgi.com>
In-Reply-To: <20011207101517.B46546@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16CAMb-0000s1-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 7, 2001 12:15 am, Nathan Scott wrote:
> > > [extended attributes on symlinks]
> > 
> > OK, well it looks like you're going a little overboard here in dividing out 
> > the functionality.  What you're talking about is 'follow symlink or not', 
> > right?  That really does sound to me as though it's naturally expressed with 
> > a flag bit.  I really don't see a compelling reason to go beyond 8 syscalls:
> > 
> >   get, fget, set, fset, del, fdel, list, flist
> 
> I'm not too fussed - the second draft patch I sent out did exactly
> as you describe, in an attempt to cut down on syscalls.  This again
> meant adding a "flags" field to each operation.  We also have stat/
> lstat/fstat and chown/lchown/fchown - I was trying to be consistent
> with those, and I still think that is the right thing to do.

It may well be, however, the one call that has flags, set, is looking a 
little irregular sitting there on its own.

We're inventing an API here for which we don't have a lot of guidance from 
existing unices, correct?  It wouldn't hurt to really kick it around.  After 
all, what we settle on in Linux is likely to become the standard.

Presumably there's some existing practice at SGI, do you have a pointer to 
man pages?

--
Daniel

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265005AbUEYSLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265005AbUEYSLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbUEYSJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:09:06 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:13391 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265005AbUEYSIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:08:37 -0400
Date: Tue, 25 May 2004 13:08:34 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040525180834.GC26081@hexapodia.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <20040525164232.GD28169@fieldses.org> <Pine.LNX.4.58.0405250948530.9951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405250948530.9951@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 10:05:26AM -0700, Linus Torvalds wrote:
> On Tue, 25 May 2004, J. Bruce Fields wrote:
> > The patch-submission process can be more complicated than a simple path
> > up a heirarchy of maintainers--patches get bounced around a lot
> > sometimes.
> 
> Yes. And documenting the complex relationships obviously can't be sanely 
> done. The best we can do is a "it went through these people".
> 
> Perfect is the enemy of good. If we tried to be perfect, we'd never get 
> anything done.

Agreed, but...

> > 	* I write a patch.  Developers X and Y suggest significant
> > 	  changes.  I make the changes before I submit them to maintainer
> > 	  Z.  Suppose the changes are significant enough that I no longer
> > 	  feel comfortable representing myself as the sole author of the
> > 	  patch.  Should I also be asking developer X  and Y to add their
> > 	  own "Signed-off-by" lines?
> 
> That, my friend, is a matter of your own taste and conscience. My answer
> is that if you wrote it all, you clearly don't _need_ to. At the same
> time, I think that it's certainly in good taste to at least _ask_ them. 
> Wouldn't you agree?

This is one example of a general class of problem; another example is
"Andrew integrated 15 patches into -mm5".  When you have an aggregate
work representing a conglomeration of works from several different
developers, it becomes unwieldy to apply "tags" as you're suggesting.

What if I send a patch to l-k, and Bruce forwards it on to Andrew;
meanwhile, Joe sends another patch to l-k and Peter forwards it on to
Andrew.  Andrew integrates both patches, as well as several unrelated
bits he creates himself, into -mm77, which he sends to Linus and gets
integrated.

My signature can only apply to the patch I submitted, but that
distinction has been demolished long before the patch got anywhere near
a database that might be able to record it.  If we get lucky, the patch
in the l-k archives might be recognizable in -mm77.patch and the
resultant cset.

This problem is somewhat mitigated if all "aggregators" use BK, since
BKs csets preserve the boundaries of attestation that are interesting
here.  But it's not reasonable or sane to try to filter this problem
through BK.

-andy

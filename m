Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131184AbRCZPUB>; Mon, 26 Mar 2001 10:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131610AbRCZPTv>; Mon, 26 Mar 2001 10:19:51 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:62702
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S131184AbRCZPTg>; Mon, 26 Mar 2001 10:19:36 -0500
Date: Mon, 26 Mar 2001 08:11:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net, cort@fsmlabs.com
Subject: Re: CML1 cleanup patch, take 2
Message-ID: <20010326081157.H16672@opus.bloom.county>
In-Reply-To: <200103260955.f2Q9tfo14568@snark.thyrsus.com> <3ABF574D.65CBD22@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3ABF574D.65CBD22@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Mar 26, 2001 at 09:50:53AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2001 at 09:50:53AM -0500, Jeff Garzik wrote:
> esr wrote:

> > (3) Fix up 10 configuration symbols of the form CONFIG_[0-9]*; specific 
> >     changes are those suggested 8 Jan 2001 by PPC port maintainer Tom Rini.
> >     This change has been APPROVED by an authorized maintainer.
> 
> Maybe I am not caught up with the times...  I thought Cort Dougan was
> the overall PowerPC maintainer.  That's what MAINTAINERS says.

Yes.  Cort is indeed the overall, head PPC guy.  Paul M does a lot too. :)
However, all of these name changes have gone past not only those two, but
a large portion of the PPC kernel community as well.  Everyone likes 'em,
or at least agrees they aren't bad changes.

> Anyway, this is up to the PowerPC guys, but I disagree with this change
> nonetheless.  MandrakeSoft has a PPC port, and as I mentioned earlier,
> some utilities in the build process etc. look at CONFIG_xxx.

Yes, they do.  Which is partily why I was actually going to wait until
2.5 for many of these to come in.

> PPC guys:  this is a gratuitous renaming change that is not required. 
> If you have been following the "CML1 cleanup patch" thread, you see that
> Eric is blindly dictating policy when he says that CONFIG_[0-9] needs to
> be cleaned up.

The counter point to this is what does "CONFIG_6xx" or 8xx mean?  It's as bad
as CONFIG_Mxxx imho :)

> > This leaves ten symbols in a form that breaks CML2.  I'll go after
> > the other individual maintainers about those.  Sigh....
> > 
> > No actual object code will be changed by this patch; it merely does
> > one-to-one substitutions on some configuration symbols.
> > 
> > Let me repeat that.  This patch changes *no* object code.  None.
> > However, merging it before the 2.5 fork will save me (and probably
> > Alan) some nasty large headaches later on...
> 
> Object code changes are not the only thing we are concerned with in a
> stable series.
> Let me repeat myself for the cheap seats:   Changing the 2.4.x
> CONFIG_xxx namespace changes the source code API provided to other
> kernel code.  It affects software not in the Linux kernel tree.

Yes.  Symbol changes should be a 2.5 thing anyways.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

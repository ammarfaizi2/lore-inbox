Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279537AbRJXLip>; Wed, 24 Oct 2001 07:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279536AbRJXLig>; Wed, 24 Oct 2001 07:38:36 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:15237 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S279535AbRJXLiU>; Wed, 24 Oct 2001 07:38:20 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Keith Owens <kaos@ocs.com.au>, Linux Kernel <linux-kernel@vger.kernel.org>
Date: Tue, 23 Oct 2001 09:14:03 -0700 (PDT)
Subject: Re: VM
In-Reply-To: <20011023161446Z16332-4006+621@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.40.0110230911110.12990-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel, I think the suggestion isn't to break out the differences in a
bunch of config options, but rather to do something like duplicating all
files that are VM related into two files, foo.c becomes foo.aa.c and
foo.rik.c at that point your config file either uses all the .rik files or
all the .aa files and both would be in the same tree, but not interact
with each other.

yes, there would be a lot of duplication between them, but something like
this would let people compare the two directly without also having all the
other linus vs ac changes potentially affecting their tests.

David Lang

 On Tue, 23 Oct 2001, Daniel Phillips wrote:

> Date: Tue, 23 Oct 2001 18:15:36 +0200
> From: Daniel Phillips <phillips@bonn-fries.net>
> To: Keith Owens <kaos@ocs.com.au>
> Cc: Linux Kernel <linux-kernel@vger.kernel.org>
> Subject: Re: VM
>
> On October 23, 2001 07:38 am, Keith Owens wrote:
> > Daniel Phillips <phillips@bonn-fries.net> wrote:
> > >If you want to argue for something, argue for giving config the ability to
> > >apply patches, that would be lots of fun.
> >
> > It is kbuild rather than config that needs the ability.  I could do it
> > trivially in kbuild 2.5, I almost added the facility at one time.  Alas
> > it breaks when you get overlapping patches, select one config or
> > another and it works, select both (assuming they are not exclusive) and
> > it breaks.
>
> Yes, if someone was determined to set this up they'd have to laboriously
> break up overlapping patches into common vs independent pieces, and determine
> that other patches are simply mutually incompatible, thus requiring suitable
> config rule restrictions.  Wow, way too much work for the tree owner, and
> things will re-break frequently when the patch owner makes updates.
>
> Maybe this technique is something that would interest the FOLK guys, where
> the goal is to produce a single tree with as many options as possible, and
> where they're willing to put in extra maintainance work.  Besides the two VM
> designs, there's the XFS patch, which we don't have a good way of integrating
> into a single tree just yet.
>
> Please treat the above as idle speculation.  It's evident that including
> patches in kbuild is an express route to madness.  For one thing, I'd no
> longer be able to index the complete source tree for browsing.
>
> > I don't have a solution and the symptoms of overlapping patches are
> > worse than the problem that patches are trying to fix, so I left patch
> > support out of kbuild 2.5.  You can use shadow trees where you overlay
> > a new implementation of a subsystem over the base kernel, then switch
> > between versions by specifying which set of trees you are using.
>
> --
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

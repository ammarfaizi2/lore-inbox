Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278693AbRJXSMF>; Wed, 24 Oct 2001 14:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278697AbRJXSL4>; Wed, 24 Oct 2001 14:11:56 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:31935 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S278695AbRJXSLm>; Wed, 24 Oct 2001 14:11:42 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Keith Owens <kaos@ocs.com.au>, Linux Kernel <linux-kernel@vger.kernel.org>
Date: Wed, 24 Oct 2001 09:50:39 -0700 (PDT)
Subject: Re: VM
In-Reply-To: <20011024175507Z16346-698+175@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.40.0110240936160.14041-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

those were the files that his patches were changing, since then we also
have had linus, rik and alan making changes in the various trees.

are you willing to bet that the only changes in those files are related to
the VM system changes and that there are no other -ac related changes in
those files due to the other ac changes? without someone who really
understands the rik VM I wouldn't trust breaking them out of the -ac
tree and the same thing goes for the aa VM and the linus tree (to add that
into the ac tree)

as I see it this requires a few steps.

1. linus and alan agree to implement such a thing (which includes
alanbeing willing to track the appropriate differences)

2. rik and/or aa and/or alan seperate out the rik VM from the ac tree and
submit it to linus.

3. rik and/or aa and/or alan seperate out the aa VM from the linus tree
and submit it to alan.

it's a lot of work to get it setup this way, and it does duplicate a bunch
of files that could get out of sync if not carefully managed but it's
about the only way that I can see people able to test just the different
VM systems.

now if one of the above four states that there are files (or directories)
that are only the VM system and it is as simple as swapping out everything
in those files between the linus and ac trees then steps 2&3 get much
simpler.

David Lang

On Wed, 24 Oct 2001, Daniel Phillips wrote:

> Date: Wed, 24 Oct 2001 19:56:00 +0200
> From: Daniel Phillips <phillips@bonn-fries.net>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: Keith Owens <kaos@ocs.com.au>,
>      Linux Kernel <linux-kernel@vger.kernel.org>
> Subject: Re: VM
>
> On October 24, 2001 06:24 pm, David Lang wrote:
> > the problem is that there isn't a patchset available from either aa or rik
> > that converts one to the other, the only patchset readily available
> > converts linus+aa to ac+rik this changes a lot more then just the VM stuff
> > so without going to a lot of effort it's not possible to directly compare
> > the two VM designs while keeping the rest of the kernel the same.
>
> A non-kernel-hacker can easily make the patch.  Andrea posted a list of all
> the files affected back at the beginning of his 'vm rewrite' thread.
>
> > > > Daniel, I think the suggestion isn't to break out the differences in a
> > > > bunch of config options, but rather to do something like duplicating all
> > > > files that are VM related into two files, foo.c becomes foo.aa.c and
> > > > foo.rik.c at that point your config file either uses all the .rik files
> > > > or all the .aa files and both would be in the same tree, but not
> > > > interact with each other.
> > > >
> > > > yes, there would be a lot of duplication between them, but something
> > > > like this would let people compare the two directly without also having
> > > > all the other linus vs ac changes potentially affecting their tests.
> > >
> > > Patch and lilo are your friends.
>
> --
> Daniel
>

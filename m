Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129350AbRB1XGF>; Wed, 28 Feb 2001 18:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129344AbRB1XF5>; Wed, 28 Feb 2001 18:05:57 -0500
Received: from adsl-64-167-146-94.dsl.snfc21.pacbell.net ([64.167.146.94]:43784
	"EHLO eleanor.wdhq.scyld.com") by vger.kernel.org with ESMTP
	id <S129350AbRB1XFq>; Wed, 28 Feb 2001 18:05:46 -0500
Date: Wed, 28 Feb 2001 18:06:37 -0500 (EST)
From: Daniel Ridge <newt@scyld.com>
To: beowulf@beowulf.org
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Will Mosix go into the standard kernel?
In-Reply-To: <Pine.LNX.4.33.0102271829030.5502-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0102281732210.22184-100000@eleanor.wdhq.scyld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fellow Beowulfers,

I have yet to hear a compelling argument about why any of them should 
go into the standard kernel -- let alone a particular one or a duck of a
compromise.

The Scyld system is based on BProc -- which requires only a 1K patch to
the kernel. This patch adds 339 net lines to the kernel, and changes 38
existing lines.

The Scyld 2-kernel-monte kernel inplace reboot facility is a 600-line
module which doesn't require any patches whatsoever.

Compare this total volume to the thousands of lines of patches that
RedHat or VA add to their kernel RPMS before shipping. I just don't see 
the value in fighting about what clustering should 'mean' or picking
winners when it's just not a real problem.

Scyld is shipping a for-real commercial product based on BProc and
2-kernel-Monte and our better-than-stock implementation of LFS and and
we're not losing any sleep over this issue.

I think we should instead focus our collective will on removing things
from the kernel. For years, projects like ALSA, pcmcia-cs, and VMware
have done an outstanding job sans 'inclusion' and we should more
frequently have the courage to do the same. RedHat and other linux vendors
have demonstrated ably that they know how to build and package systems
that draw together these components in an essentially reasonable way. 

Regards,
	Dan Ridge
	Scyld Computing Corporation

On Tue, 27 Feb 2001, Rik van Riel wrote:

> On Tue, 27 Feb 2001, David L. Nicol wrote:
> 
> > I've thought that it would be good to break up the different
> > clustering frills -- node identification, process migration,
> > process hosting, distributed memory, yadda yadda blah, into
> > separate bite-sized portions.
> 
> It would also be good to share parts of the infrastructure
> between the different clustering architectures ...
> 
> > Is there a good list to discuss this on?  Is this the list?
> > Which pieces of clustering-scheme patches would be good to have?
> 
> I know each of the cluster projects have mailing lists, but
> I've never heard of a list where the different projects come
> together to eg. find out which parts of the infrastructure
> they could share, or ...
> 
> Since I agree with you that we need such a place, I've just
> created a mailing list:
> 
> 	linux-cluster@nl.linux.org
> 
> To subscribe to the list, send an email with the text
> "subscribe linux-cluster" to:
> 
> 	majordomo@nl.linux.org
> 
> 
> I hope that we'll be able to split out some infrastructure
> stuff from the different cluster projects and we'll be able
> to put cluster support into the kernel in such a way that
> we won't have to make the choice which of the N+1 cluster
> projects should make it into the kernel...
> 
> regards,
> 
> Rik
> --
> Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml
> 
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com/
> 
> 
> 
> 
> _______________________________________________
> Beowulf mailing list, Beowulf@beowulf.org
> To change your subscription (digest mode or unsubscribe) visit http://www.beowulf.org/mailman/listinfo/beowulf
> 


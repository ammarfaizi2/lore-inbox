Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271419AbRHOUf1>; Wed, 15 Aug 2001 16:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271421AbRHOUfS>; Wed, 15 Aug 2001 16:35:18 -0400
Received: from ns.caldera.de ([212.34.180.1]:5277 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S271419AbRHOUfE>;
	Wed, 15 Aug 2001 16:35:04 -0400
Date: Wed, 15 Aug 2001 22:34:53 +0200
Message-Id: <200108152034.f7FKYrM26636@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: bbeattie@sequent.com (Brian Beattie)
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: md/multipath: Multipath, Multiport support and prototype patch for round robin routing
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010723133242.B970@dyn9-47-16-69.des.beaverton.ibm.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010723133242.B970@dyn9-47-16-69.des.beaverton.ibm.com> you wrote:
> I've been looking at the multipath support Ingo Molnar added to md as
> included in RedHat 7.1.  I'm looking at various improvements that might
> be possible.  To try to get some discussion going, I posting some ideas
> of things I thgink could be improved, and some patches for a prototype
> to add round robin routing.
>
> Some of the things that I think could be done that would improve md, in
> no particular order: different routing options ( prefered route, round
> robin, static weighted, dynamic weighted ), improved error handeling,
> automatic route recovery, automatic device discovery, automatic device
> identification.  Some of these may not be feasible and others may have
> some other features.
>
> All comments welcome

First it would be so much easier to compare this to the current code
if one would not have to download megabytes of redhat kernel-rpms
(ok we have it on kn.org now),  extract the four or five patches and
adopt them to a slightly different tree, but could find it in the stock
or at least -ac tree.  Ingo, is there any specici reason why you didn't
send it to Alan yet?  I stoped my development of the same feature because
I saw yours was moe coplete and now it doesn't get merged..

The second comment actually goes to you, Brian:  could you please try to
create unified diffs (diff -u)?  It's sooo much easier to read..

> + 
> + static struct multipath_dev_table multipath_dev_template = {
> +         "",
> + 	{
> + 		{MULTIPATH_ROUTING, "routing", NULL, sizeof(int), 0644,
> + 			NULL, &proc_dointvec},

Shouldn't this be a property of the md device, instead of a sysctl?
I planned to write that information in the md superblock for my design.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

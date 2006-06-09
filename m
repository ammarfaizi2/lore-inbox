Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWFISZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWFISZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWFISZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:25:33 -0400
Received: from relay03.pair.com ([209.68.5.17]:8709 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1030267AbWFISZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:25:32 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 9 Jun 2006 13:25:30 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Gerrit Huizenga <gh@us.ibm.com>
cc: Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <E1FolFA-0007RU-Ab@w-gerrit.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0606091316540.5541@turbotaz.ourhouse>
References: <E1FolFA-0007RU-Ab@w-gerrit.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, Gerrit Huizenga wrote:

> We are seeing storage needs increasing at a frightening rate.  Health
> Care folks want to store your MRI's, x-ray's, ultraounds, etc. in high
> res digital format across your entire life in near-line format.  Terabytes
> over time per person.  Europe is already doing this pretty extensively,
> the US is following suit.  Digital media creation has huge storage needs.
> Most everything is moving to podcasts, webcasts, streaming audio & video.
> Storage is huge, and ext3 is at the current breaking point.
>
> I'd argue that whatever we call it, we need a standard, stable, supported
> solution *soon* for large files, large filesystems, large storage systems
> in Linux.
>
> I'd think the quickest path is to relieve the pressure now in ext3.

Makes sense...

>> So we have empirical evidence that splitting filesystem work up does
>> actually help.
>
> Agreed.  But... Maybe that should be the set of changes *following*
> extents.  Then the file format can change, several of the pending ideas
> can be worked in, and some of the backwards compatibility can be cleaned
> out if it is in the way.  Then the extents work can get us something
> usable in all the interim distro releases for the real users who are
> screaming now about the filesystem size limits.

Let's call ext3 "Linux 2.4" for a second and ext(x) w/extents and 48-bit 
"Linux 2.5". We can now do all the crazy, wild work we want on 2.5, but 
people need it tomorrow. And they can have it, but we're stamping 
"Dangerous! Dangerous! Unstable! API changes every 5 minutes, your data 
will be obsoleted each release!" all over it. This goes on for years until 
we finally reach a point where we can roll out "Linux 2.6".

The trouble is that "Linux 2.6" is something many of us are going to be 
wanting _now_.

Now, taking the quotes back off "Linux 2.6" and speaking about the kernel 
as a whole again - isn't lots of incremental stable releases with new 
functionality something that cutting off the development arm made 
possible?

I acknowledge the concerns about filesystem stability and Linus's points 
about improperly shared code. From a practical standpoint, I see the need 
of bigger filesystems coming.

And the biggest practical problem I see is one of perception. Making 
'ext4' means labelling it unstable for a while. And once something like a 
_filesystem_ is called unstable, it's going to be a long time before 
people trust it with terabytes of their incredibly valuable data (even if 
we promise them that it's mostly an ext3 fork).

Whereas if you play with some experimental 48-bit extension on ext3, well, 
ext3 already has a good reputation and is in use everywhere, so maybe this 
isn't a bad "last feature" to add before forking off into ext4-land?

> gerrit

Cheers,
Chase

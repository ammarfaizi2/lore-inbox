Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278185AbRJRW4c>; Thu, 18 Oct 2001 18:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278189AbRJRW4W>; Thu, 18 Oct 2001 18:56:22 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:4601
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278185AbRJRW4I>; Thu, 18 Oct 2001 18:56:08 -0400
Date: Thu, 18 Oct 2001 15:56:36 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: James Sutherland <jas88@cam.ac.uk>, Ben Greear <greearb@candelatech.com>,
        Neil Brown <neilb@cse.unsw.edu.au>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
Message-ID: <20011018155636.B2467@mikef-linux.matchmail.com>
Mail-Followup-To: James Sutherland <jas88@cam.ac.uk>,
	Ben Greear <greearb@candelatech.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BCE6E6E.3DD3C2D6@candelatech.com> <Pine.SOL.4.33.0110180937420.13081-100000@yellow.csi.cam.ac.uk> <20011018132035.A444@mikef-linux.matchmail.com> <20011018151718.O1144@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011018151718.O1144@turbolinux.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 03:17:18PM -0600, Andreas Dilger wrote:
> On Oct 18, 2001  13:20 -0700, Mike Fedyk wrote:
> > Actually, it looks like Niel is creating a two level Quota system.  In ther
> > normal quota system, if you own a file anywhere, it is attributed to you.
> > But, in the tree quota system, it is attributed to the owner of the tree...
> 
> Hmm, we already have group quotas, and (excluding ACLs) you would need to
> have group write permission into the tree to be able to write there.  How
> does the tree quota help us in the end?  Either users are "nice" and you
> don't need quotas, or users are "not nice" and you don't want them to be
> able to dump their files into an area that doesn't keep them "in check" as
> quotas are designed to do.
> 

Hmm, I think I just thought of a use for the tree quota concept.

Lets say that you have about 50GB of space, but you only want to allow 20GB
for a certain tree (possibly mp3s), and you want to keep user ownerships of
the files they contribute.

Now try to use the group quota idea.

User makes mp3
user can chgrp to any user that they are a member of...
copy to /mp3s.

Now the group (and quota) that was setup for mp3s has been circumvented.

With the tree quota, an entire tree could be assigned to a certain group,
and then use the group quota tools...

The only other way I can see to fix this would be a cron job to walk the
tree and set the group to whatever has been setup, but that looks like a
hack to me.

Is there another way to fix this besides putting all mp3s on a separate
partition?

Mike

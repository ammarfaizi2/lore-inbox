Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277609AbRJRImb>; Thu, 18 Oct 2001 04:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277618AbRJRImW>; Thu, 18 Oct 2001 04:42:22 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:55690 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S277609AbRJRImI>; Thu, 18 Oct 2001 04:42:08 -0400
Date: Thu, 18 Oct 2001 09:38:47 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@yellow.csi.cam.ac.uk>
To: Ben Greear <greearb@candelatech.com>
cc: Neil Brown <neilb@cse.unsw.edu.au>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: <3BCE6E6E.3DD3C2D6@candelatech.com>
Message-ID: <Pine.SOL.4.33.0110180937420.13081-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2001, Ben Greear wrote:

> Neil Brown wrote:
> >
> > Hi,
> >  In my ongoing effort to provide centralised file storage that I can
> >  be proud of, I have put together some code to implement tree quotas.
> >
> >  The idea of a tree quota is that the block and inode usage of a file
> >  is charged to the (owner of the root of the) tree rather than the
> >  owner (or group owner) of the file.
> >  This will (I hope) make life easier for me.  There are several
> >  reasons that I have documented (see URL below) but a good one is that
> >  they are transparent and predictable.  du -s $HOME should *always*
> >  match your usage according to "quota".
>
> Err, except maybe when you also own a file in /home/idiot/idiots_unprotected_storage_dir
> (This relates not at all to your patch/comments.)

No - "the ... usage of a file is charged to the tree, RATHER THAN THE
OWNER OF THE FILE". So, in this case, if you own a file in ~idiot/foo,
idiot's quota is charged for the file, not you.


James.
-- 
"Our attitude with TCP/IP is, `Hey, we'll do it, but don't make a big
system, because we can't fix it if it breaks -- nobody can.'"

"TCP/IP is OK if you've got a little informal club, and it doesn't make
any difference if it takes a while to fix it."
		-- Ken Olson, in Digital News, 1988


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278131AbRJRUUc>; Thu, 18 Oct 2001 16:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278125AbRJRUUX>; Thu, 18 Oct 2001 16:20:23 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:55023
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278121AbRJRUUJ>; Thu, 18 Oct 2001 16:20:09 -0400
Date: Thu, 18 Oct 2001 13:20:35 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: James Sutherland <jas88@cam.ac.uk>
Cc: Ben Greear <greearb@candelatech.com>, Neil Brown <neilb@cse.unsw.edu.au>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
Message-ID: <20011018132035.A444@mikef-linux.matchmail.com>
Mail-Followup-To: James Sutherland <jas88@cam.ac.uk>,
	Ben Greear <greearb@candelatech.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BCE6E6E.3DD3C2D6@candelatech.com> <Pine.SOL.4.33.0110180937420.13081-100000@yellow.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.33.0110180937420.13081-100000@yellow.csi.cam.ac.uk>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 09:38:47AM +0100, James Sutherland wrote:
> On Wed, 17 Oct 2001, Ben Greear wrote:
> 
> > Neil Brown wrote:
> > >
> > > Hi,
> > >  In my ongoing effort to provide centralised file storage that I can
> > >  be proud of, I have put together some code to implement tree quotas.
> > >
> > >  The idea of a tree quota is that the block and inode usage of a file
> > >  is charged to the (owner of the root of the) tree rather than the
> > >  owner (or group owner) of the file.
> > >  This will (I hope) make life easier for me.  There are several
> > >  reasons that I have documented (see URL below) but a good one is that
> > >  they are transparent and predictable.  du -s $HOME should *always*
> > >  match your usage according to "quota".
> >
> > Err, except maybe when you also own a file in /home/idiot/idiots_unprotected_storage_dir
> > (This relates not at all to your patch/comments.)
> 
> No - "the ... usage of a file is charged to the tree, RATHER THAN THE
> OWNER OF THE FILE". So, in this case, if you own a file in ~idiot/foo,
> idiot's quota is charged for the file, not you.

Actually, it looks like Niel is creating a two level Quota system.  In ther
normal quota system, if you own a file anywhere, it is attributed to you.
But, in the tree quota system, it is attributed to the owner of the tree...

Niel, how do you plan to notify someone that their tree quota has been
exceeded instead of their normal quota?

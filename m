Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278159AbRJRVSb>; Thu, 18 Oct 2001 17:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278152AbRJRVSW>; Thu, 18 Oct 2001 17:18:22 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:26106 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S278149AbRJRVSH>; Thu, 18 Oct 2001 17:18:07 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 18 Oct 2001 15:17:18 -0600
To: James Sutherland <jas88@cam.ac.uk>, Ben Greear <greearb@candelatech.com>,
        Neil Brown <neilb@cse.unsw.edu.au>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
Message-ID: <20011018151718.O1144@turbolinux.com>
Mail-Followup-To: James Sutherland <jas88@cam.ac.uk>,
	Ben Greear <greearb@candelatech.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BCE6E6E.3DD3C2D6@candelatech.com> <Pine.SOL.4.33.0110180937420.13081-100000@yellow.csi.cam.ac.uk> <20011018132035.A444@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011018132035.A444@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 18, 2001  13:20 -0700, Mike Fedyk wrote:
> On Thu, Oct 18, 2001 at 09:38:47AM +0100, James Sutherland wrote:
> > No - "the ... usage of a file is charged to the tree, RATHER THAN THE
> > OWNER OF THE FILE". So, in this case, if you own a file in ~idiot/foo,
> > idiot's quota is charged for the file, not you.

However, this means that if anyone has write permission into a tree, they
can "offload" their quota to another user and keep more files than they
ought to.  Also, depending on the permissions of the file/directory, the
"tree" owner may not even be able to delete the files that are causing
their quota to be exceeded.

> Actually, it looks like Niel is creating a two level Quota system.  In ther
> normal quota system, if you own a file anywhere, it is attributed to you.
> But, in the tree quota system, it is attributed to the owner of the tree...

Hmm, we already have group quotas, and (excluding ACLs) you would need to
have group write permission into the tree to be able to write there.  How
does the tree quota help us in the end?  Either users are "nice" and you
don't need quotas, or users are "not nice" and you don't want them to be
able to dump their files into an area that doesn't keep them "in check" as
quotas are designed to do.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267146AbTAPPfA>; Thu, 16 Jan 2003 10:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267148AbTAPPfA>; Thu, 16 Jan 2003 10:35:00 -0500
Received: from angband.namesys.com ([212.16.7.85]:41104 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267146AbTAPPe7>; Thu, 16 Jan 2003 10:34:59 -0500
Date: Thu, 16 Jan 2003 18:43:52 +0300
From: Oleg Drokin <green@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, eazgwmir@umail.furryterror.org,
       viro@math.psu.edu, nikita@namesys.com
Subject: Re: [2.4] VFS locking problem during concurrent link/unlink
Message-ID: <20030116184352.A32192@namesys.com>
References: <20030116140015.A17612@namesys.com> <1042731580.31099.2195.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1042731580.31099.2195.camel@tiny.suse.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jan 16, 2003 at 10:39:41AM -0500, Chris Mason wrote:
> >    Debugging reiserfs problem that can be demonstrated with script created by
> >    Zygo Blaxell, I started to wonder if the problem presented is indeed reiserfs
> >    fault and not VFS.
> >    Though the Zygo claims script only produces problems on reiserfs, I am trying
> >    it now myself on ext2 (which will take some time).
> > 
> >    Debugging shows that reiserfs_link is sometimes called for inodes whose
> >    i_nlink is zero (and all corresponding data is deleted already).
> >    So my current guess of what's going on is this:
> No, this is a reiserfs bug, since we schedule after doing link checks in
> reiserfs_link and reiserfs_unlink.  I sent a patch to reiserfs dev a
> while ago, I'll pull it out of the suse kernel and rediff against
> 2.4.20.

Yes we do.
But on the other hand I've put a check at the beginning of reiserfs_link
and I am still seeing these links on inodes with i_nlink == 0.

Bye,
    Oleg

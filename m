Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSKDWxC>; Mon, 4 Nov 2002 17:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262870AbSKDWxC>; Mon, 4 Nov 2002 17:53:02 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:2951 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262838AbSKDWxB>; Mon, 4 Nov 2002 17:53:01 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: "Stephen C. Tweedie" <sct@redhat.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Htree ate my hard drive, was: post-halloween 0.2
Date: Mon, 4 Nov 2002 23:59:36 +0100
User-Agent: KMail/1.4.7
References: <20021030171149.GA15007@suse.de> <20021031080717.GF28982@clusterfs.com> <20021104224213.F14318@redhat.com>
In-Reply-To: <20021104224213.F14318@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211042359.37492.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 November 2002 23:42, Stephen C. Tweedie wrote:
> Hi,
>
> On Thu, Oct 31, 2002 at 01:07:17AM -0700, Andreas Dilger wrote:
> > On Oct 31, 2002  07:27 +0100, Duncan Sands wrote:
> > > After a bit of switching back and forth between 2.4.19 and 2.5.44,
> > > fsck was run while booting 2.4.19 (the usual check because of >30
> > > mounts).  There was a message about optimizing directories.  Booting
> > > continued but (big surprise) X refused to run.  It turned out that some
> > > device files had vanished.
> > >
> > > tune2fs -O ^dir_index /dev/hdXXX
> > > to remove htree support.  No problems since then.
> >
> > I wonder if there is still a bug in the e2fsck code for re-hashing
> > directories?
>
> Possibly, but I'm more worried about why the fsck did a directory
> optimise on reboot, especially on the root filesystem (where /dev is
> usually stored).  Doing major fs surgery on a mounted, readonly
> filesystem is sort-of safe, but only if you reboot afterwards.
> Continuing and remounting read-write can cause all sorts of damage as
> the cached fs data no longer matches what's on disk.
>
> Duncan, did you have fsck set up to do a forced htree rebuild on
> reboot?

Hmmm, fsck is called from the debian checkroot init script which does
fsck -a -C
So I guess the answer is "no".

Duncan.

PS: I am using version 1.30-WIP of e2fsck.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313465AbSDJSPM>; Wed, 10 Apr 2002 14:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313476AbSDJSPM>; Wed, 10 Apr 2002 14:15:12 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:50168 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313465AbSDJSPK>; Wed, 10 Apr 2002 14:15:10 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 10 Apr 2002 12:13:04 -0600
To: Dominik Kubla <kubla@sciobyte.de>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "Alexis S. L. Carvalho" <alexis@cecm.usp.br>,
        linux-kernel@vger.kernel.org
Subject: Re: implementing soft-updates
Message-ID: <20020410181304.GA3509@turbolinux.com>
Mail-Followup-To: Dominik Kubla <kubla@sciobyte.de>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	"Alexis S. L. Carvalho" <alexis@cecm.usp.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020409184605.A13621@cecm.usp.br> <200204100041.g3A0fSj00928@saturn.cs.uml.edu> <20020410092807.GA4015@duron.intern.kubla.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 10, 2002  11:28 +0200, Dominik Kubla wrote:
> try to implement the snapshot capability for  ext2/ext3. Everyone of us
> who has to do live backups of production systems  will thank you if you
> get that development started.

LVM can already do snapshots at the device level.  It integrates with
ext3/XFS/reiserfs via sync_super_lockfs/unlockfs so that what is in
the snapshot is a consistent, clean filesystem.

There might need to be a little touchup with ext2 to support these
calls, but even in the current state you get a usable filesystem
snapshot, with the exception that the filesystem has not been marked
clean.

As for a filesystem-level ext2/ext3 snapshot, this has also already
been done (sf.net/projects/snapfs).  The people who took over that
project have removed all of the released files and CVS, but you can
still get the CVS from the sourceforge CVS backups.  I also have a
version here, but don't have any time to work on it.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318630AbSICSBt>; Tue, 3 Sep 2002 14:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318878AbSICSAy>; Tue, 3 Sep 2002 14:00:54 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:14588 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318866AbSICSA2>; Tue, 3 Sep 2002 14:00:28 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 3 Sep 2002 12:02:43 -0600
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Lars Marowsky-Bree <lmb@suse.de>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct"
Message-ID: <20020903180243.GR32468@clusterfs.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	"Peter T. Breuer" <ptb@it.uc3m.es>,
	Lars Marowsky-Bree <lmb@suse.de>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <200209031641.g83GfnD10219@oboe.it.uc3m.es> <Pine.LNX.4.44L.0209031425180.1519-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0209031425180.1519-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 03, 2002  14:26 -0300, Rik van Riel wrote:
> On Tue, 3 Sep 2002, Peter T. Breuer wrote:
> > > Your approach is not feasible.
> >
> > But you have to be specific about why not. I've responded to the
> > particular objections so far.
> 
> You make it sound like you bet your masters degree on
> doing a distributed filesystem without filesystem support ;)

Actually, we are using ext3 pretty much as-is for our backing-store
for Lustre.  The same is true of InterMezzo, and NFS, for that matter.
All of them live on top of a standard "local" filesystem, which doesn't
know the things that happen above it to make it a network filesystem
(locking, etc).

That isn't to say that I agree with just taking a local filesystem and
putting it on a shared block device and expecting it to work with only
the normal filesystem code.  We do all of our locking above the fs
level, but we do have some help in the VFS (intent-based lookup, patch
in the Lustre CVS repository, if people are interested).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/


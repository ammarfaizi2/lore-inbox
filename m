Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271246AbRINVi5>; Fri, 14 Sep 2001 17:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271226AbRINVir>; Fri, 14 Sep 2001 17:38:47 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:31732 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271246AbRINVig>; Fri, 14 Sep 2001 17:38:36 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 14 Sep 2001 15:38:48 -0600
To: Otto Wyss <otto.wyss@bluewin.ch>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: How errorproof is ext2 fs?
Message-ID: <20010914153848.C1541@turbolinux.com>
Mail-Followup-To: Otto Wyss <otto.wyss@bluewin.ch>,
	Mark Hahn <hahn@physics.mcmaster.ca>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10109140953100.24181-100000@coffee.psychology.mcmaster.ca> <3BA26CFA.E3859A7A@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA26CFA.E3859A7A@bluewin.ch>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 14, 2001  22:47 +0200, Otto Wyss wrote:
> > there's no reason you can't configure your boot scripts to automatically
> > fix such problems.  and by "manually", I hope you meant that "fsck -y"
> > took 15 minutes to run.
> > ...
> What's this "-y" meaning, "man fsck" does not show it. Could this mean answer
> any question with "yes"? The 15 minutes I needed to answer about the first
> hundreds of questions with "y", afterwards I simply pressed "y" until the fsck
> was finished.

Well, the "best" way of running e2fsck is with the "-p" option, so that it
will pick y/n as appropriate.  In almost all cases "-p" and "-y" behave
the same, but in a few rare cases they do not.

In general, if you are manually fsck'ing a filesystem, it is better to
run fsck.<fstype> directly (and read its man page) instead of the "fsck"
wrapper program.

In some rare cases, fsck cannot decide what is the right thing to do, so
you need to run it in manual mode, which appears to be what happened to you.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert


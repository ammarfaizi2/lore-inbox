Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278591AbRJXPnN>; Wed, 24 Oct 2001 11:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278592AbRJXPnH>; Wed, 24 Oct 2001 11:43:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6414 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S278565AbRJXPmw>; Wed, 24 Oct 2001 11:42:52 -0400
Date: Wed, 24 Oct 2001 17:39:30 +0200
From: Jan Kara <jack@suse.cz>
To: James Sutherland <jas88@cam.ac.uk>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
Message-ID: <20011024173930.A19777@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011024171658.B10075@atrey.karlin.mff.cuni.cz> <Pine.SOL.4.33.0110241633000.24809-100000@yellow.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.33.0110241633000.24809-100000@yellow.csi.cam.ac.uk>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 24 Oct 2001, Jan Kara wrote:
> 
> >   But how do you solve the following: mv <dir> <some_other_dir>
> > The parent changes. You need to go through all the subdirs of <dir> and change
> > the TID. This is really hard to get right and to avoid deadlocks
> > and races... At least it seems to me so.
> 
> Provided you are tracking the total size in each directory, it's just a
> matter of subtracting dir's size from the old parent, and adding it to the
> new parent. (With suitable checks beforehand to avoid a result which
> exceeds quota.)
  Nope. If you'd just keep usage in directory than you need to go all the way
up and decrease the usage and then go all the way down in the new directory.
It's simplier but also nontrivial...

									Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273628AbRIQOSs>; Mon, 17 Sep 2001 10:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273625AbRIQOSj>; Mon, 17 Sep 2001 10:18:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15109 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S273620AbRIQOS0>; Mon, 17 Sep 2001 10:18:26 -0400
Date: Mon, 17 Sep 2001 16:15:49 +0200
From: Jan Kara <jack@suse.cz>
To: Matt Bernstein <matt@theBachChoir.org.uk>
Cc: linux-kernel@vger.kernel.org, bertie@scn.org
Subject: Re: 2.4, 2.4-ac and quotas
Message-ID: <20010917161549.A26749@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010917152855.B18298@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0109171441550.20292-100000@nick.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0109171441550.20292-100000@nick.dcs.qmul.ac.uk>; from matt@theBachChoir.org.uk on Mon, Sep 17, 2001 at 03:03:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> At 15:28 +0200 Jan Kara wrote:
> 
> >  And are you sure that /export01/aquota.user is correct quotafile (ie.
> >created by quotacheck or convertquota)? This is message you usually get
> >when quotafile has incorrect header... (or also when bogus arguments
> >are specified but it's probably not your case).
> 
> Bingo.. I naively read http://www.linuxdoc.org/HOWTO/mini/Quota.html
> and applied it to vfsv0. Could this be updated to reflect the new quotas
> please? I'd like to read of the differences--is, for example, the new
  Ok. I'll try to update the howto and send it to maintainer.

> quotacheck faster? Or does it all depend on the speed of the underlying
> filesystem ond not much else?
  The main difference is that new quota format supports 32-uids. There are
other minor changes - like root is no longer special user and such.
  quotacheck speed relies completely on filesystem speed - quotacheck
has to scan all the filesystem. If you use e2fslib support on ext2 than
it should be reasonably fast but I agree that otherwise it's pain.

								Honza
--
Jan Kara <jack@suse.cz>
SuSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273601AbRIQM4f>; Mon, 17 Sep 2001 08:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273602AbRIQM4Z>; Mon, 17 Sep 2001 08:56:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41232 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S273601AbRIQM4J>; Mon, 17 Sep 2001 08:56:09 -0400
Date: Mon, 17 Sep 2001 14:56:29 +0200
From: Jan Kara <jack@suse.cz>
To: Matt Bernstein <matt@theBachChoir.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4, 2.4-ac and quotas
Message-ID: <20010917145629.A18298@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0109141730410.30680-100000@nick.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0109141730410.30680-100000@nick.dcs.qmul.ac.uk>; from matt@theBachChoir.org.uk on Fri, Sep 14, 2001 at 05:45:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> I'm desperately looking for some recent documentation on quotas.
> 
> We've recently upgraded our two Debian potato fileservers to 2.4 and
> 2.4-ac (currently they're both running 2.4-ac so I can't check 2.4 atm)
> and quotas have stopped working.
> 
> The quota package is 3.00pre01-7.bunk, and quotaon calls quotactl which
> returns -1 ENOENT (No such file or directory), as it's looking for
> aquota.user, evidently a "version 2 quota" (according to the edquota
> manpage), and not falling back to the quota.user files which do exist.
> 
> So now we're essentially running without quota support :-(
> 
> On another computer (Debian woody) I've made an ext3 partition, touched
> aquota.user and quotactl now returns -1 EINVAL (Invalid argument).
  Before you can use new quota you have to convert old quotafiles to new
ones. You can do this by convertquota(8) utility which is in the package.
Or you can just run 'quotacheck -F vfsv0 -c <mountpoint>' to create completely
new quota files with new quota format.
  3.01-pre9 which Alan pointed you to is the latest release of quota tools
(I have already some bugfixes but they are of minor nature).

									Honza

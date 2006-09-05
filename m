Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWIEKIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWIEKIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 06:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWIEKIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 06:08:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:15580 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751200AbWIEKIo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 06:08:44 -0400
X-Authenticated: #19095397
From: Bernd Schubert <bernd-schubert@gmx.de>
To: Jan Kara <jack@suse.cz>
Subject: Re: quota problem with 2.6.15.7
Date: Tue, 5 Sep 2006 12:08:43 +0200
User-Agent: KMail/1.9.4
Cc: reiserfs-list@namesys.org, linux-kernel@vger.kernel.org
References: <200609021557.03885.bernd-schubert@gmx.de> <20060905091924.GC3830@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060905091924.GC3830@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609051208.43857.bernd-schubert@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jan,

On Tuesday 05 September 2006 11:19, Jan Kara wrote:
>   Hello,
>
> > I just wanted to enable quotas on one of our server systems and got an
> > oops. This is an opteron system with a kernel in 64bit mode.
> > As you can see, the filesystem is reiserfs.
>
>   Hmm, is this reproducible? Any chances of trying out some newer
> kernel?

[trace deleted]

>   Hmm, the trace looks strange... It is definitely mixed with some old
> data. We definitely reached reiserfs_quota_on() but didn't reach
> vfs_quota_on() so it seems we crashed somewhere in path_lookup() (also
> link_path_walk() in the beginning of the trace suggests that). That's
> generic VFS code so maybe this is nothing quota specific. So this looks
> quite hard to debug if there's no reasonable way of reproducing it.

Its reproducible, I hoped it wouldn't happen again after a reboot, but 
unfortunately it did. Trying a newer kernel, hmm, usually a problem on server 
systems. I will try to test quotas on another amd64 system first(*).

Thanks for your help,
Bernd

(*) Which would be easy, if there wouldn't be a 64bit kernel, 32bit glibc, 
nfsclient inode truncation bug, which forces me to run all of our amd64 
nfsroot-clients with a 32bit kernel, http://lkml.org/lkml/2005/2/28/172. 
Well, my fault that I still didn't submit a glibc bug report.

-- 
Bernd Schubert
PCI / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg


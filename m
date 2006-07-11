Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWGKCgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWGKCgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 22:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWGKCgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 22:36:47 -0400
Received: from pat.uio.no ([129.240.10.4]:13440 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965083AbWGKCgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 22:36:46 -0400
Subject: Re: ext4 features
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44B2D6AA.3090707@tmr.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>
	 <20060705125956.GA529@fieldses.org>
	 <1152128033.22345.17.camel@lade.trondhjem.org>  <44AC2D9A.7020401@tmr.com>
	 <1152135740.22345.42.camel@lade.trondhjem.org>  <44B01DEF.9070607@tmr.com>
	 <1152562135.6220.7.camel@lade.trondhjem.org>  <44B2D6AA.3090707@tmr.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 22:36:23 -0400
Message-Id: <1152585383.10156.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5, required 12,
	autolearn=disabled, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 18:37 -0400, Bill Davidsen wrote:
> Trond Myklebust wrote:
> 
> >On Sat, 2006-07-08 at 17:04 -0400, Bill Davidsen wrote:
> >  
> >
> >>No, I didn't quite mean a manual touch, but a system call to "close and 
> >>set time to high resolution" for files where time uniformity is 
> >>important. Consider that in most cases the inodes times are set by the 
> >>host machine clock, which I close the change reflects the fileserving 
> >>host idea of time. If there were a call to close a file and set the 
> >>times like touch, then that could be used, for both local and network files.
> >>    
> >>
> >
> >Close should never update the time since that would be a violation of
> >POSIX rules. Normally, an NFS client will never need to update the time:
> >RPC calls like WRITE, READ and SETATTR will automatically do it for us
> >whenever necessary.
> >  
> >
> 
> Let me restate this a third time in another way. What I suggest is a 
> system call, NOT NAMED CLOSE, which does a close and touch. This was all 
> blue sky discussion, new system calls are as valid as nanosecond 
> resolution and syncronization between servers. Since this is a new call 
> it is not specified by POSIX.
> 
> And Linus has already suggested that he would accept something similar, 
> when I proposed something like "noatime" mounts, which only updated 
> atime and mtime on open and close, to keep metadata relevant but not 
> have the overhead of constant updates.
> 
> Actually, now that I have more free time I may revisit that idea.

Linus might accept it, but I won't. It is totally unnecessary.

Cheers,
  Trond


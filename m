Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284996AbRLKOby>; Tue, 11 Dec 2001 09:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285032AbRLKObp>; Tue, 11 Dec 2001 09:31:45 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60690 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S285022AbRLKObg>; Tue, 11 Dec 2001 09:31:36 -0500
Date: Tue, 11 Dec 2001 15:31:22 +0100
From: Jan Kara <jack@suse.cz>
To: Simon Byrnand <simon@igrin.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in disk Quota's on 2.2.19 (and maybe other kernels) ?
Message-ID: <20011211153121.A25342@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3.0.6.32.20011211164149.00b7ba20@mail.igrin.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.6.32.20011211164149.00b7ba20@mail.igrin.co.nz>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Hi everyone, please CC any replies as I'm not on the list.
> 
> I've just started using Disk Quotas with Redhat 6.2, and 2.2.19 kernel, ext2.
> 
> Everything is working ok except I notice an anomoly - if I have an apache
> log file (which is kept open while apache is running) which is owned by a
> normal user account, and I chown it to root, the quotas are not updated to
> reflect the fact that the user who used to own the file should have less
> space "used" from their quota. There should be a decrease in the amount of
> space used in their quota by the size of the file.
> 
> If I then chown the file back to them again there *is* an increase in space
> used on their quota. chowning the file back to root again a second time
> *does* cause a decrease in space used from their quota, but only back to
> the previous incorrect amount.
> 
> If I then run quotacheck -avug to force a manual refresh of all the quotas,
> the discrepancy is corrected.
  Hmm.. Strange. It looks like a bug in quota code. I'll try to reproduce it...

> Whats going on here ? Is the quota code buggy ? Is this something which has
> been fixed in 2.4 ?
  I have no report of such bug in 2.4 :). 
 
									Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs

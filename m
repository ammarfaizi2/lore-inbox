Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285412AbRLNQxz>; Fri, 14 Dec 2001 11:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285414AbRLNQxq>; Fri, 14 Dec 2001 11:53:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20742 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285412AbRLNQx3>;
	Fri, 14 Dec 2001 11:53:29 -0500
Date: Fri, 14 Dec 2001 17:53:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] RAID sub system
Message-ID: <20011214165303.GK1180@suse.de>
In-Reply-To: <Pine.LNX.4.33.0112131525470.15231-100000@coffee.psychology.mcmaster.ca> <Pine.LNX.4.30.0112141448020.6153-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0112141448020.6153-100000@mustard.heime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14 2001, Roy Sigurd Karlsbakk wrote:
> > my observation is this: once you use up all your free memory, you have
> > 30 seconds of reasonable behavior.  30 seconds is the the default dirty-buffer
> > age.  are you tweaking /proc/sys/vm/bdflush at all?  and no, I don't see
> > why your application would have dirty buffers in the first place -
> > I'm just noticing the ominous 30 seconds.
> 
> More testing with bootparam mem=xxx shows this is it. When all memory is
> used, it fails to re-use old cache, or something.

sysrq-t output from a "hung" system would give some valuable info as to
why it's stuck.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265594AbUBBOel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 09:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265610AbUBBOel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 09:34:41 -0500
Received: from nevyn.them.org ([66.93.172.17]:22668 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265594AbUBBOek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 09:34:40 -0500
Date: Mon, 2 Feb 2004 09:34:39 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID arrays not reconstructing in 2.6
Message-ID: <20040202143439.GA22241@nevyn.them.org>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <20040201171525.GA2092@nevyn.them.org> <16413.54841.104599.928032@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16413.54841.104599.928032@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 03:46:49PM +1100, Neil Brown wrote:
> On Sunday February 1, dan@debian.org wrote:
> > I saw this a couple of weeks ago in a 2.6.0-test kernel, and today in
> > 2.6.2-rc3.  When I have to hit the hard reset button on my desktop, whose
> > root filesystem is RAID5 on /dev/md0, it comes back up cleanly - no
> > reconstruction.
> 
> Cool, isn't it!
> 
> > 
> > Have we gotten a whole lot more enthusiastic about marking superblocks clean
> > lately, or should I be worried?  Obviously this always used to trigger
> > reconstruction, until recently.
> 
> Yes.  Lots more enthusiastic.
> If there is no write activity for 20msec, we mark the superblock clean
> and write it out, and are careful to write out a dirty superblock
> before allowing another write to complete.

Wow, thanks!  That's really awesome, considering how long
reconstruction takes this system (about an hour of completely useless
otherwise).

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

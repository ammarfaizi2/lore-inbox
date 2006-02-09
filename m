Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWBIXeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWBIXeq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWBIXeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:34:46 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29110 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750809AbWBIXep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:34:45 -0500
Date: Fri, 10 Feb 2006 00:34:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060209233406.GD3389@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060209092555.GB2940@elf.ucw.cz> <200602091422.40738.rjw@sisk.pl> <200602100816.18904.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602100816.18904.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Any changes to userspace are a fair game. OTOH kernel provides linear
> > > image to be saved to userspace, and what it uses internally should not
> > > be important to userland parts. (And Rafael did some changes in that
> > > area to make it more effective, IIRC).
> >
> > Yes.  The code is now split into the part that handles the snapshot image
> > (in snapshot.c) and the part that writes/reads it to swap (in swap.c). [I'm
> > referring to recent -mm kernels.]
> >
> > The access to the snapshot image is provided via the functions
> > snapshot_write_next() and snapshot_read_next() that are called by the
> > code in swap.c and may be used by the user space tools via the
> > interface in user.c.  In principle it ought to be possible to plug
> > something else instead of the code in snapshot.c without
> > breaking the rest.
> 
> So, what is the answer then? If I submitted patches to provide the possibility 
> of separating LRU pages into a separate stream of pages to be read/written, 
> would it have any chance of getting merged? (Along with other patches to make 
> writing a full image of memory possible).

Could we do the other stuff, first, please? Userland
LZF/encryption/progress should be easy to do, and doing that should
teach us how to cooperate.
									Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...

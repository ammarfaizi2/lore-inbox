Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbTIQWt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 18:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbTIQWt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 18:49:59 -0400
Received: from havoc.gtf.org ([63.247.75.124]:19116 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262893AbTIQWt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 18:49:58 -0400
Date: Wed, 17 Sep 2003 18:45:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Export new char dev functions
Message-ID: <20030917224549.GD4920@gtf.org>
References: <20030917024911.GA35464@compsoc.man.ac.uk> <20030917163628.19833.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030917163628.19833.qmail@lwn.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 10:36:28AM -0600, Jonathan Corbet wrote:
> > John Levon sez:
> > > Of course, there are other exports from that file (i.e. register_chrdev());
> > > are we actively trying to shrink ksyms.c?
> > 
> > I think we are, yes. ksyms.c just makes life harder.
> 
> OK, here is a version that evacutates all of fs/char_dev.c's functions out
> of ksyms.c.  And that, probably, is about all the bandwidth this little
> patch is worth...
> 
> jon
> 
> diff -urN -X dontdiff test5-vanilla/fs/char_dev.c test5/fs/char_dev.c
> --- test5-vanilla/fs/char_dev.c	Mon Sep  8 13:50:01 2003
> +++ test5/fs/char_dev.c	Wed Sep 17 10:45:46 2003

Need to modify export-objs line in fs/Makefile too.

	Jeff




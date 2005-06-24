Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbVFXPx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbVFXPx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbVFXPxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:53:41 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:34558 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263100AbVFXPuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:50:23 -0400
Date: Fri, 24 Jun 2005 08:38:19 -0400
From: Christopher Li <hg@chrisli.org>
To: Petr Baudis <pasky@ucw.cz>
Cc: Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Message-ID: <20050624123819.GD9519@64m.dyndns.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624064101.GB14292@pasky.ji.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 08:41:01AM +0200, Petr Baudis wrote:
> > 5.1) undo the last commit or pull
> > 
> > $ hg undo
> 
> $ cg-admin-uncommit
> 
> Note that you should never do this if you already pushed the changes
> out, or someone might get them. (That holds for regular Git too.) See
> 
> $ cg-help cg-admin-uncommit   # (or cg-admin-uncommit --help)
> 
> for details. (That's another Cogito's cool feature. Handy docs! ;-)
> 

Does it still works if the last commit was interrupted  or due to error for some
reason?  Undo pull is pretty cool because you might pull a lot of commit
in one blow. Get rid of commit one by one is going to be painful. Some times
the object you pull has more than one chain of history it will be very nasty
if you want to clean it up.

Mercurial's undo is taking a snapshot of all the changed file's repo file length
at every commit or pull.  It just truncate the file to original size and undo 
is done.

Chris


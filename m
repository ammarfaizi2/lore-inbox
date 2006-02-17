Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWBQMbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWBQMbQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 07:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWBQMbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 07:31:16 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:55213 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750829AbWBQMbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 07:31:16 -0500
Date: Fri, 17 Feb 2006 07:31:02 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Christoph Hellwig <hch@lst.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate the tasklist_lock export
In-Reply-To: <20060217112032.GD28448@lst.de>
Message-ID: <Pine.LNX.4.58.0602170727040.27060@gandalf.stny.rr.com>
References: <20060215130734.GA5590@lst.de> <Pine.LNX.4.58.0602150903020.25659@gandalf.stny.rr.com>
 <20060217112032.GD28448@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Feb 2006, Christoph Hellwig wrote:

> On Wed, Feb 15, 2006 at 09:09:36AM -0500, Steven Rostedt wrote:
> > Hmm, I have some debug modules that do use that lock.  Is it possible to
> > export it only if CONFIG_DEBUG_KERNEL?
>
> That doesn't make a whole lot of sense.  What's your debug module doing?
> Should we just put it in the tree as builtin-code under a debug option?
>

Nah, It's not worth it.  I have some mutex test modules that search the
tasks to determine what priorities are there and uses that info for
setting the priorities of the threads it creates. Yes, this can be done
from userland as well, but i was being lazy and just wrote eveything in
the module.

So, forget what I asked for and do what you want.  These modules are
really just for testing specific things that I work on and I can find
other ways around it.  Really the easiest thing is to just add the EXPORT
myself since I need to recompile the kernel anyways.

Thanks anyway,

-- Steve


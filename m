Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUHaGcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUHaGcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266748AbUHaGcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:32:33 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20191 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266802AbUHaGcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:32:16 -0400
Date: Tue, 31 Aug 2004 08:28:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: What policy for BUG_ON()?
Message-ID: <20040831062815.GA2312@suse.de>
References: <20040830201519.GH12134@fs.tum.de> <1093897329.2870.11.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093897329.2870.11.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30 2004, Arjan van de Ven wrote:
> On Mon, 2004-08-30 at 22:15, Adrian Bunk wrote:
> > Let me try to summarize the different options regarding BUG_ON, 
> > concerning whether the argument to BUG_ON might contain side effects, 
> > and whether it should be allowed in some "do this only if you _really_ 
> > know what you are doing" situations to let BUG_ON do nothing.
> > 
> > Options:
> > 1. BUG_ON must not be defined to do nothing
> > 1a. side effects are allowed in the argument of BUG_ON
> > 1b. side effects are not allowed in the argument of BUG_ON
> > 2. BUG_ON is allowed to be defined to do nothing
> > 2a. side effects are allowed in the argument of BUG_ON
> > 2b. side effects are not allowed in the argument of BUG_ON
> 
> since you quoted me earlier my 2 cents:
> 1) I would prefer BUG_ON() arguments to not have side effects; its just 
> cleaner that way. (similar to assert)
> 
> 2) if one wants to compiel out BUG_ON, I rather alias it to panic() than
> to nothing.

I agree completely with that.

-- 
Jens Axboe


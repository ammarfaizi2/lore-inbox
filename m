Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbTKJOY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 09:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTKJOY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 09:24:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37853 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263767AbTKJOYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 09:24:25 -0500
Date: Mon, 10 Nov 2003 15:23:41 +0100
From: Jens Axboe <axboe@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Simon Haynes <simon@baydel.com>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: SFFDC and blksize_size
Message-ID: <20031110142341.GG32637@suse.de>
References: <37CC93E8710D@baydel.com> <20031110140927.GE32637@suse.de> <1068473878.5743.6.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068473878.5743.6.camel@hades.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10 2003, David Woodhouse wrote:
> On Mon, 2003-11-10 at 15:09 +0100, Jens Axboe wrote:
> > On Fri, Nov 07 2003, Simon Haynes wrote:
> > > 
> > > I have been writing a block driver for SSFDC compliant SMC cards. This stuff 
> > > allocates 16k blocks.  When I get requests the transfers are split into the 
> > > size I specifty in the blksize_size{MAJOR] array. It sems that most things 
> > 
> > Sounds like a bad way to do it. It's much better to prevent builds of
> > bigger requests than you can handle in one go. You don't mention what
> > kernel you are using, but both 2.4 and 2.6 can do this for you.
> 
> The problem is the other way round -- he wants request merging, and he's
> achieving this by setting the block size higher.... and observing a
> crash when he sets his block size higher than PAGE_SIZE.

Yes I know, but he doesn't want requests merged > 16k, right? So it's
stupid to allow these to get through.

-- 
Jens Axboe


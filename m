Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbTJQGqs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 02:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTJQGqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 02:46:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26296 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263317AbTJQGqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 02:46:47 -0400
Date: Fri, 17 Oct 2003 08:46:45 +0200
From: Jens Axboe <axboe@suse.de>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
Cc: Greg Stark <gsstark@mit.edu>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031017064645.GX1128@suse.de>
References: <785F348679A4D5119A0C009027DE33C105CDB2C5@mcoexc04.mlm.maxtor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB2C5@mcoexc04.mlm.maxtor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16 2003, Mudama, Eric wrote:
> 
> On Tue, Oct 14 2003, Greg Stark wrote:
> > Jens Axboe <axboe@suse.de> writes:
> > > There's also the case of files opened with O_SYNC. Would inserting a
> > > write barrier after every write to such a file destroy performance?
> > 
> > If it's mainly sequential io, then no it won't destroy performance. It
> > will be lower than without the cache flush of course.
> 
> If you flush a cache after every command in a sequential write, yes, you'll
> destroy performance.  How much you destroy it is a function of command size
> relative to track size, and the RPM of the drive.

Yes you are right, my logic was a bit backwards. But you don't have to
issue a flush after every write, thankfully. But lets still not forget
that performance means nothing if integrity isn't guarenteed.

-- 
Jens Axboe


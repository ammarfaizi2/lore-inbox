Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVELPQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVELPQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 11:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVELPQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 11:16:36 -0400
Received: from kanga.kvack.org ([66.96.29.28]:41687 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262011AbVELPQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 11:16:29 -0400
Date: Thu, 12 May 2005 11:19:18 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reducing max segments expected to work?
Message-ID: <20050512151918.GC19612@kvack.org>
References: <20050511214749.GA14072@kvack.org> <20050512063757.GK23463@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512063757.GK23463@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 08:37:57AM +0200, Jens Axboe wrote:
> This doesn't really do what you would think it does - the defines should
> be called DEFAULT_PHYS_SEGMENTS etc, since they are just default values
> and do not denote any max-allowed-by-driver value.

They do place a limit on athe sgpool entries in scsi_lib.c.  I'm curious 
about the overhead from these data structures, hence the experimentation.

> But it is strange why your system wont boot after applying the above.
> What happens (and what kind of storage)?

The system is a pretty standard P4 with SATA on ICH6.  I tried booting 
with MAX_SECTORS = 31 (with *_SEGMENTS = 32) to no avail.  The system 
usually gets to some point in early userland init with whatever program 
(init) being stuck in D state waiting for io to complete.  I'm curious 
if there is some unwritten dependancy on MAX_SEGMENT_SIZE or some other 
piece of code being hit here...

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler

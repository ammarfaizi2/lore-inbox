Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbTJODll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 23:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbTJODll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 23:41:41 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:913 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262332AbTJODlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 23:41:40 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
References: <20031013140858.GU1107@suse.de>
In-Reply-To: <20031013140858.GU1107@suse.de>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 14 Oct 2003 23:40:42 -0400
Message-ID: <871xtfjhhh.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens Axboe <axboe@suse.de> writes:

> Hi,
> 
> Forward ported and tested today (with the dummy ext3 patch included),
> works for me. Some todo's left, but I thought I'd send it out to gauge
> interest. TODO:


Is there a user-space interface planned for this? 


One possibility may be just to hang it off fsync(2) so fsync doesn't return
until until all the buffers it flushed are actually synced to disk. That's its
documented semantics anyways.


There's also the case of files opened with O_SYNC. Would inserting a write
barrier after every write to such a file destroy performance?


-- 
greg


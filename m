Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbTEFRxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263901AbTEFRxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:53:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58069 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263881AbTEFRxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:53:06 -0400
Date: Tue, 6 May 2003 20:05:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bio walking for 2.5.68-bk6
Message-ID: <20030506180527.GI905@suse.de>
References: <Pine.SOL.4.30.0304252355170.21393-200000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0304252355170.21393-200000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 26 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> I have updated and reworked bio traversal patch.
> 
> Main idea is now reversed - instead of introducing rq->hard_bio as
> pointer for bio to be completed and using rq->bio as pointer for bio
> to be submitted, rq->cbio is introduced for submissions and rq->bio
> is used for completions.
> 
> This minimizes changes to block layer and assures that all existing
> block users are not affected by this patch.

This looks good, I like this concept a whole lot better.

> Please check it and forward to Linus, or tell what changes you
> need to find this code acceptable.

Will do, I've merged it into bk current right now. I'll submit after a
bit of testing.

-- 
Jens Axboe


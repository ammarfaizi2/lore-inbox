Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbUKVJWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUKVJWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 04:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUKVJWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 04:22:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10704 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262005AbUKVJVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 04:21:32 -0500
Date: Mon, 22 Nov 2004 10:20:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Tobias DiPasquale <codeslinger@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] add list_del_head function
Message-ID: <20041122092059.GA16487@suse.de>
References: <876ef97a04112007562d6797e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <876ef97a04112007562d6797e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20 2004, Tobias DiPasquale wrote:
> Hi all,
> 
> I was working with some queues the other day and I noticed that there
> was a list_add_tail() function in list.h, but no list_del_head()
> function. This struck me as a little odd, so I went ahead and
> implemented one in order to complete full queue functionality. The
> patch below was generated against pristine 2.6.9 kernel.org kernel
> sources and is attached to this email.

Generally patches like this have little merrit unless accompanied by
another patch converting several obvious pieces of kernel code to use
it.

Also I find the interface awkward and different from the other list
functions.

	entry = list_del_head(list);

would have been much nicer.

-- 
Jens Axboe


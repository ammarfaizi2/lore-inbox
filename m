Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbTJQSoW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 14:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbTJQSoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 14:44:21 -0400
Received: from mcomail03.maxtor.com ([134.6.76.14]:55053 "EHLO
	mcomail03.maxtor.com") by vger.kernel.org with ESMTP
	id S263586AbTJQSnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 14:43:01 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB2E1@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: "'Greg Stark'" <gsstark@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ide write barrier support
Date: Fri, 17 Oct 2003 12:42:59 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jens Axboe [mailto:axboe@suse.de]
>
> > Luckilly, us drive guys are a bit smarter (if only a bit)...
> 
> Some of you? :)

We're a little bit smarter than the totally braindead possible data order
issues that are allowed in the spec... but only a little bit smarter.

> That's why for IDE I prefer handling it in software. Let the 
> queue drain,
> issue a barrier write, and continue. That works, regardless of drive
> firmware implementations. As long as the spec doesn't make it explicit
> what happens, there's no way I can rely on it.

agreed

The drive will be doing ops as fast as possible, letting the queue go to
zero depth then flushing cache would be the absolute fastest way to do it
for best overall performance.

eric

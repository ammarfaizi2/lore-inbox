Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVIGSOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVIGSOp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbVIGSOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:14:44 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:45966 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932150AbVIGSOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:14:43 -0400
Subject: Re: [GIT PATCH] SCSI merge for 2.6.13
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <20050907174744.GA13172@us.ibm.com>
References: <1126053452.5012.28.camel@mulgrave>
	 <20050907174744.GA13172@us.ibm.com>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 13:14:10 -0500
Message-Id: <1126116850.4823.31.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 10:47 -0700, Patrick Mansfield wrote:
> The scsi_execute() retries argument is still not used.

Yes, Jens was thinking about how to add this to the block layer.

> How is this going to work?
> 
> For example, multiple unit attentions (power on / reset) during scanning.
> We send REPORT LUN, READ CAPACITY, etc., and would not retry if we got a
> unit attention.

Well ... all of the places we were specifying retries mostly had three
of them, so the scsi_request_fn() actually hard codes three retries.  A
hack, but it works until the real method is in place.

James



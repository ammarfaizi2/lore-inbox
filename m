Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWIMK5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWIMK5X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 06:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWIMK5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 06:57:23 -0400
Received: from [213.184.169.222] ([213.184.169.222]:20608 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751440AbWIMK5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 06:57:23 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: What's in linux-2.6-block.git
Date: Wed, 13 Sep 2006 13:59:04 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200609131359.04972.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe  wrote:
> This lists the main features of the 'block' branch, which is bound for
> Linus when 2.6.19 opens:
>
> - Splitting of request->flags into two parts:
>         - cmd type
>         - modified flags
>   Right now it's a bit of a mess, splitting this up invites a cleaner
>   usage and also enables us to implement generic "messages" passed on
>   the regular queue for the device.
>
> - Abstract out the request back merging and put it into the core io
>   scheduler layer. Cleans up all the io schedulers, and noop gets
>   merging for "free".
>
> - Abstract out the rbtree sorting. Gets rid of duplicated code in
>   as/cfq/deadline.
>
> - General shrinkage of the request structure.
>
> - Killing dynamic rq private structures in deadline/as/cfq. This should
>   speed up the io path somewhat, as we avoid allocating several
>   structures (struct request + scheduler private request) for each io
>   request.
>
> - meta data io logging for blktrace.
>
> - CFQ improvements.
>
> - Make the block layer configurable through Kconfig (David Howells).
>
> - Lots of cleanups.

Does it also address the strange "max_sectors_kb<>192 causes a 50%-slowdown" 
problem?


Thanks!

--
Al


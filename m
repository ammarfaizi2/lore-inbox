Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTJTXlT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbTJTXlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:41:19 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:8156 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S263130AbTJTXkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:40:42 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] ide write barrier support
Date: Tue, 21 Oct 2003 01:46:35 +0200
User-Agent: KMail/1.5.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031013140858.GU1107@suse.de> <200310201910.48837.phillips@arcor.de> <20031020195632.GA1128@suse.de>
In-Reply-To: <20031020195632.GA1128@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310210146.35881.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 October 2003 21:56, Jens Axboe wrote:
> There IS a correctness issue, in
> that drives ship with write back caching enabled. The fs assumes that
> once wait_on_buffer() returns, the data is on disk. Which is false, can
> remain false for quite a long number of seconds.

Maybe what you're saying is, there are only two ways to deal with IDE drives 
with non-disablable writeback cache:

  1) flush the cache on every write
  2) Implement write barriers, add them to all the journalling filesystems,
     and flush only on the write barrier

and (1) is just too slow.  Correct?

Regards,

Daniel


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWC3OZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWC3OZd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWC3OZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:25:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1743 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932226AbWC3OZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:25:33 -0500
Date: Thu, 30 Mar 2006 15:25:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] splice support #3
Message-ID: <20060330142532.GB11934@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, torvalds@osdl.org
References: <20060330131530.GI13476@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330131530.GI13476@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 03:15:30PM +0200, Jens Axboe wrote:
> Hi,
> 
> Ok, this should be it, I hope. Fixed the remaining issues spotted by
> akpm, and also thanks to KAMEZAWA Hiroyuki for pointing out that the
> page moving logic could get confused.

Haven't looked at this in details, but two small comments already:

 - generic_file_splice_read/write should probably go to filemap.c
   where all the other generic pagecache file operations are
 - could we try to replace ->sendfile and ->sendfile with the splice
   operations completely?  Having two different sets of zero-copy
   file to file transfer mechanisms will make the code pretty messy.


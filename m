Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVE0TzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVE0TzM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 15:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVE0TzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 15:55:12 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:59833 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262561AbVE0TzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 15:55:01 -0400
Message-ID: <42977B0D.3040809@ammasso.com>
Date: Fri, 27 May 2005 14:54:53 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Will __pa(vmalloc()) ever work?
References: <4297746C.10900@ammasso.com> <20050527192925.GA8250@infradead.org>
In-Reply-To: <20050527192925.GA8250@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> It will return the correct physical address for the start of the buffer.
> But given that vmalloc is a non-contingous allocator that's pretty useless.

So as long as the vmalloc'd memory fits inside one page, __pa() will always give the 
correct address?  If so, then can't I just call __pa() for every page in the buffer and 
get a list of physical addresses?  If I can do that, then how the memory be virtually 
contiguous but not physicall contiguous?

> As are physical addresses for anything but low-level architecture code.

I don't understand what that means.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13

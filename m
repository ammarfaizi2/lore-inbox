Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVEaTEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVEaTEA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVEaTD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:03:59 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:63673 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261203AbVEaTCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:02:14 -0400
Message-ID: <429CB429.8090008@ammasso.com>
Date: Tue, 31 May 2005 13:59:53 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Gerd Knorr <kraxel@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Will __pa(vmalloc()) ever work?
References: <4297746C.10900@ammasso.com> <873bs5yrxj.fsf@bytesex.org> <429C87FF.5070003@ammasso.com> <20050531161345.GB24106@bytesex>
In-Reply-To: <20050531161345.GB24106@bytesex>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:

> Can you fix that?  If so, try that.  Would be the best.

No, I cannot.  The memory is passed to my driver from some other driver that I do not
control.

> I think you can't.  What is "anywhere else"?  Does that include
> userspace addresses?

No, but it might include the stack.

> Not sure how portable that is, but comparing the vaddr against
> the vmalloc address space could work.  There are macros for
> that, VMALLOC_START & VMALLOC_END IIRC.

Thanks, I'll try that.

I still haven't gotten an answer to my question about whether pgd/pud/pmd/pte_offset will 
obtain the physical address for a kmalloc'd buffer.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13


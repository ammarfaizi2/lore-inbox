Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264601AbUEVAGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbUEVAGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264596AbUEVAE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:04:59 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:8121 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264997AbUEUXy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:54:59 -0400
Message-ID: <40ADB20C.8090204@yahoo.com.au>
Date: Fri, 21 May 2004 17:38:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: FabF <Fabian.Frederick@skynet.be>
CC: axboe@suse.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.6-mm4-ff1] I/O context isolation
References: <1085124268.8064.15.camel@bluerhyme.real3>
In-Reply-To: <1085124268.8064.15.camel@bluerhyme.real3>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF wrote:
> Jens,
> 
> 	Here's ff1 patchset to have generic I/O context.
> ff1 : Export io context operations from blkdev/ll_rw_blk (ok)
> ff2 : Make io_context generic plateform by importing IO stuff from
> as_io.
> 

Can I just ask why you want as_io_context in generic code?
It is currently nicely hidden away in as-iosched.c where
nobody else needs to ever see it.

> 	AFAICS, cfq_queue for instance could disappear when using io_context
> but I think elv_data should remain elevator side....
> I don't want to go in the wild here so if you've got suggestions, don't
> hesitate ;)
> 

cfq_queue is per-queue-per-process. io_context is just
per-process, so it isn't a trivial replacement.

Nick

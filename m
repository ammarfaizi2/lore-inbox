Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWCFSuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWCFSuB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWCFSuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:50:00 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:29086 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1752401AbWCFSuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:50:00 -0500
Message-ID: <440C8449.7020804@cs.wisc.edu>
Date: Mon, 06 Mar 2006 12:49:45 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
References: <200603060117.16484.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603060956570.13139@g5.osdl.org> <440C8405.60601@cs.wisc.edu>
In-Reply-To: <440C8405.60601@cs.wisc.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie wrote:
> Linus Torvalds wrote:
> 
>>
>> James, Mike, can you double-check the retries? In particular, it's 
>> _wrong_ to retry after you've already marked a command completed with 
>> "complete(rq->waiting)", so if that happens somewhere, things are 
>> really broken.
>>
> 
> I am looking into it. I think it has something to do with the request 
> getting completed too early or maybe something crazy like twice. This 
> looks like a similar problem that was reported to linux-scsi

Oh yeah here is that thread

http://marc.theaimsgroup.com/?l=linux-scsi&m=114127615918030&w=2

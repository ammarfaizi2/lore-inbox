Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264683AbUEaWra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264683AbUEaWra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbUEaWra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:47:30 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:31329 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264683AbUEaWr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:47:28 -0400
Message-ID: <40BBB5F7.1010407@yahoo.com.au>
Date: Tue, 01 Jun 2004 08:47:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Michael Brennan <mbrennan@ezrs.com>, linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <40BB88B5.8080300@ezrs.com> <200405312029.i4VKTCZ0000596@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200405312029.i4VKTCZ0000596@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> Hi,
> 
> Quote from Michael Brennan <mbrennan@ezrs.com>:
> 
>>Hi!
>>I've recently started to follow this list.
>>I read the swap discussion here, and I was wondering about what Nick 
>>Pigging said about grepping the kernel tree.
>>
>>Nick Piggin wrote:
>> > For example, I have 57MB swapped right now. It allows me to instantly
>> > grep the kernel tree. If I turned swap off, each grep would probably
>> > take 30 seconds.
>>
>>Are the pages swapped to disk as a result of the grep run?
> 

The pages are gradually swapped to disk as I use the system.
> 
> I'm not really sure what the above was intended to demonstrate, but I assume
> that it was that having swap allowed the first grep to fill physical RAM with
> cache at the expense of swapping other processes, which were using physical
> RAM to disk.
> 

Well, at the "expense" of paging out unused memory. I don't see
any swapin.

> However, if 57 Mb of swap allows this, 57 Mb of extra physical RAM should also
> also allow the grep to be cached, without having to swap out anything.
> 

Well yes, but if I had another 57MB of physical memory then I would
still turn on swap so that other 57MB of unused memory isn't wasted.

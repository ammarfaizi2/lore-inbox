Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbTILEb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 00:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTILEb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 00:31:56 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:22930 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261657AbTILEbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 00:31:55 -0400
Message-ID: <3F614C1F.6010802@nortelnetworks.com>
Date: Fri, 12 Sep 2003 00:31:27 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rahul Karnik <rahul@genebrew.com>
Cc: rusty@linux.co.intel.com, riel@conectiva.com.br, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Enabling other oom schemes
References: <200309120219.h8C2JANc004514@penguin.co.intel.com> <3F614912.3090801@genebrew.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Karnik wrote:
> Rusty Lynch wrote:
> 
>> The patch below uses a notifier list for other components to register
>> to be called when an out of memory condition occurs.
> 
> 
> How does this interact with the overcommit handling? Doesn't strict 
> overcommit also not oom, but rather return a memory allocation error? 
> Could we not add another overcommit mode where oom conditions cause a 
> kernel panic?

If you have real, true strict overcommit, then it can cause you to have 
errors much earlier than expected.

Imagine a process that consumes 51% of memory.  With strict overcommit, 
that process cannot fork() since there is not enough memory.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com


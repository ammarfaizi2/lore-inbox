Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUIPOJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUIPOJI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268082AbUIPOJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:09:08 -0400
Received: from sd291.sivit.org ([194.146.225.122]:52133 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S268083AbUIPOI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:08:57 -0400
Date: Thu, 16 Sep 2004 16:09:36 +0200
From: Stelian Pop <stelian@popies.net>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040916140936.GC3146@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Paul Jackson <pj@sgi.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040913135253.GA3118@crusoe.alcove-fr> <20040915153013.32e797c8.akpm@osdl.org> <20040916064320.GA9886@deep-space-9.dsnet> <20040916000438.46d91e94.akpm@osdl.org> <20040916104535.GA3146@crusoe.alcove-fr> <20040916065750.106fc170.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916065750.106fc170.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 06:57:50AM -0700, Paul Jackson wrote:

> This still has a 'size' attribute.  As Andrew noted,
> this might not be needed.

No, Andrew noted that 'len' was unneeded (although he talked about
'size', he really meant 'len' == the amount of data in the FIFO) (*)

> See for example:
> 
>   http://cse.stanford.edu/class/cs110/handouts/27Queues.pdf
> 
> for coding a fifo queue with just a put and get pointer.

... and a start and a end pointer. 

This is identical to my patch (minus the fact that 'start' is called
'buffer' in my patch and I have the 'size' field instead of an 'end'
pointer).
> 
> The queue is empty if put == get, and it is full if adding one more
> would make it empty.  The number of elements in the queue can be done
> using modulo arithmetic on the difference between put and get (or what
> the above *.pdf file and your code calls head and tail), with no
> distinct 'size' element.   The head and tail wrap.

Did you read my second patch ?

Stelian.
-- 
Stelian Pop <stelian@popies.net>    

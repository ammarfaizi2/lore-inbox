Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264121AbTE0UaR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264122AbTE0UaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:30:17 -0400
Received: from adsl-67-122-203-155.dsl.snfc21.pacbell.net ([67.122.203.155]:13771
	"EHLO ext.storadinc.com") by vger.kernel.org with ESMTP
	id S264121AbTE0UaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:30:10 -0400
Message-ID: <3ED3CDB8.3000500@storadinc.com>
Date: Tue, 27 May 2003 13:42:32 -0700
From: manish <manish@storadinc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
CC: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
References: <3ED2DE86.2070406@storadinc.com> <3ED3BDCE.4010200@storadinc.com> <20030527202047.GM3767@dualathlon.random> <200305272225.27720.m.c.p@wolk-project.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:

>On Tuesday 27 May 2003 22:20, Andrea Arcangeli wrote:
>
>Hi Andrea,
>
>
>>>1. Stock 2.4.20
>>>2. 2.4.20 with the io_request_lock removed.
>>>The tests on the first one are still going. The tests on the second one
>>>showed processes getting stuck for long times (> 5 minutes) and not
>>>paused ...
>>>
>>sorry if it's a dumb question but what is the "io_request_lock removed"
>>thing? Hope you didn't delete any io_request_lock, if you did you can
>>get worse things than crashes (i.e. mm/fs corruption). the pausing bug
>>was a genuine race (quite innocent, if you could trigger a disk unplug
>>you could recover from it)
>>
>>Andrea
>>
>funny. I asked him the same ;)
>
>see his response:
>
>-----------------------------------------------------------------------
>
>>what is this io_request_lock patch you are talking about?
>>
>>ciao, Marc
>>
>We made some changes to the 2.4.20 kernel to remove the io_request_lock 
>and replace with queue_lock and host_lock.
>-----------------------------------------------------------------------
>
>ciao, Marc
>
We made a change in the 2.4.20 kernel to remove the io_request_lock and 
replace with the host_lock and the queue_lock.  Probably, not a right 
thing to do

Thanks
Manish




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262879AbSJOTDc>; Tue, 15 Oct 2002 15:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSJOTDc>; Tue, 15 Oct 2002 15:03:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:18565 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262879AbSJOTD1>; Tue, 15 Oct 2002 15:03:27 -0400
Message-ID: <3DAC65A1.1040303@watson.ibm.com>
Date: Tue, 15 Oct 2002 14:59:45 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <3DAC5C11.4060507@watson.ibm.com> <Pine.LNX.4.44.0210151156420.1554-100000@blue1.dev.mcafeelabs.com> <20021015150201.K14596@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Tue, Oct 15, 2002 at 12:00:30PM -0700, Davide Libenzi wrote:
> 
>>Something like this might work :
>>
>>int sys_epoll_create(int maxfds);
>>void sys_epoll_close(int epd);
>>int sys_epoll_wait(int epd, struct pollfd **pevts, int timeout);
>>
>>where sys_epoll_wait() return the number of events available, 0 for
>>timeout, -1 for error.
> 
> 
> There's no reason to make epoll_wait a new syscall -- poll events can 
> easily be returned via the aio_complete mechanism (with the existing 
> aio_poll experiment as a possible means for doing so).


So a user would setup an ioctx  and use io_getevents to retrieve events on
an interest set of fds created and manipulated through the new system calls ?

-- Shailabh


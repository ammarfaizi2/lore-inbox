Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261549AbSJ1WSs>; Mon, 28 Oct 2002 17:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbSJ1WSQ>; Mon, 28 Oct 2002 17:18:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:21214 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261352AbSJ1WRp>; Mon, 28 Oct 2002 17:17:45 -0500
Message-ID: <3DBDB664.7050808@watson.ibm.com>
Date: Mon, 28 Oct 2002 17:12:52 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       davidel@xmailserver.org, linux-aio@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH] epoll more scalable than poll
References: <53100000.1035832459@w-hlinder> <20021028220809.GB27798@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bert hubert wrote:
> On Mon, Oct 28, 2002 at 11:14:19AM -0800, Hanna Linder wrote:
> 
> 
>>	The results of our testing show not only does the system call 
>>interface to epoll perform as well as the /dev interface but also that epoll 
>>is many times better than standard poll. No other implementations of poll 
> 
> 
> Hanna,
> 
> Sure that this works? The following trivial program doesn't work on stdinput
> when I'd expect it to. It just waits until the timeout passes end then
> returns 0. It also does not work on a file, which is to be expected,
> although 'select' returns with an immediate availability of data on a file
> according to SuS.

I'm checking this and will let you know.


> Furthermore, there is some const weirdness going on, the ephttpd server has
> a different second argument to sys_epoll_wait.

You're right. The ephttpd server on Davide's page needs to add a cast
(struct pollfd const **) to the second arg passed to sys_epoll_wait.
The version of dphttpd used to generate the results had that fix in it.



-- Shailabh



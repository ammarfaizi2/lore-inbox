Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267444AbTAWXWZ>; Thu, 23 Jan 2003 18:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267451AbTAWXWZ>; Thu, 23 Jan 2003 18:22:25 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:39563 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S267444AbTAWXWS>;
	Thu, 23 Jan 2003 18:22:18 -0500
Message-ID: <3E307B49.9080304@candelatech.com>
Date: Thu, 23 Jan 2003 15:31:21 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Chin <leechin@mail.com>
CC: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Subject: Re: debate on 700 threads vs asynchronous code
References: <20030123231913.26663.qmail@mail.com>
In-Reply-To: <20030123231913.26663.qmail@mail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Chin wrote:
> Hi
> I am discussing with a few people on different approaches to solving a scale problem I am having, and have gotten vastly different views
> 
> In a nutshell, as far as this debate is concerned, I can say I am writing a web server.
> 
> Now, to cater to 700 clients, I can
> a) launch 700 threads that each block on I/O to disk and to the client (in reading and writing on the socket)
> 
> OR
> 
> b) Write an asycnhrounous system with only 2 or three threads where I manage the connections and stack (via setcontext swapcontext etc), which is progromatically a little harder

You could also write something with async non-blocking IO and use NO threads
(ie, just a single process), which
may greatly simplify the debugging of your program (unless the developer(s) on your
project are very good at threaded programming already).

I suspect the async IO will perform better as well, but that is just an
un-founded opinion based on not wanting to think about scheduling 700 processes
that want to do IO :)

> 
> Which way will yeild me better performance, considerng both approaches are implemented optimally?
> 
> Thanks
> Lee


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbSKSBii>; Mon, 18 Nov 2002 20:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265092AbSKSBii>; Mon, 18 Nov 2002 20:38:38 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:8340 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S265085AbSKSBih>; Mon, 18 Nov 2002 20:38:37 -0500
Message-ID: <3DD99D33.1030900@kegel.com>
Date: Mon, 18 Nov 2002 18:08:51 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
References: <Pine.LNX.4.44.0211181733070.979-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Mon, 18 Nov 2002, Dan Kegel wrote:
>>Second, epoll_ctl(2) doesn't define the meaning of the
>>event mask.  It should give the allowed bits and define
>>their meanings.  If we use the traditional POLLIN etc, we
>>can say
>>   POLLIN - the fd has become ready for reading
>>   POLLOUT - the fd has become ready for writing
>>   Note: If epoll tells you e.g. POLLIN, it means that
>>            poll will tell you the same thing,
>>            since poll gives the current status,
>>            and epoll gives changes in status.
> 
> 
> I will have to change man pages also to fit EPOLL* definitions.

IMHO changing from using POLLIN etc. to EPOLLIN
will obscure the essential relationship between
epoll and poll (namely, that the epoll bits
are the time derivative of the poll bits).

I would prefer to continue using POLLIN, etc.
- Dan



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265427AbSJSAt2>; Fri, 18 Oct 2002 20:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265430AbSJSAt2>; Fri, 18 Oct 2002 20:49:28 -0400
Received: from r2d2.aoltw.net ([64.236.137.26]:50867 "EHLO netscape.com")
	by vger.kernel.org with ESMTP id <S265427AbSJSAt1>;
	Fri, 18 Oct 2002 20:49:27 -0400
Message-ID: <3DB0AD79.30401@netscape.com>
Date: Fri, 18 Oct 2002 17:55:21 -0700
From: jgmyers@netscape.com (John Myers)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <Pine.LNX.4.44.0210181241300.1537-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.44.0210181241300.1537-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>No, the concept of edge triggered APIs is that you have to use the fd
>until EAGAIN.
>
Which my code does, given the postulate.

>It's a very simple concept. That means that after a
>connect()/accept() you have to start using the fd because I/O space might
>be available for read()/write(). Dropping an event is an attempt of using
>the API like poll() & Co., where after an fd born, it is put inside the
>set to be later wake up. You're basically saying "the kernel should drop an
>event at creation time" and I'm saying that, to keep the API usage
>consistent to "use the fd until EAGAIN", you have to use the fd as soon as
>it'll become available.
>
Here's where your argument is inconsistent with the Linux philosophy.

Linux has a strong philosophy of practicality.  The goal of Linux is to 
do useful things, including provide applications with the semantics they 
need to do useful things.  The criteria for deciding what goes into 
Linux is heavily weighted towards what works best in practice.

Whether or not some API matches someone's Platonic ideal of of an OS 
interface is not a criterion.  In Linux, APIs are judged by their 
practical merits.  This is why Linux does not have such things as 
message passing and separate address spaces for drivers.

So whether or not a proposed set of epoll semantics is consistent with 
your Platonic ideal of "use the fd until EAGAIN" is simply not an issue. 
 What matters is what works best in practice.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbVLGP47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVLGP47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVLGP4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:56:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64715 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751166AbVLGP4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:56:54 -0500
Message-ID: <4397063A.2030200@redhat.com>
Date: Wed, 07 Dec 2005 10:56:42 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: another nfs puzzle
References: <20051206220448.82860.qmail@web34109.mail.mud.yahoo.com>	 <4396EB2F.3060404@redhat.com>	 <1133964667.27373.13.camel@lade.trondhjem.org> <4396EF50.30201@redhat.com>	 <1133966063.27373.29.camel@lade.trondhjem.org>	 <4397011E.9010703@redhat.com> <1133970117.27373.53.camel@lade.trondhjem.org>
In-Reply-To: <1133970117.27373.53.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>On Wed, 2005-12-07 at 10:34 -0500, Peter Staubach wrote:
>
>  
>
>>This seems like a dangerous enough area that denying mmap on a file which
>>has been opened with O_DIRECT by any process and denying open(O_DIRECT)
>>on a file which has been mmap'd would be a good thing.  These things are
>>easy enough to keep track of, so it shouldn't be too hard to implement.
>>    
>>
>
>That would be a recipe for DOSes as it would allow one process to block
>another just by opening a file. I'd really not like to see my database
>crash just because some obscure monitoring program happens to use mmap()
>to browse the file.
>

I wouldn't think that a database would be a problem since it is opened early
and then stays open.  However, point granted.  There are tools around, lsof
and such, which would be handy for diagnosing such a situation though.

I do know of other operating systems which do implement the semantics that I
have suggested and I don't think that they are concerned or have been 
notified
that these semantics for a problem.  These semantics are used because the
kernel itself can not even guarantee that the data that it is caching is 
valid,
without lots of synchronization which may tend to reduce performance.

    Thanx...

       ps

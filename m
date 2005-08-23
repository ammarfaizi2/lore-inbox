Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVHWRoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVHWRoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 13:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVHWRoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 13:44:19 -0400
Received: from intranet.networkstreaming.com ([24.227.179.66]:25429 "EHLO
	networkstreaming.com") by vger.kernel.org with ESMTP
	id S932250AbVHWRoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 13:44:18 -0400
Message-ID: <430AF11A.5000303@davyandbeth.com>
Date: Tue, 23 Aug 2005 04:49:14 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bert hubert <bert.hubert@netherlabs.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: select() efficiency / epoll
References: <42E162B6.2000602@davyandbeth.com> <20050722212454.GB18988@outpost.ds9a.nl>
In-Reply-To: <20050722212454.GB18988@outpost.ds9a.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Aug 2005 17:43:52.0156 (UTC) FILETIME=[39BA09C0:01C5A80A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, I've been trying to use epoll.. on linux-2.6.11-6mdk


However, I'm getting segfaults because some pointers in places are 
getting set to low integer values (which didn't used to have those values).

The deal is that my application is multi-threaded, and I was wondering 
if epoll had issues if you use epoll_ctl while an epoll_wait is waiting 
or something like that.  I'm also compiling with -D_MULTI_THREADED.  I'm 
not new to threading, but am stumped at this point.

I'm not ruling out it being my code, but wanted to ask about epoll since 
it's so new.

Any ideas?

Thanks,
  Davy


bert hubert wrote:

>On Fri, Jul 22, 2005 at 04:18:46PM -0500, Davy Durham wrote:
>  
>
>>Please forgive and redirect me if this is not the right place to ask 
>>this question:
>>
>>I'm looking to write a sort of messaging system that would take input 
>>from any number of entities that "register" with it.. it would then 
>>route the messages to outputs and so forth..
>>    
>>
>
>Look at epoll, or libevent, which uses epoll to be quick in this scenario.
>
>
>  
>


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268215AbUH0Ici@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268215AbUH0Ici (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUH0I2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:28:09 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:43978 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S269020AbUH0IZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:25:23 -0400
Message-ID: <412EEFF1.9080409@dgreaves.com>
Date: Fri, 27 Aug 2004 09:25:21 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: POSIX_FADV_NOREUSE and O_STREAMING behavior in 2.6.7
References: <412E2058.60302@rtlogic.com>  <412E2E0D.8040401@dgreaves.com> <1093547459.6106.57.camel@lade.trondhjem.org>
In-Reply-To: <1093547459.6106.57.camel@lade.trondhjem.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>På to , 26/08/2004 klokka 14:38, skreiv David Greaves:
>  
>
>>David Rolenc wrote:
>>
>>    
>>
>>>I am trying to get O_STREAMING (Robert Love patch for 2.4) behavior in 
>>>2.6 and just a glance at fadvise.c suggests that POSIX_FADV_NOREUSE is 
>>>not implemented any differently than POSIX_FADV_WILLNEED. Am I missing 
>>>something?  I want to read data from disk with readahead and drop the 
>>>data from the page cache as soon as I am done with it. Do I have to 
>>>call fadvise with POSIX_FADV_DONTNEED after every read?
>>>      
>>>
>>And will this work over nfs?
>>    
>>
>
>What do you mean?
>
>The client will of course respect fadvise() if the generic VM code
>supports it, but there is no NFS protocol support for this, so the
>client is not able to communicate your fadvise call on to the server.
>  
>
Perfect answer
thank you

I want my nfs client to communicate this to my nfs server. Thus avoiding 
my nfs server having a cache of useless video.
I can see this becoming an important benefit for video distribution (an 
area linux is likely to see more of)

David


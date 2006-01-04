Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWADOQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWADOQT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 09:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWADOQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 09:16:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24981 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932066AbWADOQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 09:16:18 -0500
Message-ID: <43BBD8AA.2010906@redhat.com>
Date: Wed, 04 Jan 2006 09:16:10 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Matthew Wilcox <matthew@wil.cx>, ASANO Masahiro <masano@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix posix lock on NFS
References: <20051222.132454.1025208517.masano@tnes.nec.co.jp>	 <43BAD2EC.2030807@redhat.com> <20060103194630.GL19769@parisc-linux.org>	 <43BAD9DF.4090401@redhat.com> <1136337847.7846.50.camel@lade.trondhjem.org>
In-Reply-To: <1136337847.7846.50.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>On Tue, 2006-01-03 at 15:09 -0500, Peter Staubach wrote:
>  
>
>>Matthew Wilcox wrote:
>>    
>>
>>>Mandatory locks aren't mandatory for other clients.
>>> 
>>>
>>>      
>>>
>>So?
>>
>>I guess that I don't understand this response.
>>
>>The server is responsible for keeping itself from attempting to access
>>a mandatory lock file.  The client is not responsible for doing so and
>>trying to help the server is kind of a waste of time, mostly.
>>
>>The mandatory lock mode bits really only come into play when attempting
>>to read or write the file.  In this case, the system will automatically
>>try to take a lock for the process, if that process does not already
>>have a lock.  The server should prevent itself from trying to access
>>files like this in order to avoid DoS attacks.
>>
>>The NFS client does not support mandatory locking, mostly due to the
>>possibility of DoS attacks and also due to the locking and NFS protocols
>>not being sufficiently aware of each other.  NFSv4 can be used to address
>>this latter problem, but probably not the former.
>>
>>So, why deny lock requests for such files?  Especially on the client?
>>    
>>
>
>I agree, however that would have been a change in behaviour that would
>have been hard to find time to test properly in an -rc6(?) release, so
>we went for the quick and dirty fix.
>

Okay.

Are we going to be able to fix this properly once things open up a bit then?

    Thanx...

       ps

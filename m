Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVLQHzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVLQHzU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 02:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVLQHzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 02:55:20 -0500
Received: from smtp109.plus.mail.mud.yahoo.com ([68.142.206.242]:54925 "HELO
	smtp109.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932174AbVLQHzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 02:55:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=G4AenE+lRDdJwe56agk3Z8FXwwtwQ9M9qrYmjDTFKYI8eMtSCa0xiSka0vGlwZhm2pAc+N7YAz1RGLH6hoCk/HkYvGOLPO/4G9yGvdxNBoqa0TRErZl1YMDCPbd0Yt3cD/Ppr7DOQtWeHAdWgdJCXlHaw1pDXmLn+Y/qeBMt1sg=  ;
Message-ID: <43A3C461.2030900@yahoo.com.au>
Date: Sat, 17 Dec 2005 18:55:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
References: <dhowells1134774786@warthog.cambridge.redhat.com>	 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com> <1134791914.13138.167.camel@localhost.localdomain>
In-Reply-To: <1134791914.13138.167.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Fri, 2005-12-16 at 23:13 +0000, David Howells wrote:

>>This patch set does the following:
>>
>> (1) Renames DECLARE_MUTEX and DECLARE_MUTEX_LOCKED to be DECLARE_SEM_MUTEX and
>>     DECLARE_SEM_MUTEX_LOCKED for counting semaphores.
>>
> 
> 
> Could we really get rid of that "MUTEX" part.  A counting semaphore is
> _not_ a mutex, although a mutex _is_ a counting semaphore.  As is a Jack
> Russell is a dog, but a dog is not a Jack Russell.
> 

Really?

A Jack Russell is a dog because anything you say about a dog can
also be said about a Jack Russell.

A counting semaphore is a mutex for the same reason (and observe
that 99% of users use the semaphore as a mutex). A mutex definitely
is not a counting semaphore. David's implementation of mutexes
don't count at all.

If you want to use a semaphore as a mutex, DECLARE_SEM_MUTEX isn't
a terrible name.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

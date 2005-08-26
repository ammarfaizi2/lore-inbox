Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbVHZB0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbVHZB0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 21:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVHZB0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 21:26:31 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:23409 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965033AbVHZB0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 21:26:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=pqAVmxGdGbLN88I2k1d+Avs0cWYu+mpAZu9AyZg/0q4yr+GQOfNM7OJnzBDksSDnv25kA92gyj/QbE+RohJfpzHuN+ie1vRHzFPhjdtVJfmM6q0LNi7C4VZUh8s0VHxmw2GvChNorvhQVJkwxB8aiE/wCP6FqojYkuSQqnG4lBI=  ;
Message-ID: <430E6FD4.9060102@yahoo.com.au>
Date: Fri, 26 Aug 2005 11:26:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>
CC: Ray Fucillo <fucillo@intersystems.com>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: process creation time increases linearly with shmem
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au> <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Thu, 25 Aug 2005, Nick Piggin wrote:
> 
> 
>>fork() can be changed so as not to set up page tables for
>>MAP_SHARED mappings. I think that has other tradeoffs like
>>initially causing several unavoidable faults reading
>>libraries and program text.
> 
> 
> Actually, libraries and program text are usually mapped
> MAP_PRIVATE, so those would still be copied.
> 

Yep, that seems to be the case here.

> Skipping MAP_SHARED in fork() sounds like a good idea to me...
> 

Indeed. Linus, can you remember why we haven't done this before?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

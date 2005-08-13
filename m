Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVHMA4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVHMA4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 20:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbVHMA4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 20:56:48 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:41868 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932070AbVHMA4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 20:56:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=0YwjAV/22rmPBy+ME8MwEm7/To2SBcV6y180b+PPxCWzVc67VscQpUVi7ZvLy5M222FqJOtGfok4hslpudQFJrIAkdgzxnwYa3x75pNmDLmifA5gX1prVPsMLZudUsJJjZYOIXKxYnAE2JOrirDAhzbWoDDDvNbi6eZ/jq7cVXQ=  ;
Message-ID: <42FD4548.3060204@yahoo.com.au>
Date: Sat, 13 Aug 2005 10:56:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: george@mvista.com
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] eliminte NMI entry/ exit code
References: <42FD42C1.6040009@mvista.com>
In-Reply-To: <42FD42C1.6040009@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> The NMI entry and exit code fiddles with bits in the preempt count.  If 
> an NMI happens while some other code is doing the same, bits will be 
> lost.  This patch removes this modify code from the NMI path till we can 
> come up with something better.
> 

Humour me for a minute here...
NMI restores preempt_count back to its old value upon exit, right?
So what does a race case look like?

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

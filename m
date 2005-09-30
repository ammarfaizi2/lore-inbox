Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbVI3Ptn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbVI3Ptn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbVI3Ptn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:49:43 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:23457 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030343AbVI3Ptm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:49:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=urrL5KSS3WOFB3F5bJqfIJGNG3jHq+KBdQG9VWy1WGO2N3UrUVj1MgRCe9rCJpx7bbcr4slmQY4LHqEpF2hLRZfVb91guycgkv0rLp3jrAtU+qXLO7zQL4qTVvfPheCOMtVwzZknRc/YCre4QcP3FuYNcHxiiNH/P6ZzrDdRbKk=  ;
Message-ID: <433D56DE.5030803@yahoo.com.au>
Date: Sat, 01 Oct 2005 01:16:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386 include linux/irq.h rather than asm/hw_irq.h
References: <433D5305.1030209@yahoo.com.au>
In-Reply-To: <433D5305.1030209@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Hi,
> 
> I need the following patch to compile -git8 here, otherwise these
> files fail to compile (asm/hw_irq.h needs definitions from
> linux/irq.h and that file provides the required include ordering).
> 

Note that I didn't do an audit for this, but merely got my system
compiling and booting.

Looks like quite a few other places that directly include hw_irq.h
should also be converted, if this is indeed the right way to do it.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

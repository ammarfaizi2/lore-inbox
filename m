Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbWD1IPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWD1IPl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 04:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWD1IPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 04:15:41 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:40569 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030315AbWD1IPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 04:15:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Rxq41u7/Dm6xUBPWfayUwBHuxtP4Mk8rBuNSHQJHSnoCO++fkWaz7fxZoGO8Yw7C08Bncyn6jQycht+Go3eNUgZyoQkHNH7st9ppUSJRiSzWVfpht+t5n7oxA41OCKd89F5HbV46XLniUHof6kSWZLzmbIlyJLDNpDthelC+6Ms=  ;
Message-ID: <4451CA41.5070101@yahoo.com.au>
Date: Fri, 28 Apr 2006 17:54:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Magnus Damm <magnus.damm@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: i386 and PAE: pud_present()
References: <aec7e5c30604280040p60cc7c7dqc6fb6fbdd9506a6b@mail.gmail.com>
In-Reply-To: <aec7e5c30604280040p60cc7c7dqc6fb6fbdd9506a6b@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm wrote:
> Hi guys,
> 
> In file include/asm-i386/pgtable-3level.h:
> 
> On i386 with PAE enabled, shouldn't pud_present() return (pud_val(pud)
> & _PAGE_PRESENT) instead of constant 1?
> 
> Today pud_present() returns constant 1 regardless of PAE or not. This
> looks wrong to me, but maybe I'm misunderstanding how to fold the page
> tables... =)

Take a look a little further down the page for the comment.

In i386 + PAE, pud is always present.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

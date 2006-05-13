Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWEMBhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWEMBhy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 21:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWEMBhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 21:37:54 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:28831 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751316AbWEMBhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 21:37:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Z3CDtsPWhXAKwFf7xmHyh/lOoPps/E7ysSQi83ZFIA6+FFgvlUW9IDBMb24sQNLSr4hfkn3Dm3qCe0OSGbzc2vhhu3paI/NhQhaGB4ZZz73YFmDZNPrm/GGNQ8E0qLOVSJtBiHaNcdmc6QV5btCV/Alllb+JKUaR4quDD6p2QiM=  ;
Message-ID: <4465386B.9090804@yahoo.com.au>
Date: Sat, 13 May 2006 11:37:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Steven Rostedt <rostedt@goodmis.org>, akpm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Silly bitmap size accounting fix
References: <Pine.LNX.4.58.0605120403540.28581@gandalf.stny.rr.com> <20060512091451.GA18145@elte.hu>
In-Reply-To: <20060512091451.GA18145@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> 
>>-#define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
>>+#define BITMAP_SIZE ((((MAX_PRIO+7)/8)+sizeof(long)-1)/sizeof(long))
> 
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

Really?! What about the delimiter bit set at MAX_PRIO?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

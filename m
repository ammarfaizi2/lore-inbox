Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUHVF3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUHVF3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 01:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUHVF3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 01:29:51 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:25214 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266188AbUHVF3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 01:29:50 -0400
Message-ID: <41282E94.4020903@yahoo.com.au>
Date: Sun, 22 Aug 2004 15:26:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Ryan Cumming <ryan@spitfire.gotdns.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] use hlist for pid hash
References: <412824BE.4040801@yahoo.com.au> <4128252E.1080002@yahoo.com.au> <200408212225.58536.ryan@spitfire.gotdns.org>
In-Reply-To: <200408212225.58536.ryan@spitfire.gotdns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Cumming wrote:
> On Saturday 21 August 2004 21:46, you wrote:
> 
>>This comes at the "expense" of
>>1. reintroducing the memory  prefetch into the hash traversal loop;
>>2. adding new pids to the head of the list instead of the tail. I
>>   suspect that if this was a big problem then the hash isn't sized
>>   well or could benefit from moving hot entries to the head.
> 
> 
> It looks like the current code is already adding PIDs to the head: list_add() 
> adds to the head of a list and list_add_tail() adds to the tail.
> 

Hmm, so it is. I must have been looking at the task_list list when I
was thinking that. Well, all the better.

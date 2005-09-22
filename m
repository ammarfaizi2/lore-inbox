Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbVIVD16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVIVD16 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 23:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbVIVD15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 23:27:57 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:39348 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030201AbVIVD15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 23:27:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vvUft79TI15bnompUBCiAkCqvmz0PryDbOaKnZ2U3EPUwCSIx2xwxlT8eO0hAkoDlx6zQiSNEc1MninczCfpRUliqETcaO8sZnEiFl4XZB4shlV3YumuFYquFr4nwL1mWSxJlWZJyMZTXC95ZdyhBmtYlwzS/SHqk0PlWvzqPxc=  ;
Message-ID: <433224BC.1000904@yahoo.com.au>
Date: Thu, 22 Sep 2005 13:27:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: Checks for cmpxchg in get_task_struct_rcu()
References: <1127345874.19506.43.camel@dhcp153.mvista.com>	 <433201FC.8040004@yahoo.com.au> <1127355538.8950.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
In-Reply-To: <1127355538.8950.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Thu, 2005-09-22 at 10:59 +1000, Nick Piggin wrote:
> 
> 
>>You need my atomic_cmpxchg patches that provide an atomic_cmpxchg
>>(and atomic_inc_not_zero) for all architectures.
>>
> 
> 
> It is racy, but why not just disable preemption ..
> 

Well you haven't, that's the point. You *introduce* racy operation.

Anyway, no matter, atomic_cmpxchg will take care of this nicely.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

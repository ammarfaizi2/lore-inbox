Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWCPPOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWCPPOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWCPPOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:14:11 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:27282 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751320AbWCPPOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:14:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=LDDv+kM6xLTh3xaPZhNl0xWwE7djPt3j26aPFAq4FBqKaX6V2vFlBFpzsXwzK78MKBundtcJHx4/IEkRPfCOrHLOiIb+sxeJoTIeK/0ONU+SZ1zPsggQ9E1AmaaWuAv9LiLfSLV3toVe34QNeQLsHzHYVtnRz9deqGKmbW2Quj4=  ;
Message-ID: <44193826.8010701@yahoo.com.au>
Date: Thu, 16 Mar 2006 21:04:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_possible_cpu [1/19] defines for_each_possible_cpu
References: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>	<4418DEEA.2000008@yahoo.com.au>	<20060316131743.d7b716e9.kamezawa.hiroyu@jp.fujitsu.com>	<4418E879.3000207@yahoo.com.au>	<20060316152206.7ac3bdb4.kamezawa.hiroyu@jp.fujitsu.com>	<44190A7C.6030901@yahoo.com.au> <20060316014820.51dbb3b8.akpm@osdl.org>
In-Reply-To: <20060316014820.51dbb3b8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>for_each_cpu has always meant for
>> each possible CPU.
> 
> 
> That was the most long-winded ack I've ever seen ;)
> 

Is not! :). This is the very reason why I think it is pointless churn.
There are plenty of functions (even static, confined to a single file,
or ones much more complex than this) which could unquestionably have
their names changed for the better.

This change doesn't even add anything except a redundant element so
it is even questionable that it makes the name better at all.

But I know you've got your heart set on them now so I won't continue
with the impossible task of talking you out of them ;) Just don't
expect that people will suddenly start getting hotplug-cpu races
right, overnight.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

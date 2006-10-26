Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423163AbWJZMTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423163AbWJZMTd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423241AbWJZMTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:19:33 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:5780 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423163AbWJZMTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:19:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=X229JFAVDqtb0vR/TJIkiLq1syyaga0a/gYqwzFUbWTE4Fwc7peKrfd6DcOrYa+f77p2xYOugxl6qR7F11NbnQ+KsBEYH0BtqJ+11UwFUR6RrY7pJsa+yv/7+PYbLbxFYDbtqQPi3l2yp2pZnCeU37HZGZy/2dcGTIUvaNa4hiw=  ;
Message-ID: <4540A7CE.6060407@yahoo.com.au>
Date: Thu, 26 Oct 2006 22:19:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 4/5] Create rebalance_domains from rebalance_tick
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com> <20061024183124.4530.92230.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061024183124.4530.92230.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Create rebalance_domains() from rebalance_tick().
> 
> Essentially rebalance_domains = rebalance_tick. However, we
> do the idle calculation on our own. This removes some processing
> from scheduler_tick into rebalance_domains().
> 
> While we are at it: Take the opportunity to avoid taking
> the request queue lock in wake_priority_sleeper if
> there are no running processes.

Can you split this out? It is good without the tasklet based
rebalancing.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751926AbWITQ4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbWITQ4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbWITQ4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:56:17 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:50362 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751926AbWITQ4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:56:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XzykB28lrUgMwYPESA0LbgepnCsjahVCr80WXgawUaNGy4F1/awwh3bHbGReQ32TwGo1VVDke7IK4FDpd73/azne5EruUgISXrG4SfRFSYhzpU2U7EQZuwv6CjEH9UpTbZd8M60gIacQxk9r4TBNyZORnzvqMxBAmD4JompGOak=  ;
Message-ID: <451172AB.2070103@yahoo.com.au>
Date: Thu, 21 Sep 2006 02:56:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: rohitseth@google.com, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       devel@openvz.org, linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
References: <1158718568.29000.44.camel@galaxy.corp.google.com> <4510D3F4.1040009@yahoo.com.au> <Pine.LNX.4.64.0609200925280.30572@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609200925280.30572@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 20 Sep 2006, Nick Piggin wrote:
> 
> 
>>I'm not sure about containers & workload management people, but from
>>a core mm/ perspective I see no reason why this couldn't get in,
>>given review and testing. Great!
> 
> 
> Nack. We already have the ability to manage workloads. We may want to 
> extend the existing functionality but this is duplicating what is already 
> available through cpusets.

If it wasn't clear was talking specifically about the hooks for page
tracking rather than the whole patchset. If anybody wants such page
tracking infrastructure in the kernel, then this (as opposed to the
huge beancounters stuff) is what it should look like.

But as I said above, I don't know what the containers and workload
management people want exactly... The recent discussions about using
nodes and cpusets for memory workload management does seem like a
promising idea, and if it would avoid the need for this kind of
per-page tracking entirely, then that would probably be even better.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

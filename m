Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWGDQ6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWGDQ6W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWGDQ6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:58:22 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:63390 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932282AbWGDQ6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:58:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=U1AQ0jAedP2kmL06qcduPWpC8jwYanllfM5gjIYbCFd2lZQwS5Qeowkg+Y7cbPAiTFth+hoT9LuhbnfvZGn/xxSEpzf2HZdD8gwZVwZVmNXwlNV/PjmZ3qzf88+dXP5DUsc3EGX/xDWN5XjTYHpR8CJ6E31QUYmkgmg1f6hEoyM=  ;
Message-ID: <44AA9C58.2010707@yahoo.com.au>
Date: Wed, 05 Jul 2006 02:50:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, kamezawa.hiroyu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, hugh@veritas.com, kernel@kolivas.org,
       marcelo@kvack.org, ak@suse.de
Subject: Re: [RFC 3/8] Move HIGHMEM counter into highmem.c/.h
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com> <20060703215550.7566.79975.sendpatchset@schroedinger.engr.sgi.com> <20060704144724.65c43a38.kamezawa.hiroyu@jp.fujitsu.com> <Pine.LNX.4.64.0607032253040.10856@schroedinger.engr.sgi.com> <20060703232020.260446d9.akpm@osdl.org> <Pine.LNX.4.64.0607040819230.13534@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607040819230.13534@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Mon, 3 Jul 2006, Andrew Morton wrote:
> 
> 
>>>Ok. Will put a #ifdef CONFIG_HIGHMEM around that statement and the 
>>>following one.
>>
>>That will take the patchset up to 27 new ifdefs.  Is there a way of improving
>>that?
> 
> 
> Ideas are welcome. I can put some of the tests for zones together into one
> big #ifdef in mmzone.h but otherwise this is going to be difficult.

I don't think there's much point. They all look pretty straightforward,
and if you try doing something fancy it might just make it more fragile
or harder to read.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

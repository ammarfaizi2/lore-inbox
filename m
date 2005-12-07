Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbVLGW7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbVLGW7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbVLGW7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:59:45 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:7871 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030434AbVLGW7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:59:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=0P1I3/xF+NIPmVOFfhj2SYZvRKziCqH4UtixE/FBLktc+B1mKAsm85i9aJ6QUKhfIv0z18+uyYrEJIyv+HHCYHFjrpI45e7MUf/FVpcVnNPool2mBlWhKFFeuQjPlqiY9pxYCiS0gvZWfmeUfEOEHiOoQ1wd14mxUUwsz/pSvE4=  ;
Message-ID: <43976949.8010205@yahoo.com.au>
Date: Thu, 08 Dec 2005 09:59:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/3] Framework for accurate node based statistics
References: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com> <439619F9.4030905@yahoo.com.au> <Pine.LNX.4.62.0512061536001.20580@schroedinger.engr.sgi.com> <439684C0.9090107@yahoo.com.au> <Pine.LNX.4.62.0512071026360.24516@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0512071026360.24516@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 7 Dec 2005, Nick Piggin wrote:
> 
> 
>>Sorry, I think I meant: why don't you just use the "add all counters
>>from all per-cpu of the node" in order to find the node-statistic?
> 
> 
> which function is that?
> 

I'm thinking of get_page_state_node... but that's not quite the same
thing. I guess sum all per-CPU counters from all zones in the node,
but that's going to be costly on big machines.

So I'm not sure, I guess I don't have any bright ideas... there is the
batching approach used by current pagecache_acct - is something like
that not sufficient either?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

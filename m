Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWCaFoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWCaFoi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 00:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWCaFoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 00:44:38 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:63933 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750853AbWCaFoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 00:44:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=AZl4VS6t1MYuI5tgx2iTdon0YOLbTOsNUCHReUAxujDZYAVeQ6WXJQ7ULhUe8u05BaOp1C0DWHvTB9vw2P5d7Qm/lR29Tuu79QXf80g0QsL0FYjxDW8dTzBD+gJ59CxuwsYjLv4DiRnZ+ZBiOkcdSZ4e3cU2zNUxwjfQfBudki8=  ;
Message-ID: <442C99A1.6060901@yahoo.com.au>
Date: Fri, 31 Mar 2006 12:53:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Christoph Lameter'" <clameter@sgi.com>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
References: <200603310244.k2V2iQg28203@unix-os.sc.intel.com>
In-Reply-To: <200603310244.k2V2iQg28203@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Christoph Lameter wrote on Thursday, March 30, 2006 6:38 PM
> 
>>>>Neither one is correct because there will always be one combination of 
>>>>clear_bit with these macros that does not generate the required memory 
>>>>barrier.
>>>
>>>Can you give an example?  Which combination?
>>
>>For Option(1)
>>
>>smp_mb__before_clear_bit()
>>clear_bit(...)(
> 
> 
> Sorry, you totally lost me.  It could me I'm extremely slow today.  For
> option (1), on ia64, clear_bit has release semantic already.  The comb
> of __before_clear_bit + clear_bit provides the required ordering.  Did
> I miss something?  By the way, we are talking about detail implementation
> on one specific architecture.  Not some generic concept that clear_bit
> has no ordering stuff in there.
> 

The memory ordering that above combination should produce is a
Linux style smp_mb before the clear_bit. Not a release.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

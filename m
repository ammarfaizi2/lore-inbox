Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWCWA0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWCWA0l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWCWA0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:26:41 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:3170 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932663AbWCWA0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:26:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fOF47dHU7+l0rbWlikBNsbkGs813wTbzrssNJ3lsfvu8NFtdiuxB3Y5X8v/cvg+TW8+jNZrS1IFW22DW4uch+qEcj0j254GGwZ4z1/V5HXZu0hq1b2k6UrSUk/NwvMWaY+6TxCSmpIurD58Jh3xuDV40jkQ10Aow4hoqAsIUCv0=  ;
Message-ID: <4421EB3B.90804@yahoo.com.au>
Date: Thu, 23 Mar 2006 11:26:35 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
CC: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [RFC PATCH 30/35] Add generic_page_range() function
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063805.741915000@sorel.sous-sol.org> <44213333.6030404@yahoo.com.au> <79fcd3fd1d13741c5d1cd3c6f5b326b9@cl.cam.ac.uk>
In-Reply-To: <79fcd3fd1d13741c5d1cd3c6f5b326b9@cl.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser wrote:

>> lastly, you don't allow any control over the type of pages that are
>> walked: this could well be unusably slow for some cases. At least
>> you should proably design the interface so we can iterate over
>> present, not present, all, etc so it becomes widely usable. Normally
>> I'd say to wait until users come up but in this case the function
>> isn't a speed demon anyway, and you also don't want to give people
>> any excuses not to use it.
> 
> 
> You mean iterate only over PTEs that are already present, or only those 
> that were *not* previously present, or all (present and non-present)? Is 
> that really useful? If so then yes, it's not hard to add.
> 

Yes. If you look at all the code that walks pagetables (including those
that just operate on a single pte) in arch/ and other places, there is
a fair diversity. A function called generic_page_range() would surely be
able to replace all those ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

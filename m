Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWISRvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWISRvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWISRvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:51:35 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:41374 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751876AbWISRve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:51:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=dEM+54IBkE1I7XI0jf0J7dPRCL3UMnb95HeyzQrs/X+MoQ9erbsE+/FNeyMQzQcSZMBAUc8LST+i31OVkolspJ8Z75vadmJO0qqEbNV/vDS6r+GiHuJHxPJ0LVp8lihH5Vc5g1QVGSfwYeZyUo7Opmsl+FvgEo++vBS8vppHk60=  ;
Message-ID: <45102E21.2060301@yahoo.com.au>
Date: Wed, 20 Sep 2006 03:51:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: "Paul E. McKenney" <paulmck@us.ibm.com>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
References: <Pine.LNX.4.44L0.0609191332470.4345-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0609191332470.4345-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On Wed, 20 Sep 2006, Nick Piggin wrote:

>>I don't think that need be the case if one of the CPUs that has written
>>the variable forwards the store to a subsequent load before it reaches
>>the cache coherency (I could be wrong here). So if that is the case, then
>>your above example would be correct.
> 
> 
> I don't understand your comment.  Are you saying it's possible for two 
> CPUs to observe the same two writes and see them occurring in opposite 
> orders?

If store forwarding is able to occur outside cache coherency protocol,
then I don't see why not. I would also be interested to know if this
is the case on real systems.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

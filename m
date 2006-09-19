Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752010AbWISTsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbWISTsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbWISTsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:48:09 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:51030 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752010AbWISTsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:48:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OWh+Zx5zq1YhTIPBIrc/H0oJ7b96ys21usfg2C1I/EgBxKp/KExxkmv09b5fp5lcK0KxfkVUjM6ClDLK6d5B821RX4wX7GDqxoJ+g0+FC8IjYbiaDs/+QeBQd8gkUQ4hvBhvrYZPVZnqF6Djwk+N30sugu1lR0k2/sPbAggIRu8=  ;
Message-ID: <45104970.40905@yahoo.com.au>
Date: Wed, 20 Sep 2006 05:48:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Alan Stern <stern@rowland.harvard.edu>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
References: <Pine.LNX.4.44L0.0609191332470.4345-100000@iolanthe.rowland.org> <45102E21.2060301@yahoo.com.au> <20060919181919.GG1310@us.ibm.com> <45103B8D.1040006@yahoo.com.au> <20060919193604.GI1310@us.ibm.com>
In-Reply-To: <20060919193604.GI1310@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> On Wed, Sep 20, 2006 at 04:48:45AM +1000, Nick Piggin wrote:
> Sooner or later, the cacheline comes to the store queue, defining
> the ordering.  All changes that occurred in the store queue while
> waiting for the cache line appear to other CPUs as having happened
> in very quick succession while the cacheline resides with the store
> queue in question.
> 
> So, what am I missing?

Maybe I'm missing something. But if the same CPU loads the value
before the store becomes visible to cache coherency, it might see
the value out of any order any of the other CPUs sees.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVIWJCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVIWJCy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 05:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVIWJCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 05:02:54 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:10648 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750826AbVIWJCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 05:02:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=b/shxcK1v51n2WlXNDaH5QcA1ky2OrUqeG2FGudc2NTs28K/6F7/gFiE72oGe6DdMkU27cdHH7XoSM3Krt5zSMe7mhcR7qp4r/UXMgqeCKS3RFqcWejJ9ZgsBo0/IgRJ8i51mdfwRlCiyZNL3/g83piIReuveIMaAoNoaoAiTbE=  ;
Message-ID: <4333C4F4.9030402@yahoo.com.au>
Date: Fri, 23 Sep 2005 19:03:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: ioe-lkml@rameria.de, linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: making kmalloc BUG() might not be a good idea
References: <4333A109.2000908@yahoo.com.au>	<200509230909.54046.ioe-lkml@rameria.de>	<4333B588.9060503@yahoo.com.au> <20050923.010939.11256142.davem@davemloft.net>
In-Reply-To: <20050923.010939.11256142.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Nick Piggin <nickpiggin@yahoo.com.au>
> Date: Fri, 23 Sep 2005 17:58:00 +1000
> 

> If we know how to make certain classes of bugs non-lethal, we should
> do so because there will always be bugs. :-)  This change makes
> previously non-lethal bugs potentially kill the machine.
> 

Oh the BUG is bad, sure. I just thought WARN would be a better _compromise_
than BUG in that it will achieve the same result without takeing the machine
down.

I think the CONFIG_DEBUG options are there for some major types of debugging
that require significant infrastructure or can slow down the kernel quite
a lot. With that said, I think there is an option somewhere to turn off all
WARNs and remove strings from all BUGs.

Regarding proliferation of assertions and warnings everywhere - without any
official standard, I think we're mostly being sensible with them (at least
in the core code that I look at). A warn in kmalloc for this wouldn't be
anything radical.

I don't much care for it, but I agree the BUG has to go.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

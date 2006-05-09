Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWEIBrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWEIBrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 21:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWEIBrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 21:47:40 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:20901 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751091AbWEIBrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 21:47:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Nt3sV+z2XNu0s55Ve+8E/JLgM46wD/tWrzPeRavKo+XGFRS98Fz4fXRBfu/rOQgvnpB9pE+f9Ah21/s3DOyJ13vQ3lq3LEnMNrK203pvA0ZSYcEhrvYPsIqL5XGsL5aPFXHwud+2W86xpF95GYweKTlpXeqfqoYJ9NhmHFcu7t0=  ;
Message-ID: <445FF4B3.7020101@yahoo.com.au>
Date: Tue, 09 May 2006 11:47:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: akpm@osdl.org, davej@codemonkey.org.uk, tony.luck@intel.com, ak@suse.de,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 6/6] Break out memory initialisation code from page_alloc.c
 to mem_init.c
References: <20060508141030.26912.93090.sendpatchset@skynet> <20060508141231.26912.52976.sendpatchset@skynet>
In-Reply-To: <20060508141231.26912.52976.sendpatchset@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:

>page_alloc.c contains a large amount of memory initialisation code. This patch
>breaks out the initialisation code to a separate file to make page_alloc.c
>a bit easier to read.
>

I realise this is at the wrong end of your queue, but if you _can_ easily
break it out and submit it first, it would be a nice cleanup and would help
shrink your main patchset.

Also, we're recently having some problems with architectures not aligning
zones correctly. Would it make sense to add these sorts of sanity checks,
and possibly forcing alignment corrections into your generic code?

Nick
--

Send instant messages to your online friends http://au.messenger.yahoo.com 

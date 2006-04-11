Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWDKOLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWDKOLb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 10:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWDKOLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 10:11:31 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:39295 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751125AbWDKOLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 10:11:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=MUaRCm/rN1mnVZDZP/h2qScvKu1MK6mNIcLdQFNNdenGM5AZEyZuMRuFfzfvpGjFO+Gu5Xg+bPvqDei9/Cir+UksJe+yEzDixYnaVBwkXf6OCaPmdFS89zK8O/Jp2AVEVQuqlhdguS0yX8iDV8YP8ZUv6p8iTIRYlwzSj0fnDd0=  ;
Message-ID: <443B8DE7.4000900@yahoo.com.au>
Date: Tue, 11 Apr 2006 21:07:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: davej@codemonkey.org.uk, linuxppc-dev@ozlabs.org, tony.luck@intel.com,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] Break out memory initialisation code from page_alloc.c
 to mem_init.c
References: <20060411103946.18153.83059.sendpatchset@skynet> <20060411104147.18153.64342.sendpatchset@skynet>
In-Reply-To: <20060411104147.18153.64342.sendpatchset@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> page_alloc.c contains a large amount of memory initialisation code. This patch
> breaks out the initialisation code to a separate file to make page_alloc.c
> a bit easier to read.
> 

Seems like a very good idea to me.

> +/*
> + * mm/mem_init.c
> + * Initialises the architecture independant view of memory. pgdats, zones, etc
> + *
> + *  Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
> + *  Swap reorganised 29.12.95, Stephen Tweedie
> + *  Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
> + *  Reshaped it to be a zoned allocator, Ingo Molnar, Red Hat, 1999
> + *  Discontiguous memory support, Kanoj Sarcar, SGI, Nov 1999
> + *  Zone balancing, Kanoj Sarcar, SGI, Jan 2000
> + *  Per cpu hot/cold page lists, bulk allocation, Martin J. Bligh, Sept 2002
> + *	(lots of bits borrowed from Ingo Molnar & Andrew Morton)
> + *  Arch-independant zone size and hole calculation, Mel Gorman, IBM, Apr 2006
> + *	(lots of bits taken from architecture code)
> + */

Maybe drop the duplicated changelog? (just retain copyrights I guess)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

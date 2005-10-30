Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932825AbVJ3E16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbVJ3E16 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 00:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbVJ3E16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 00:27:58 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:47255 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932825AbVJ3E15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 00:27:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Hr/dJEtXP9/D6Z8AKGMMVLzkw7OXZYolyA6YOnpDTC0beItbHHPGx/qhSRmNG2QbxTe2Lk5pC39QkRQiB8QtJhgiKPiVTiAF0GzMWHwV2xABXHpV05mO9WjFsekvcmHfuhgc09qmo6GyeTyy0uzy3cnHI4NcVu91CUKJTLHH+Ro=  ;
Message-ID: <43644C22.8050501@yahoo.com.au>
Date: Sun, 30 Oct 2005 15:29:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: munmap extremely slow even with untouched mapping.
References: <20051028013738.GA19727@attica.americas.sgi.com> <43620138.6060707@yahoo.com.au> <Pine.LNX.4.61.0510281557440.3229@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0510281557440.3229@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> Yes, it's a good observation from Robin.
> 
> It'll have been spoiling the exit speedup we expected from your
> 2.6.14 copy_page_range "Don't copy [faultable] ptes" fork speedup.
> 

Yep. Not to mention it is probably responsible for some of the
4 level page table performance slowdowns on x86-64.

> 
> 
> I prefer your patch too.  But I'm not very interested in temporary
> speedups relative to 2.6.14.  Attacking this is a job I'd put off
> until after the page fault scalability changes, which make it much
> easier to do a proper job.
> 

Yeah definitely.

I wonder if we should go with Robin's fix (+/- my variation)
as a temporary measure for 2.6.15?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

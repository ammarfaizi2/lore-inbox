Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVIYBUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVIYBUz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 21:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVIYBUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 21:20:55 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:17802 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750802AbVIYBUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 21:20:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=HD2fc3Qr+VgYdgfwpS+dcOCfTlHxzyzRHl6Pnymrsrt5L82FXZmFaPFqKi6MBdKby0v7lj7kDI2+2ZP1Do8aB70gqao+85iKc7i+RT27urNfUyl89uB+OcqJzXTSlkMP/m4/p20Zuh8bawV2MN9b/RagAuzEwIj9GlJrhrtxHA0=  ;
Message-ID: <4335FB9C.50602@yahoo.com.au>
Date: Sun, 25 Sep 2005 11:21:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mremap move ZERO_PAGE fix
References: <Pine.LNX.4.61.0509241127420.11579@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0509241127420.11579@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> Fix nasty little bug we've missed in Nick's mremap move ZERO_PAGE patch.
> The "pte" at that point may be a swap entry or a pte_file entry: we must
> check pte_present before perhaps corrupting such an entry.
> 
> Patch below against 2.6.14-rc2-mm1, but the same bug is in 2.6.14-rc2's
> mm/mremap.c, and more dangerous there since it's affecting all arches:
> I think the safest course is to send Nick's patch and Yoichi's build fix
> and this fix (build tested) on to Linus - so only MIPS can be affected.
> 

Thanks Hugh. I agree with your proposed merge plan.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

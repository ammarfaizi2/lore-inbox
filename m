Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWCQOTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWCQOTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWCQOTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:19:31 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:48305 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030192AbWCQOTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:19:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=bVLs8JP4EsmTUwGpDm3br/Ng/2uuZHS98bZT89f+0ERJQA99DeRzS+6cVhU0GntkH3hz5clk/Nh+gMmFqSgb47X6dOP7m+BqxjzuasQE8kA3CeY6NmBrOAQ5Ds/HgL6uZyuFZhYpdO1a+bv6uculcEG93hCHB0nL/mc+Me+cGiw=  ;
Message-ID: <441AC4BC.4010904@yahoo.com.au>
Date: Sat, 18 Mar 2006 01:16:28 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, hch@lst.de,
       cotte@de.ibm.com, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 2/2] mspec driver
References: <yq0k6auuy5n.fsf@jaguar.mkp.net>	<20060316163728.06f49c00.akpm@osdl.org>	<yq0bqw5utyc.fsf_-_@jaguar.mkp.net> <441ABB68.1020502@yahoo.com.au> <yq07j6tuq05.fsf@jaguar.mkp.net> <441AC300.8020003@yahoo.com.au> <441AC3A4.801@sgi.com>
In-Reply-To: <441AC3A4.801@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> Nick Piggin wrote:
> 
>>No problem, I think you should just stop using the VM_PFNMAP flag then.
>>[Linus should jump in here if I'm wrong ;)]
> 
> 
> I'd have to go back and find the discussion to verify, but if I
> remember correctly the conclusion was that I needed to use it in
> order to make sure that vm_normal_page() didn't start thinking it was
> in fact a real page, ie. VM_PFNMAP + never a COW mapping..
> 

Oh of course: the primary purpose for VM_PFNMAP is to signal a pfn
mapping, strangely enough. The COW facility is additional to that.
Sorry.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

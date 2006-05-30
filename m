Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWE3GpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWE3GpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 02:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWE3GpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 02:45:05 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:19099 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932170AbWE3GpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 02:45:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Bcr5Gvll+D8VIJugP3LL7Er/siyrOdkVNoXfE2CLa3SIPOZ24HK7hwDOZtjTBSTFnP4YZNCdVweS+c5DTNp9uISFCNxXjm6MhTM5P7ZJE431HjEMx18HIpv55AvSFyWcPpvcnq7QTaPKRpqI6ordVuDgkh4JbVMjLpzZpKYEvEs=  ;
Message-ID: <447BE9E9.4000907@yahoo.com.au>
Date: Tue, 30 May 2006 16:44:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       mike@halcrow.us, ezk@cs.sunysb.edu
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060530055115.GD18626@filer.fsl.cs.sunysb.edu>
In-Reply-To: <20060530055115.GD18626@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef Sipek wrote:
> On Mon, May 29, 2006 at 07:34:09PM +1000, Nick Piggin wrote:
> ...
> 
>>Can we get rid of the whole thing, confusing memory barriers and all?
>>Nobody uses anything but the default sync_page
> 
> 
> I feel like I must say this: there are some file systems that live
> outside the kernel (at least for now) that do _NOT_ use the default
> sync_page. All the stackable file systems that are based on FiST [1],
> such as Unionfs [2] and eCryptfs (currently in -mm) [3] (respective
> authors CC'd). As an example, Unionfs must decide which lower file
> system page to sync (since it may have several to chose from).

OK, noted. Thanks. Luckily for them it looks like sync_page might
stay for other reasons (eg. raid) ;)

Any good reasons they are not in the tree?

> 
> Josef "Jeff" Sipek.
> 
> [1] http://www.filesystems.org
> [2] http://unionfs.filesystems.org
> [3] http://ecryptfs.sourceforge.net



-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

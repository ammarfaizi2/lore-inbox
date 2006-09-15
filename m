Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWIOJWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWIOJWm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 05:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWIOJWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 05:22:42 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:4109 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750797AbWIOJWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 05:22:41 -0400
Subject: Re: Efficient Use of the Page Cache with 64 KB Pages
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Sandeep Kumar <sandeepksinha@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@austin.ibm.com>
In-Reply-To: <37d33d830609150150v30dc32en57f8c5e43c30aef3@mail.gmail.com>
References: <37d33d830609150150v30dc32en57f8c5e43c30aef3@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 11:11:28 +0200
Message-Id: <1158311488.23551.4.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 01:50 -0700, Sandeep Kumar wrote:
> Hey all,
> I am a newbie and I just read a document with the idea for changes in
> page cache management for 64 Bit machines. This has been taken from
> Linux symposium 2006, ottawa.
> 
> In order for 64-bit processors to efficiently use large address spaces
> while maintaining lower TLB miss rates, the Linux kernel can be
> configured with base page sizes up to 64 KB. While this benefits
> access to large memory segments and files, it greatly reduces the
> number of smaller files that can be resident in memory at one time.
> The idea proposes a change to the Linux kernel to allow file data to
> be more efficiently stored in memory when the size of the file, or the
> data at the end of a file, is significantly smaller than the page
> size.
> 
> So, how far is this feature feasible for the linux main line kernel ?

Not in the form last presented, but Dave is still working on making it
look pretty and covering more use-cases AFAIK.

But even then, it will not fix all scenarios...

> Is, this feature already supported ?

No it is not. 

In future it would be nice to add the author(s) to the CC list ;-)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266198AbUHZXP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUHZXP3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269750AbUHZXOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:14:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:5067 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S269722AbUHZXLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:11:55 -0400
Subject: Re: [Lhms-devel] [RFC] buddy allocator without bitmap  [2/4]
From: Dave Hansen <haveblue@us.ibm.com>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <412E6CC3.8060908@jp.fujitsu.com>
References: <412DD1AA.8080408@jp.fujitsu.com>
	 <1093535402.2984.11.camel@nighthawk>  <412E6CC3.8060908@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1093561869.2984.360.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 16:11:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 16:05, Hiroyuki KAMEZAWA wrote:
> I understand using these macros cleans up codes as I used them in my previous
> version.
> 
> In the previous version, I used SetPagePrivate()/ClearPagePrivate()/PagePrivate().
> But these are "atomic" operation and looks very slow.
> This is why I doesn't used these macros in this version.
> 
> My previous version, which used set_bit/test_bit/clear_bit, shows very bad performance
> on my test, and I replaced it.
> 
> If I made a mistake on measuring the performance and set_bit/test_bit/clear_bit
> is faster than what I think, I'd like to replace them.

Sorry, I misread your comment:

/* Atomic operation is needless here */

I read "needless" as "needed".  Would it make any more sense to you to
say "already have lock, don't need atomic ops", instead?

-- Dave


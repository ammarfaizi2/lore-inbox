Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269838AbUH0A2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269838AbUH0A2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269799AbUH0ATV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:19:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:3018 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269829AbUH0APL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:15:11 -0400
Date: Thu, 26 Aug 2004 17:18:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lhms-devel@lists.sourceforge.net, wli@holomorphy.com
Subject: Re: [Lhms-devel] [RFC] buddy allocator without bitmap  [2/4]
Message-Id: <20040826171840.4a61e80d.akpm@osdl.org>
In-Reply-To: <412E6CC3.8060908@jp.fujitsu.com>
References: <412DD1AA.8080408@jp.fujitsu.com>
	<1093535402.2984.11.camel@nighthawk>
	<412E6CC3.8060908@jp.fujitsu.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> In the previous version, I used SetPagePrivate()/ClearPagePrivate()/PagePrivate().
> But these are "atomic" operation and looks very slow.
> This is why I doesn't used these macros in this version.
> 
> My previous version, which used set_bit/test_bit/clear_bit, shows very bad performance
> on my test, and I replaced it.

That's surprising.  But if you do intend to use non-atomic bitops then
please add __SetPagePrivate() and __ClearPagePrivate()

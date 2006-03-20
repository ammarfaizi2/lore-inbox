Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWCTTIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWCTTIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWCTTIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:08:16 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:43461 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S964966AbWCTTIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:08:14 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
To: balbir@in.ibm.com, Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Mon, 20 Mar 2006 20:07:59 +0100
References: <5Ssjj-314-69@gated-at.bofh.it> <5Sv7o-7l5-23@gated-at.bofh.it> <5Svh9-7xW-61@gated-at.bofh.it> <5SvK8-88q-41@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FLPjT-0000o9-Sy@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <balbir@in.ibm.com> wrote:

>> No, no, no! I am introducing kmem_cache_zalloc() because there are
>> existing users in the tree. I plan to kill the slab wrappers from XFS
>> completely which is why I need this. We already have object constructors
>> for what you're describing.
> 
> Ok, please keep the interface - build kmem_cache_zalloc() on top of
> what I suggest.

The benefit of using *zalloc is the ability to skip the memset by using
pre-zeroed memory or to use more efficient ways of zeroing a page.
Having to check the value of a parameter wouldn't help.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

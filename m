Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbTIVUpb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTIVUpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:45:30 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:21405 "EHLO
	natsmtp01.webmailer.de") by vger.kernel.org with ESMTP
	id S263293AbTIVUp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:45:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] Move slab objects to the end of the real allocation
Date: Mon, 22 Sep 2003 22:40:16 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200309221733.37203.arnd@arndb.de> <3F6F23DA.9020901@colorfullife.com>
In-Reply-To: <3F6F23DA.9020901@colorfullife.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309222240.01023.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 September 2003 18:31, Manfred Spraul wrote:
> Right now there are too many patches in Andrew's tree, I'll wait until
> everything settled down a bit, then I'll resent the cache line size as a
> one-line patch. Do you want to implement CONFIG_DEBUG_PAGEALLOC
> immediately? If yes, then I can send you the oneliner immediately.
> Nothing except CONFIG_DEBUG_PAGEALLOC is affected by the bug.

Thanks for the explanation. I didn't realize that the code only applies
to i386. I'm not trying to implement CONFIG_DEBUG_PAGEALLOC currently,
but I'll put it on my list of things to do. Do I need to do anything
beyond adding a working kernel_map_pages() and raising the 128 byte limit
in kmem_cache_create to max(128,L1_CACHE_BYTES)?

	Arnd <><

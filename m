Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUHMNNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUHMNNS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 09:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbUHMNNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 09:13:18 -0400
Received: from the-village.bc.nu ([81.2.110.252]:11993 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265249AbUHMNNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 09:13:15 -0400
Subject: Re: excessive swapping
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092381036.2597.29.camel@rivendell.home.local>
References: <1092379250.2597.14.camel@rivendell.home.local>
	 <1092379468.2597.16.camel@rivendell.home.local>
	 <1092381036.2597.29.camel@rivendell.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092399058.24408.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 13:10:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-13 at 08:10, Florin Andrei wrote:
> The efficiency of increasing the disk cache decreases exponentially with
> size, like any other cache. Then what's the point of sacrificing useful
> memory just to increase some hypothetical "useful" cache?

The problem is defining "useful". Pieces of applications not being
run at the moment are also not useful. Balancing them isn't easy 
because as you say the cache behaviour is exponential _and_ the two
caches have different behaviours when you get blocking (program paging
is generally random so 30+ times slower than streaming bits). Plus there
is user perception.

The latest code is clearly wrong but it isn't simple to get the balance
right either.


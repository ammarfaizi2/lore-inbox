Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbVIMMKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbVIMMKD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbVIMMKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:10:01 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:6622 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932623AbVIMMKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:10:00 -0400
Date: Tue, 13 Sep 2005 14:09:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [discuss] Re: [1/3] Add 4GB DMA32 zone
In-Reply-To: <200509131332.17244.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0509131407580.3743@scrub.home>
References: <43246267.mailL4R11PXCB@suse.de> <200509131147.42140.ak@suse.de>
 <20050913031540.0c732284.akpm@osdl.org> <200509131332.17244.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 13 Sep 2005, Andi Kleen wrote:

> Hmm ok description is not very enlightening. 4 zones should indeed
> still fit into 2 bits.
> 
> Kamezawa-san, can you please explain why exactly you did that change?

Probably because it triggers this check:

#if SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
#error SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
#endif

bye, Roman

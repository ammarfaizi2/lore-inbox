Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWH3Kvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWH3Kvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 06:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWH3Kvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 06:51:54 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:51165 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750803AbWH3Kvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 06:51:54 -0400
Date: Wed, 30 Aug 2006 12:51:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Alexey Dobriyan <adobriyan@mail.ru>,
       Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH 1/7] introduce atomic_dec_and_lock_irqsave()
In-Reply-To: <20060830145759.GA163@oleg>
Message-ID: <Pine.LNX.4.64.0608301248420.6761@scrub.home>
References: <44F45045.70402@sw.ru> <44F4540C.8050205@sw.ru>
 <Pine.LNX.4.64.0608301156010.6762@scrub.home> <20060830145759.GA163@oleg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Aug 2006, Oleg Nesterov wrote:

> > Why does this need protection against interrupts?
> 
> uidhash_lock can be taken from irq context. For example, delayed_put_task_struct()
> does __put_task_struct()->free_uid().

AFAICT it's called via rcu, does that mean anything released via rcu has 
to be protected against interrupts?

bye, Roman

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVGKQxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVGKQxy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVGKQkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:40:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:46465 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262067AbVGKQjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:39:33 -0400
Date: Mon, 11 Jul 2005 18:39:30 +0200
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Brian Gerst <bgerst@didntduck.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] i386: Per node IDT
Message-ID: <20050711163930.GH7538@bragg.suse.de>
References: <Pine.LNX.4.61.0507101617240.16055@montezuma.fsmlabs.com.suse.lists.linux.kernel> <p73eka614t7.fsf@verdi.suse.de> <Pine.LNX.4.61.0507110718500.16055@montezuma.fsmlabs.com> <42D28A27.9000507@didntduck.org> <Pine.LNX.4.61.0507110919270.16055@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507110919270.16055@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes you're right, i wasn't quite awake when i replied, thanks for 
> correcting that.

You would need to allocate it using vmalloc if you wanted
to put it node local, eating up precious TLB entries.

Anyways, i386 NUMA is so broken anyways regarding all that that I wouldn't
worry about node local allocation. Just allocate it somewhere, just
not statically. 

I only worried about static memory consumption of a kernel. An IDT is quite
big and NR_CPUS tends to be too.

-Andi

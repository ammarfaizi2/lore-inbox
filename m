Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWJVUyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWJVUyW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 16:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWJVUyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 16:54:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28140 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751476AbWJVUyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 16:54:21 -0400
Date: Sun, 22 Oct 2006 16:54:13 -0400
From: Dave Jones <davej@redhat.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Luca Risolia <luca.risolia@studio.unibo.it>
Subject: Re: sn9c10x list corruption in 2.6.18.1
Message-ID: <20061022205413.GB3093@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Luca Risolia <luca.risolia@studio.unibo.it>
References: <20061022031145.GA24855@redhat.com> <84144f020610221337k2137a1a9xeb35a4bce48e152c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020610221337k2137a1a9xeb35a4bce48e152c@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 11:37:06PM +0300, Pekka Enberg wrote:
 > On 10/22/06, Dave Jones <davej@redhat.com> wrote:
 > > What's odd here is that we have a list entry still on a list, with its ->next set to
 > > LIST_POISON2, which should only ever happen after an entry has been removed from
 > > a list.  The list manipulation in cache_alloc_refill is all done under l3->list_lock,
 > > so I'm puzzled how this is possible.
 > >
 > > I found one area in the driver where we do list manipulation without any locking,
 > > but I'm not entirely convinced that this is the source of the bug yet.
 > 
 > But I don't see how that could cause a slab list to go bad. An
 > old-fashioned slab corruption sounds more like it. Does the the kernel
 > have CONFIG_SLAB_DEBUG enabled?
 
No, but I'll do a test build for the next update with it enabled to see if
that's any more enlightening.

	Dave

-- 
http://www.codemonkey.org.uk

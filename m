Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWFUAey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWFUAey (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWFUAey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:34:54 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:12228 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932229AbWFUAex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:34:53 -0400
Date: Tue, 20 Jun 2006 17:34:30 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>, npiggin@suse.de, Paul.McKenney@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 0/3] 2.6.17 radix-tree: updates and lockless
In-Reply-To: <1150847428.1901.60.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606201732580.14331@schroedinger.engr.sgi.com>
References: <20060408134635.22479.79269.sendpatchset@linux.site> 
 <20060620153555.0bd61e7b.akpm@osdl.org>  <1150844989.1901.52.camel@localhost.localdomain>
  <20060620163037.6ff2c8e7.akpm@osdl.org> <1150847428.1901.60.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Benjamin Herrenschmidt wrote:

> Anyway, I can drop a spinlock in (in fact I have) the ppc64 irq code for
> now but that sucks, thus we should really seriously consider having the
> lockless tree in 2.6.18 or I might have to look into doing an alternate
> implementation specifically in arch code... or find some other way of
> doing the inverse mapping there...

How many interrupts do you have to ? I would expect a simple table 
lookup would be fine to get from the virtual to the real interrupt.


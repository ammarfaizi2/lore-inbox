Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbULHSen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbULHSen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbULHSee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:34:34 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:56479 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261312AbULHSeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:34:03 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Anticipatory prefaulting in the page fault handler V1
Date: Wed, 8 Dec 2004 10:33:24 -0800
User-Agent: KMail/1.7
Cc: nickpiggin@yahoo.com.au, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org, hugh@veritas.com, benh@kernel.crashing.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <200412080933.13396.jbarnes@engr.sgi.com> <Pine.LNX.4.58.0412080952100.27324@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0412080952100.27324@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412081033.24367.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, December 8, 2004 9:56 am, Christoph Lameter wrote:
> > And again, I'm not sure how important that is, maybe this approach will
> > work well in the majority of cases (obviously it's a big win in
> > faults/sec for your benchmark, but I wonder about subsequent references
> > from other CPUs to those pages).  You can look at
> > /sys/devices/platform/nodeN/meminfo to see where the pages are coming
> > from.
>
> The origin of the pages has not changed and the existing locality
> constraints are observed.
>
> A patch like this is important for applications that allocate and preset
> large amounts of memory on startup. It will drastically reduce the startup
> times.

Ok, that sounds good.  My case was probably a bit contrived, but I'm glad to 
see that you had already thought of it anyway.

Jesse

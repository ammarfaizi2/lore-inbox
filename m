Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUKSWlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUKSWlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbUKSWeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:34:00 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:22919 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261668AbUKSWdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:33:12 -0500
Date: Thu, 18 Nov 2004 10:39:44 -0600
From: Jack Steiner <steiner@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Subject: Re: Externalize SLIT table
Message-ID: <20041118163944.GA28955@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Resend of mail sent Nov 10, 2004 - as far as I can tell, it went nowhere)


On Wed, Nov 10, 2004 at 04:05:43PM +1100, Mark Goodwin wrote:
>
> On Tue, 9 Nov 2004, Matthew Dobson wrote:
> >On Tue, 2004-11-09 at 12:34, Mark Goodwin wrote:
> >>Once again however, it depends on the definition of distance. For nodes,
> >>we've established it's the ACPI SLIT (relative distance to memory). For
> >>cpus, should it be distance to memory? Distance to cache? Registers? Or
> >>what?
> >>
> >That's the real issue.  We need to agree upon a meaningful definition of   
> >CPU-to-CPU "distance".  As Jesse mentioned in a follow-up, we can all
> >agree on what Node-to-Node "distance" means, but there doesn't appear to
> >be much consensus on what CPU "distance" means.
>
> How about we define cpu-distance to be "relative distance to the
> lowest level cache on another CPU". On a system that has nodes with
> multiple sockets (each supporting multiple cores or HT "CPUs" sharing
> some level of cache), when the scheduler needs to migrate a task it would
> first choose a CPU sharing the same cache, then a CPU on the same node,
> then an off-node CPU (i.e. falling back to node distance).

I think I like your definition better than the one I originally proposed (cpu
distance was distance between the local memories of the cpus).

But how do we determine the distance between the caches.


> 
> Of course, I have no idea if that's anything like an optimal or desirable
> task migration policy. Probably depends on cache-trashiness of the task
> being migrated.
> 
> -- Mark



-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.



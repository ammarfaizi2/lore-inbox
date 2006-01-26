Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWAZXSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWAZXSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWAZXSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:18:34 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:56797 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030225AbWAZXSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:18:33 -0500
Date: Thu, 26 Jan 2006 15:18:18 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 0/9] Critical Mempools
In-Reply-To: <43D954D8.2050305@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0601261516160.18716@schroedinger.engr.sgi.com>
References: <1138217992.2092.0.camel@localhost.localdomain>
 <Pine.LNX.4.62.0601260954540.15128@schroedinger.engr.sgi.com>
 <43D954D8.2050305@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Matthew Dobson wrote:

> > All subsystems will now get more complicated by having to add this 
> > emergency functionality?
> 
> Certainly not.  Only subsystems that want to use emergency pools will get
> more complicated.  If you have a suggestion as to how to implement a
> similar feature that is completely transparent to its users, I would *love*

I thought the earlier __GFP_CRITICAL was a good idea.

> to hear it.  I have tried to keep the changes to implement this
> functionality to a minimum.  As the patches currently stand, existing slab
> allocator and mempool users can continue using these subsystems without
> modification.

The patches are extensive and the required changes to subsystems in order 
to use these pools are also extensive.

> > There surely must be a better way than revising all subsystems for 
> > critical allocations.
> Again, I could not find any way to implement this functionality without
> forcing the users of the functionality to make some, albeit very minor,
> changes.  Specific suggestions are more than welcome! :)

Gfp flag? Better memory reclaim functionality?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWA0Aju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWA0Aju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWA0Aju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:39:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24267 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932155AbWA0Ajt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:39:49 -0500
Date: Thu, 26 Jan 2006 16:39:38 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
In-Reply-To: <43D96A93.9000600@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0601261638210.19078@schroedinger.engr.sgi.com>
References: <20060125161321.647368000@localhost.localdomain>
 <1138233093.27293.1.camel@localhost.localdomain>
 <Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com>
 <43D953C4.5020205@us.ibm.com> <Pine.LNX.4.62.0601261511520.18716@schroedinger.engr.sgi.com>
 <43D95A2E.4020002@us.ibm.com> <Pine.LNX.4.62.0601261525570.18810@schroedinger.engr.sgi.com>
 <43D96633.4080900@us.ibm.com> <Pine.LNX.4.62.0601261619030.19029@schroedinger.engr.sgi.com>
 <43D96A93.9000600@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Matthew Dobson wrote:

> That seems a bit beyond the scope of what I'd hoped for this patch series,
> but if an approach like this is believed to be generally useful, it's
> something I'm more than willing to work on...

We need this for other issues as well. f.e. to establish memory allocation 
policies for the page cache, tmpfs and various other needs. Look at 
mempolicy.h which defines a subset of what we need. Currently there is no 
way to specify a policy when invoking the page allocator or slab 
allocator. The policy is implicily fetched from the current task structure 
which is not optimal.


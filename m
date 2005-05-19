Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVESQOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVESQOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 12:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVESQOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 12:14:19 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:2983 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262558AbVESQOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 12:14:12 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Christoph Lameter <christoph@lameter.com>
Subject: Re: NUMA aware slab allocator V3
Date: Thu, 19 May 2005 09:14:01 -0700
User-Agent: KMail/1.8
Cc: Matthew Dobson <colpatch@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> <Pine.LNX.4.62.0505181439080.10598@graphe.net> <Pine.LNX.4.62.0505182105310.17811@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0505182105310.17811@graphe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505190914.01772.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 18, 2005 10:07 pm, Christoph Lameter wrote:
> Here is a revised patch. Would be good if someone could review my use
> of online_cpu / online_node etc. Is there some way to bring cpus
> online and offline to test if this really works? Seems that the code
> in alloc_percpu is suspect even in the old allocator because it may
> have to allocate memory for non present cpus.

If you have hotplug enabled, I think you'll see an 'online' file that 
you can echo 1 or 0 into, somewhere in /sys/devices/system/cpu/cpu0 for 
example.  It should work even on machines where it doesn't actually 
power down the slot (it'll just remove it from the online map, and it 
won't get scheduled on, etc.); at least it did last time I tested it.

Jesse

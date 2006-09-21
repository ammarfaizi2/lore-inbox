Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWIUAX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWIUAX7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWIUAX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:23:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37325 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750803AbWIUAX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:23:58 -0400
Date: Wed, 20 Sep 2006 17:23:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: rohitseth@google.com, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       devel@openvz.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch02/05]: Containers(V2)- Generic Linux kernel changes
In-Reply-To: <200609202014.48815.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609201721360.2336@schroedinger.engr.sgi.com>
References: <1158718722.29000.50.camel@galaxy.corp.google.com>
 <p7364fikcbe.fsf@verdi.suse.de> <1158770670.8574.26.camel@galaxy.corp.google.com>
 <200609202014.48815.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Andi Kleen wrote:

> There are lots of different cases. At least for anonymous memory 
> ->mapping should be free. Perhaps that could be used for anonymous
> memory and a separate data structure for the important others.

mapping is used for swap and to point to the anon vma.

> slab should have at least one field free too, although it might be a different
> one (iirc Christoph's rewrite uses more than the current slab, but it would
> surprise me if he needed all) 

slab currently has lots of fields free but my rewrite uses all of them.
And AFAICT this patchset does not track slab pages.

Hmm.... Build a radix tree with pointers to the pages?


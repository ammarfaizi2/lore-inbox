Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030614AbWBHX2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030614AbWBHX2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030615AbWBHX2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:28:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:46791 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030614AbWBHX2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:28:20 -0500
Date: Wed, 8 Feb 2006 15:28:02 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
In-Reply-To: <20060208133909.183f19ea.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0602081526060.5184@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
 <200602082201.12371.ak@suse.de> <20060208130351.fc1c759c.pj@sgi.com>
 <200602082221.35671.ak@suse.de> <20060208133909.183f19ea.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Andrew Morton wrote:

> > I think it should be put into 2.6.16. Andrew?
> 
> Does every single caller of __alloc_pages(__GFP_FS) correctly handle a NULL
> return?  I doubt it, in which case this patch will cause oopses and hangs.

If a caller cannot handle NULL then __GFP_NOFAIL has to be set, right?

So we will never get to the piece of code under discussion.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWBFSgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWBFSgz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWBFSgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:36:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:2479 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932278AbWBFSgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:36:54 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Date: Mon, 6 Feb 2006 19:31:13 +0100
User-Agent: KMail/1.8.2
Cc: discuss@x86-64.org, bharata@in.ibm.com, linux-kernel@vger.kernel.org
References: <20060205163618.GB21972@in.ibm.com> <200602061912.31508.ak@suse.de> <Pine.LNX.4.62.0602061023580.16829@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602061023580.16829@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061931.13953.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 19:25, Christoph Lameter wrote:
> On Mon, 6 Feb 2006, Andi Kleen wrote:
> 
> > > Tried the following code on rc1 and rc2 and it worked fine on ia64:
> > 
> > Perhaps it depends on if the node has enough memory free or not?
> > I assume if the zonelist has some issue but the first entry is ok
> > it will only cause problems when the allocation has to go off node
> > (it shouldn't actually go off node with that policy of course,
> 
> If node 0 is exhausted then you have an OOM situation.

No - it could just need to free some cleanable pages first. That's
a long way before going OOM.
 
> > but with a full free local node that code path is never triggered)
> 
> Wamt me to test the OOM path for mbind?

I already know it oopses - someone else reported that. If you feel
motivated feel free to fix.

-Andi

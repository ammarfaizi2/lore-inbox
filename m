Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWIUBdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWIUBdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWIUBdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:33:36 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:46507 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750946AbWIUBdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:33:35 -0400
Subject: Re: [ckrm-tech] [patch02/05]: Containers(V2)- Generic Linux kernel
	changes
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@suse.de>, rohitseth@google.com,
       linux-kernel <linux-kernel@vger.kernel.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0609201721360.2336@schroedinger.engr.sgi.com>
References: <1158718722.29000.50.camel@galaxy.corp.google.com>
	 <p7364fikcbe.fsf@verdi.suse.de>
	 <1158770670.8574.26.camel@galaxy.corp.google.com>
	 <200609202014.48815.ak@suse.de>
	 <Pine.LNX.4.64.0609201721360.2336@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 20 Sep 2006 18:33:32 -0700
Message-Id: <1158802412.6536.127.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 17:23 -0700, Christoph Lameter wrote:
> On Wed, 20 Sep 2006, Andi Kleen wrote:
> 
> > There are lots of different cases. At least for anonymous memory 
> > ->mapping should be free. Perhaps that could be used for anonymous
> > memory and a separate data structure for the important others.
> 
> mapping is used for swap and to point to the anon vma.
> 
> > slab should have at least one field free too, although it might be a different
> > one (iirc Christoph's rewrite uses more than the current slab, but it would
> > surprise me if he needed all) 
> 
> slab currently has lots of fields free but my rewrite uses all of them.
> And AFAICT this patchset does not track slab pages.
> 
> Hmm.... Build a radix tree with pointers to the pages?

Yes, that would be a way to isolate the overhead.

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------



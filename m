Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVKQOLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVKQOLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbVKQOLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:11:21 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:13502
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750856AbVKQOLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:11:21 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Thu, 17 Nov 2005 08:11:15 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <58MJb-2Sn-37@gated-at.bofh.it> <1132061045.2822.20.camel@laptopd505.fenrus.org> <dld3cs$1sh$1@sea.gmane.org>
In-Reply-To: <dld3cs$1sh$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511170811.15279.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 November 2005 10:46, Giridhar Pemmasani wrote:
> Arjan van de Ven wrote:
> > the same as 2.4 effectively. 2.6 also has (and I wish it becomes "had"
> > soon) an option to get 6Kb effective stack space instead. This is an
> > increase of 2Kb compared to 2.4.
>
> It has been asked couple of times before in this context and no one cared
> to answer:
>
> Using 4k stacks may have advantages, but what compelling reasons are there
> to drop the choice of 4k/8k stacks? You can make 4k stacks default, but why
> throw away the option of 8k stacks, especially since the impact of this
> option on the kernel implementation is very little?

Once everything in the kernel tree has been cleaned up to work with 4k stacks, 
then none of the in-kernel drivers need this option.  No future kernel 
drivers will be accepted into the tree if they don't work with 4k stacks, 
either.  Therefore, the 8k stack option becomes something _only_ needed for 
out-of-tree drivers, and if out-of-tree drivers need >4k stacks they can 
maintain the 8k patch out of tree along with said driver.

Why is this difficult to understand?  The "impact on the implementation" of 
having 100 extra exports of random internal kernel symbols is fairly small as 
well (from a lines of code perspective), but on a policy level it ain't gonna 
happen.

Rob

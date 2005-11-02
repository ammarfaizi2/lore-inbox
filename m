Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbVKBPvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbVKBPvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbVKBPvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:51:04 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:8886 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965097AbVKBPvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:51:01 -0500
Date: Wed, 2 Nov 2005 07:48:59 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>
cc: rob@landley.net, akpm@osdl.org, torvalds@osdl.org, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, haveblue@us.ibm.com, magnus.damm@gmail.com,
       pj@sgi.com, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 0/5] Swap Migration V5: Overview
In-Reply-To: <20051102.212651.25143264.taka@valinux.co.jp>
Message-ID: <Pine.LNX.4.62.0511020745230.21461@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511010943310.16224@schroedinger.engr.sgi.com>
 <20051102.143047.35521963.taka@valinux.co.jp>
 <Pine.LNX.4.62.0511020030210.19157@schroedinger.engr.sgi.com>
 <20051102.212651.25143264.taka@valinux.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Hirokazu Takahashi wrote:

> >Please follow the discussion on lhms-devel. I am trying to bring these two 
> >things together.
> 
> I've read the archive of lhms-devel.
> You're going to take in most of the original migration code
> except for some tricks to migrate pages which are hard to move.
> I think this is what you said the complexity, which you
> want to remove forever.

No I just want to bring this in in stages for easier review.

> This have to be implemented if the hotplug memory use it.
> It seems to become a reinvention of the wheel to me.

Its a reorganization of the code in order to get this in.
 
> It's easy to add a new interface to the code for memory policy aware
> migration. It will be wonderful doing process migration prior to
> planed hotremove momory. This decision should be done out of kernel.

There are a couple of things that need to build on top of page migration. 
One is hotplug and the other is the remapping of bad memory. Both are 
similar. hotplug is mainly IBM's interest whereas remapping is also SGIs. 

We plan to get the remapping functionality in as soon as possible. For 
that we also need to be able to move pages of all sorts.


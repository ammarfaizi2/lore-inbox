Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbVKBFkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbVKBFkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbVKBFkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:40:05 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:35476 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751514AbVKBFkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:40:04 -0500
Date: Wed, 02 Nov 2005 14:30:47 +0900 (JST)
Message-Id: <20051102.143047.35521963.taka@valinux.co.jp>
To: clameter@engr.sgi.com
Cc: rob@landley.net, akpm@osdl.org, torvalds@osdl.org, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, haveblue@us.ibm.com, magnus.damm@gmail.com,
       pj@sgi.com, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 0/5] Swap Migration V5: Overview
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <Pine.LNX.4.62.0511010943310.16224@schroedinger.engr.sgi.com>
References: <20051031192506.100d03fa.akpm@osdl.org>
	<200511010208.49662.rob@landley.net>
	<Pine.LNX.4.62.0511010943310.16224@schroedinger.engr.sgi.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > So I'll queue this up for -mm, but I think we need to see an entire
> > > hot-remove implementation based on this, and have all the interested
> > > parties signed up to it before we can start moving the infrastructure into
> > > mainline.
> > >
> > > Do you think the features which these patches add should be Kconfigurable?

This code looks no help for hot-remove. It seems able to handle only
pages easily to migrate, while hot-remove has to guarantee all pages
can be migrated.

> > Yes please.  At least something under CONFIG_EMBEDDED to save poor Matt the 
> > trouble of chopping it out himself. :)
> 
> Ok. We will think of something to switch this off.

Hi Christoph, sorry I've been off from lhms for long time.

Shall I port the generic memory migration code for hot-remove to -mm tree
directly, and add some new interface like migrate_page_to(struct page *from,
struct page *to) so this may probably fit for your purpose.

The code is still in Dave's mhp1 tree waiting for being merged to -mm tree.
The port will be easy because the migration code is independent to the
memory hotplug code. The core code isn't so big.


Thanks,
Hirokazu Takahashi.

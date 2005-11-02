Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbVKBId4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbVKBId4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbVKBId4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:33:56 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52384 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932649AbVKBIdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:33:55 -0500
Date: Wed, 2 Nov 2005 00:31:15 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>
cc: rob@landley.net, akpm@osdl.org, torvalds@osdl.org, kravetz@us.ibm.com,
       raybry@mpdtxmail.amd.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, haveblue@us.ibm.com, magnus.damm@gmail.com,
       pj@sgi.com, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 0/5] Swap Migration V5: Overview
In-Reply-To: <20051102.143047.35521963.taka@valinux.co.jp>
Message-ID: <Pine.LNX.4.62.0511020030210.19157@schroedinger.engr.sgi.com>
References: <20051031192506.100d03fa.akpm@osdl.org> <200511010208.49662.rob@landley.net>
 <Pine.LNX.4.62.0511010943310.16224@schroedinger.engr.sgi.com>
 <20051102.143047.35521963.taka@valinux.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Hirokazu Takahashi wrote:

> > > > Do you think the features which these patches add should be Kconfigurable?
> 
> This code looks no help for hot-remove. It seems able to handle only
> pages easily to migrate, while hot-remove has to guarantee all pages
> can be migrated.

Right.

> Hi Christoph, sorry I've been off from lhms for long time.
> 
> Shall I port the generic memory migration code for hot-remove to -mm tree
> directly, and add some new interface like migrate_page_to(struct page *from,
> struct page *to) so this may probably fit for your purpose.
> 
> The code is still in Dave's mhp1 tree waiting for being merged to -mm tree.
> The port will be easy because the migration code is independent to the
> memory hotplug code. The core code isn't so big.

Please follow the discussion on lhms-devel. I am trying to bring these two 
things together.


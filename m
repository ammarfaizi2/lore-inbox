Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161204AbWGNCfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbWGNCfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 22:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161179AbWGNCfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 22:35:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7135 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161204AbWGNCfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 22:35:36 -0400
Date: Thu, 13 Jul 2006 19:35:20 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
cc: mm-commits@vger.kernel.org, mingo@elte.hu, arjan@infradead.org,
       sekharan@us.ibm.com
Subject: Re: + revert-slabc-lockdep-locking-change.patch added to -mm tree
In-Reply-To: <200607130729.k6D7TAH0015764@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.64.0607131933330.31507@schroedinger.engr.sgi.com>
References: <200607130729.k6D7TAH0015764@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006, akpm@osdl.org wrote:

> Chandra Seetharaman reported SLAB crashes caused by the slab.c lock
> annotation patch.  There is only one chunk of that patch that has a
> material effect on the slab logic - this patch undoes that chunk.

Please describe the crash in detail? How could this be?

This patch introduces deadlocks as discussed earlier because slab 
destroy may call kfree which may have to take the list lock itself.

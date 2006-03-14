Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWCNDqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWCNDqN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 22:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWCNDqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 22:46:13 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:49793 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932543AbWCNDqM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 22:46:12 -0500
Date: Mon, 13 Mar 2006 19:51:27 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: xen DMA bug
Message-ID: <20060314035127.GO27645@sorel.sous-sol.org>
References: <1142301766.13256.88.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142301766.13256.88.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> An ALSA user has found a Xen bug where it fails to accept a 28 bit DMA
> mask (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
> pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) fails:
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1907

Likely swiotlb range is above the mask.  I'd suggest to reporter to
file in the Fedora bugzilla under kernel-xen (with dmesg output).

thanks,
-chris

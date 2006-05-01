Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWEASri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWEASri (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 14:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWEASri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 14:47:38 -0400
Received: from test-iport-2.cisco.com ([171.71.176.105]:32655 "EHLO
	test-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750812AbWEASrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 14:47:37 -0400
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2 of 13] ipath - set up 32-bit DMA mask if 64-bit setup fails
X-Message-Flag: Warning: May contain useful information
References: <1906950392f7ef8c7d07.1145913778@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 01 May 2006 11:47:32 -0700
In-Reply-To: <1906950392f7ef8c7d07.1145913778@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Mon, 24 Apr 2006 14:22:58 -0700")
Message-ID: <ada7j55vayj.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 May 2006 18:47:35.0121 (UTC) FILETIME=[B6137410:01C66D4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> Some systems do not set up 64-bit maps on systems with 2GB
    Bryan> or less of memory installed, so we have to fall back to
    Bryan> trying a 32-bit setup.

Which systems does this happen on?  I'm just curious, because mthca has

	err = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
	if (err) {
		dev_warn(&pdev->dev, "Warning: couldn't set 64-bit PCI DMA mask.\n");

and I've never had a single report of that warning triggering.

 - R.

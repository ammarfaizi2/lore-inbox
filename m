Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUHYRJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUHYRJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268139AbUHYRJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:09:17 -0400
Received: from palrel10.hp.com ([156.153.255.245]:23211 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S267333AbUHYRJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:09:14 -0400
Date: Wed, 25 Aug 2004 10:09:01 -0700
From: Grant Grundler <iod00d@hp.com>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC&PATCH 2/2] PCI Error Recovery (readX_check)
Message-ID: <20040825170901.GD19447@cup.hp.com>
References: <412AD1EA.6080306@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412AD1EA.6080306@jp.fujitsu.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 02:28:10PM +0900, Hidetoshi Seto wrote:
> +	bool "PCI device error recovery"
> +	depends on PCI

	depends on PCI && EXPERIMENTAL

> +	---help---
> +	By default, the device driver hardly recovers from PCI errors. When
> +	this feature is available, the special io interface are provided
> +	from the kernel.

May I suggest an alternate text?
	Saying Y provides PCI infrastructure to recover from some PCI errors.
	Currently, very few PCI drivers actually implement this.
	See Documentation/pci-errors.txt for a description of the
	infrastructure provided.

I'm still digesting the rest of the patch.

grant

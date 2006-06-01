Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWFAKXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWFAKXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWFAKXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:23:07 -0400
Received: from havoc.gtf.org ([69.61.125.42]:3520 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964927AbWFAKXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:23:06 -0400
Date: Thu, 1 Jun 2006 06:23:03 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060601102303.GG5869@havoc.gtf.org>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EB4AD.4060101@reub.net> <20060601025632.6683041e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601025632.6683041e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 02:56:32AM -0700, Andrew Morton wrote:
> Should ahci.c have a data_xfer vector?  Right now it's left at NULL.

Definitely not.

If it needs one, something is _very very_ wrong.

Unlike traditional IDE interface (which most SATA uses), ahci and
sata_sil24 do PIO over DMA, and that is hooked at a much higher level
(->qc_issue).

I would be very interested in a trackback with symbol info...

	Jeff




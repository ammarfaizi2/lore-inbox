Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268445AbUIBQBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268445AbUIBQBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 12:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268442AbUIBQBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 12:01:43 -0400
Received: from the-village.bc.nu ([81.2.110.252]:21647 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268445AbUIBQBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 12:01:42 -0400
Subject: Re: Driver retries disk errors.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Stoffel <stoffel@lucent.com>
Cc: Rogier Wolff <R.E.Wolff@bitwizard.nl>,
       Romano Giannetti <romano@dea.icai.upco.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16695.11922.71461.528204@gargle.gargle.HOWL>
References: <20040830163931.GA4295@bitwizard.nl>
	 <1093952715.32684.12.camel@localhost.localdomain>
	 <20040831135403.GB2854@bitwizard.nl>
	 <1093961570.597.2.camel@localhost.localdomain>
	 <20040831155653.GD17261@harddisk-recovery.com>
	 <1093965233.599.8.camel@localhost.localdomain>
	 <20040831170016.GF17261@harddisk-recovery.com>
	 <1093968767.597.14.camel@localhost.localdomain>
	 <20040901152817.GA4375@pern.dea.icai.upco.es>
	 <1094049877.2787.1.camel@localhost.localdomain>
	 <20040901231434.GD28809@bitwizard.nl>
	 <1094117369.4852.15.camel@localhost.localdomain>
	 <16695.11922.71461.528204@gargle.gargle.HOWL>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094137165.5486.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 15:59:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 15:30, John Stoffel wrote:
> I really think that we need some way to keep such deadlocks from
> happening.  I really dislike having a device lockup a user application
> so hard that it can't be exited.  There's no real reason we should be
> doing this any more.  If we have to, let the user kill it and just
> have the kernel make it into a zombie, but at least let the user kill
> it off.

If you had to reboot file a bug, none of the block error recovery code
or below should ever hang indefinitely.


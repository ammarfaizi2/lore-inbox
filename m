Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUHaQQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUHaQQB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUHaQQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:16:01 -0400
Received: from the-village.bc.nu ([81.2.110.252]:52616 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261239AbUHaQP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:15:58 -0400
Subject: Re: Driver retries disk errors.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <20040831155653.GD17261@harddisk-recovery.com>
References: <20040830163931.GA4295@bitwizard.nl>
	 <1093952715.32684.12.camel@localhost.localdomain>
	 <20040831135403.GB2854@bitwizard.nl>
	 <1093961570.597.2.camel@localhost.localdomain>
	 <20040831155653.GD17261@harddisk-recovery.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093965233.599.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 31 Aug 2004 16:13:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-31 at 16:56, Erik Mouw wrote:
> The SCSI disk driver has been doing a single retry for quite some time
> and it hasn't really bitten people. Why would the IDE disk driver be
> different? The only case I can imagine a retry would be OK, is when we
> get an UDMA CRC error (caused by bad cables).

Retries also pop up in other less obvious cases and conveniently paper
over a wide variety of timeouts, power management quirks and drives just
having a random fit. Eight is probably excessive in all cases.

For non hard disk cases many devices do want and need retry.

Alan


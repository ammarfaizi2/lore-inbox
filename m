Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268693AbUIBQ1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268693AbUIBQ1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 12:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268675AbUIBQ0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 12:26:45 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:41152 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268693AbUIBQ0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 12:26:06 -0400
Message-ID: <311601c90409020926243b2a18@mail.gmail.com>
Date: Thu, 2 Sep 2004 10:26:04 -0600
From: Eric Mudama <edmudama@gmail.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Driver retries disk errors.
Cc: Romano Giannetti <romano@dea.icai.upco.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1094049877.2787.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040830163931.GA4295@bitwizard.nl>
	 <1093952715.32684.12.camel@localhost.localdomain>
	 <20040831135403.GB2854@bitwizard.nl>
	 <1093961570.597.2.camel@localhost.localdomain>
	 <20040831155653.GD17261@harddisk-recovery.com>
	 <1093965233.599.8.camel@localhost.localdomain>
	 <20040831170016.GF17261@harddisk-recovery.com>
	 <1093968767.597.14.camel@localhost.localdomain>
	 <20040901152817.GA4375@pern.dea.icai.upco.es> <1094049877.2787.1.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Sep 2004 15:44:38 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Things like Xine are precisely the cases where you want retry turned off
> by the application - if the sector is bad then you want to skip when
> playing movies, while you don't want to skip while writing out your
> database

This is what they're trying to accomplish with ATA-7 Streaming Feature
Set ... tell the drive to just read through errors and send the
garbage, without doing error recovery, for high bandwidth media
readback.  The first drives to support this feature set will be coming
out relatively soon...

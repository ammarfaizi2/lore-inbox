Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267197AbUIAPrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267197AbUIAPrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267258AbUIAPra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:47:30 -0400
Received: from the-village.bc.nu ([81.2.110.252]:37515 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267197AbUIAPqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:46:48 -0400
Subject: Re: Driver retries disk errors.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Romano Giannetti <romano@dea.icai.upco.es>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040901152817.GA4375@pern.dea.icai.upco.es>
References: <20040830163931.GA4295@bitwizard.nl>
	 <1093952715.32684.12.camel@localhost.localdomain>
	 <20040831135403.GB2854@bitwizard.nl>
	 <1093961570.597.2.camel@localhost.localdomain>
	 <20040831155653.GD17261@harddisk-recovery.com>
	 <1093965233.599.8.camel@localhost.localdomain>
	 <20040831170016.GF17261@harddisk-recovery.com>
	 <1093968767.597.14.camel@localhost.localdomain>
	 <20040901152817.GA4375@pern.dea.icai.upco.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094049877.2787.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 15:44:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 16:28, Romano Giannetti wrote:
> Just a question from a kernel-almost-illiterate. Could this explain the
> behavior of my laptop yesterday, reading a damaged DVD? I had to wait almost
> one full minute of retry until being able to kill xine... 

Thats the block layer. Its actually hard to fix the kill -9 case.

> If maintaining the retries, it could be nice to allow at least kill -9
> between them. I do not know if that's foolish and/or impossible, so please
> do not bash too hard... 

Things like Xine are precisely the cases where you want retry turned off
by the application - if the sector is bad then you want to skip when
playing movies, while you don't want to skip while writing out your
database


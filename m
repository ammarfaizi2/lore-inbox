Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274986AbTHSQSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270754AbTHSQQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:16:05 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53499 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S271118AbTHSQNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:13:12 -0400
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m33cfyt3x6.fsf@trained-monkey.org>
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	 <20030818111522.A12835@devserv.devel.redhat.com>
	 <m33cfyt3x6.fsf@trained-monkey.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 19 Aug 2003 14:07:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-19 at 10:03, Jes Sorensen wrote:
> That would be totally messy. Having drivers do the accounting of what
> mask is currently set and have them switch back and forth depending on
> what type of allocation is currently being used would be a nightmare
> to debug.

It is messy, but the consistent mask only helps a small subset of cases.
Having an __pci_alloc_foo that took the mask as an argument is (a)
trivial (b) adds almost no code  (c) solves the general case problem.



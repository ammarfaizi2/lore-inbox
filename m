Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030524AbWJKOxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbWJKOxt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030552AbWJKOxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:53:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31447 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030524AbWJKOxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:53:48 -0400
Subject: Re: most users of msleep_interruptible are broken
From: Arjan van de Ven <arjan@infradead.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Matthew Wilcox <matthew@wil.cx>, Amol Lad <amol@verismonetworks.com>,
       kernel Janitors <kernel-janitors@lists.osdl.org>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <452CFD98.6010808@drzeus.cx>
References: <1160570743.19143.307.camel@amol.verismonetworks.com>
	 <1160571491.3000.372.camel@laptopd505.fenrus.org>
	 <20061011141651.GD27388@parisc-linux.org>  <452CFD98.6010808@drzeus.cx>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 11 Oct 2006 16:53:35 +0200
Message-Id: <1160578415.3000.381.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 16:20 +0200, Pierre Ossman wrote:
> Matthew Wilcox wrote:
> > 
> > They clearly don't care about exactness; they msleep_interruptible and
> > throw away the return value, so they don't know how long they slept
> > before they got a signal.
> > 
> 
> It's broken then. That delay function should delay at least the amount
> given.


if you want that don't use the _interruptible variant. It's that simple.



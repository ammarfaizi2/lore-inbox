Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbTJIRHY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 13:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTJIRHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 13:07:24 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:16820 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262286AbTJIRHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 13:07:23 -0400
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F8594CD.1030504@pobox.com>
References: <3F858885.1070202@colorfullife.com> <3F858EF8.5080105@pobox.com>
	 <1065718629.663.3.camel@gaston>  <3F8594CD.1030504@pobox.com>
Content-Type: text/plain
Message-Id: <1065719227.663.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 09 Oct 2003 19:07:07 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-09 at 19:03, Jeff Garzik wrote:

> Easily solved with a synchronize_irq()  ;-)

No. synchronize_irq will do nothing to an irq that is
still somewhere in the HW path from the device to the core,
and even in the core it may be queued for some cycles before
actually delivered.




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271670AbTGRBif (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 21:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271671AbTGRBif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 21:38:35 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:25363 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S271670AbTGRBif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 21:38:35 -0400
Date: Fri, 18 Jul 2003 11:53:06 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jim Keniston <jkenisto@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       <jgarzik@pobox.com>, <alan@lxorguk.ukuu.org.uk>, <rddunlap@osdl.org>,
       <kuznet@ms2.inr.ac.ru>
Subject: Re: [PATCH] [1/2] kernel error reporting (revised)
In-Reply-To: <3F16F54C.949A9299@us.ibm.com>
Message-ID: <Mutt.LNX.4.44.0307181148340.5813-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003, Jim Keniston wrote:

> 3. Given the above, what should the evlog.c caller do when
> kernel_error_event_iov() returns -EINPROGRESS?
> a. Nothing.  Figure the packet will probably get logged.
> b. Just to be safe, report it via printk, the same way we report dropped
> packets.
> We currently do (a).  (b) would mean that every event logged from IRQ
> context would be cc-ed to printk.

I don't think this irq detection logic should be added at all here, let 
the caller reschedule its logging if running in irq context.


- James
-- 
James Morris
<jmorris@intercode.com.au>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268198AbTGIL0e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 07:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268201AbTGIL0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 07:26:33 -0400
Received: from ns.suse.de ([213.95.15.193]:2318 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268198AbTGIL0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 07:26:32 -0400
Date: Wed, 9 Jul 2003 13:41:09 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Readd BUG for SMP TLB IPI
Message-Id: <20030709134109.65efa245.ak@suse.de>
In-Reply-To: <1057750022.6255.41.camel@dhcp22.swansea.linux.org.uk>
References: <20030709124915.3d98054b.ak@suse.de>
	<1057750022.6255.41.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Jul 2003 12:27:02 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> We have recorded retransmitted IPI's on some boards (notably the
> infamous BP6). They do happen. Early 2.4 had a fix for handling the
> replay case too, but someone lost it and BP6 boards no longer work as
> reliably.

Ok, all non broken hardware.

> 
> An IPI can be retried and the retry for dual PII at least seems to hit
> all the CPUs. Even on a 2 CPU box this has been observed - I assume
> because the error was raised by the IO APIC when it got a garbled IPI.

I don't believe it. It would cause an immediate hang because the goto out
does not ack the IPI.  Surely such hangs would have been reported?

-Andi

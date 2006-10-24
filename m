Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbWJXN66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbWJXN66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 09:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWJXN66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 09:58:58 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60349 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965146AbWJXN65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 09:58:57 -0400
Subject: Re: FDDI on Linux kernel 2.6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wouter de Waal <wrm@ccii.co.za>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.0.0.25.2.20061024131939.05e4de70@alpha.ccii.co.za>
References: <5.0.0.25.2.20061024131939.05e4de70@alpha.ccii.co.za>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Oct 2006 15:02:00 +0100
Message-Id: <1161698520.22348.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-24 am 13:19 +0200, ysgrifennodd Wouter de Waal:
> We here at CCII Systems are probably the only company in the world still
> actively involved with FDDI. The Linux Syskonnect FDDI driver needs a
> patch. I have no idea who to speak to, but the g over at osdl said I
> must ask here.

This is the right starting point. There is a network development list
that might be better but I think essentially you might as well own the
driver if nobody else is laying any claim to it any more. 

> The second customer's problem could not be solved by the above. They
> eventually found that kernel 2.6 (specifically, 2.6.8) uses memory
> mapping, and that a check in the driver caused an exception because
> of the length of the PCI region being 2048 and not 16384 (0x4000).
> The customer reports that changing the compare to
> 
> >if (len < 2048) {
> 
> fixed the problem for them.
> 
> Can this patch be applied to the kernel please?

I suspect the correct check is (len < FP_IO_LEN)

Either you or your customer can send patches versus a current kernel to
update the driver.

Alan


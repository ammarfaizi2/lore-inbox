Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265633AbUA0QjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 11:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUA0QjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 11:39:18 -0500
Received: from CPE0080c6f0a1ca-CM014280009361.cpe.net.cable.rogers.com ([24.157.199.55]:10500
	"EHLO stargazer") by vger.kernel.org with ESMTP id S265633AbUA0QjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 11:39:16 -0500
Date: Tue, 27 Jan 2004 11:41:54 -0500
From: Glenn Wurster <gwurster@scs.carleton.ca>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Glenn Wurster <gwurster@scs.carleton.ca>, Alan Cox <alan@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: [PATCH] ide-dma.c, ide.c, ide.h, kernel 2.4.24
Message-ID: <20040127164154.GB1024@desktop>
References: <20040123183245.GB853@desktop> <200401240045.56966.bzolnier@elka.pw.edu.pl> <20040127055206.GA690@electric.ath.cx> <200401271614.40542.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401271614.40542.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Doh.  I overlooked one place.
> IMO this check needs to be added only to two places.

True, I added the check three times to emphasise the three different
calls which could potentially OOPS (at least upon initial
observation).  It could be optimized into 2 checks.

> Did you test this patch?

Yes.

> I've seen this and decided that it is not needed.
> 
> If we try to program drives to DMA on non-DMA host
> something is going wrong and it is better to just OOPS.

This makes sense.  Did you want to update the patch for those proposed
changes (You're more familiar with the code than I - I'm reluctant to
play too much with code unless I understand what it is doing)?  I'd be
willing to test an updated patch.

> I suspect that this is caused by unfinished handling of simplex
> devices in setup-pci.c (simplex host - one DMA engine but two
> channels).

I'm really not familiar with the complexities behind DMA
programming, especially when it comes to simplex devices so I'm
probably not in much of a position to finish up handling of simplex
devices.

Glenn.

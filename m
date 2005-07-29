Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbVG2NP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVG2NP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 09:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVG2NP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 09:15:57 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:9949 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262055AbVG2NPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 09:15:53 -0400
Subject: Re: [RFC][PATCH] libata ATAPI alignment
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
In-Reply-To: <20050729050654.GA10413@havoc.gtf.org>
References: <20050729050654.GA10413@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Jul 2005 14:38:54 +0100
Message-Id: <1122644334.13581.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-07-29 at 01:06 -0400, Jeff Garzik wrote:
> So, one thing that's terribly ugly about SATA ATAPI is that we need to
> pad DMA transfers to the next 32-bit boundary, if the length is not
> evenly divisible by 4.

Looks good and avoids the special case leaking into the core code.

> Complicating matters, we currently must support two methods of data
> buffer submission:  a single kernel virtual address, or a struct
> scatterlist.

For the moment - also you turn the single buffer into a one entry sglist
so its not to bad.

> Review is requested by any and all parties, as well as suggestions for
> a prettier approach.

I'd pull the code into seperate functions but thats my only real
comment.

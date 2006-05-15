Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWEORHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWEORHQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWEORHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:07:15 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60066 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964983AbWEORHN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:07:13 -0400
Subject: Re: [RFT] major libata update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
In-Reply-To: <20060515170006.GA29555@havoc.gtf.org>
References: <20060515170006.GA29555@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 18:19:27 +0100
Message-Id: <1147713568.26686.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 13:00 -0400, Jeff Garzik wrote:
> * PIO-based I/O is now IRQ-driven by default, rather than polled
>   in a kernel thread.  The polling path will continue to exist for
>   controllers that need it, and other special cases. (Albert Lee)

How will this be selected ? Passing ->irq = 0 ?

For ata_piix given you've destabilized it a bit would now be a good time
to submit the patches to fix the timing, register scribble and incorrect
ATAPI caching ?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933848AbWKWQG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933848AbWKWQG1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933846AbWKWQG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:06:26 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:45579 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S933852AbWKWQGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:06:25 -0500
Date: Thu, 23 Nov 2006 16:06:17 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Kill dma_is_consistent()
Message-ID: <20061123160617.GC8984@flint.arm.linux.org.uk>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20061123150312.GA32406@linux-mips.org> <1164297574.2829.9.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164297574.2829.9.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 09:59:33AM -0600, James Bottomley wrote:
> On Thu, 2006-11-23 at 15:03 +0000, Ralf Baechle wrote:
> > dma_is_consistent() is ill-designed in that it does not have a struct device
> > argument which makes proper support for systems that consist of a mix of
> > coherent and non-coherent DMA devices hard.
> 
> At the time the interface was designed, the general consensus was that
> it was easier to recognise incoherent memory regions by their address
> range than by which device they came from.  The main proponent of this
> being arm, if I remember rightly.

I don't remember that being particularly discussed, and it seems that
no one has implemented it (but possibly implemented their own stuff
in arch private code.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:

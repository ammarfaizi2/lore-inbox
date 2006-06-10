Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWFJQbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWFJQbT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbWFJQbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:31:19 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:8365 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751600AbWFJQbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:31:18 -0400
Subject: Re: [PATCH] Promise 'stex' driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, promise_linux@promise.com
In-Reply-To: <20060610161036.GA21454@infradead.org>
References: <20060610160852.GA15316@havoc.gtf.org>
	 <20060610161036.GA21454@infradead.org>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 11:29:12 -0500
Message-Id: <1149956952.3335.22.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 17:10 +0100, Christoph Hellwig wrote:
> The driver is not for scsi hardware.  Please implement it as block
> driver.

Actually, I'm afraid it is ... look at the mailbox path ... it's one of
these increasingly prevalent raid HBAs that speaks SCSI at the firmware
level.  Most commands are direct passthroughs, only INQUIRY and
MODE_SENSE are actually emulated in the driver.

James



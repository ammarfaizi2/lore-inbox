Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbVKKWyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVKKWyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 17:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVKKWyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 17:54:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30913 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751304AbVKKWyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 17:54:51 -0500
Date: Fri, 11 Nov 2005 14:54:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] final pre -rc pieces of SCSI for 2.6.14
In-Reply-To: <20051111222341.GA20077@infradead.org>
Message-ID: <Pine.LNX.4.64.0511111454140.3228@g5.osdl.org>
References: <1131745742.3505.47.camel@mulgrave> <20051111222341.GA20077@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Nov 2005, Christoph Hellwig wrote:
>
> On Fri, Nov 11, 2005 at 03:49:01PM -0600, James Bottomley wrote:
> >   o remove scsi_wait_req
> 
> This requires '[PATCH] kill libata scsi_wait_req usage (make libata compile in
> scsi-misc)' from Mike, because libata started to use this function in mainline
> about the same time it was removed in scsi-misc.

Yeah, I get

	drivers/built-in.o(.text+0x12e68c): In function `.ata_cmd_ioctl':
	: undefined reference to `.scsi_wait_req'
	drivers/built-in.o(.text+0x12e85c): In function `.ata_task_ioctl':
	: undefined reference to `.scsi_wait_req'

right now. Can somebody forward that patch to me..

		Linus

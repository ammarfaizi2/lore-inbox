Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbTEZFqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTEZFqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:46:08 -0400
Received: from AMarseille-201-1-3-168.w193-253.abo.wanadoo.fr ([193.253.250.168]:10791
	"EHLO gaston") by vger.kernel.org with ESMTP id S264276AbTEZFqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:46:06 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030526045833.GA27204@gtf.org>
References: <20030526045833.GA27204@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053928747.602.41.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 07:59:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-26 at 06:58, Jeff Garzik wrote:
> Just to echo some comments I said in private, this driver is _not_
> a replacement for drivers/ide.  This is not, and has never been,
> the intention.  In fact, I need drivers/ide's continued existence,
> so that I may have fewer boundaries on future development.
> 
> Even though ATAPI support doesn't exist and error handling is
> primitive, this driver has been extensively tested locally and I feel
> is ready for a full and public kernel developer assault :)
> 
> James ok'd sending this...  I'll be sending "un-hack scsi headers" patch
> through him via his scsi-misc-2.5 tree.

Btw, Jeff, while I agree about not boring about old PATA hardware,
I'd still like to see support for MDMA modes in there. For once,
there is no real difference in supporting both UDMA and MDMA, it's
really just a matter of extending the range of the "mode" parameter,
and I'd like to be able to use the driver on configs like pmacs which
typically have a U/DMA capable channel for the internal HD and one
MDMA only channel (ATAPI CD/DVD, ZIP) without having to play bad tricks
to get both drivers up.

Ben.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935679AbWK1Ijd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935679AbWK1Ijd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 03:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757252AbWK1Ijd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 03:39:33 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:63617 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1756991AbWK1Ijc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 03:39:32 -0500
Message-ID: <456BF5C1.9010506@garzik.org>
Date: Tue, 28 Nov 2006 03:39:29 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Nicolas.Mailhot@LaPoste.net
Subject: Re: [PATCH -mm] sata_nv: fix ATAPI in ADMA mode
References: <4569F703.8010209@shaw.ca>
In-Reply-To: <4569F703.8010209@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> The attached patch against 2.6.19-rc6-mm1 fixes some problems in sata_nv 
> with ATAPI devices on controllers running in ADMA mode. Some of the 
> logic in the nv_adma_bmdma_* functions was inverted causing a bunch of 
> warnings and caused those functions not to work properly. Also, when an 
> ATAPI device is connected, we need to use the legacy DMA engine. The 
> code now disables the PCI configuration register bits for ADMA so that 
> this works, and ensures that no ATAPI DMA commands go through until this 
> is done.
> 
> Fixes Bugzilla http://bugzilla.kernel.org/show_bug.cgi?id=7538
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

applied

In the future, please use "---" not "--" as the separator your .sig, so 
that it is not copied into the kernel changelog by git-applymbox.

also, please avoid MIME attachments and include the patch inline.



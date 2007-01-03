Return-Path: <linux-kernel-owner+w=401wt.eu-S1752651AbXACBCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbXACBCm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbXACBCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:02:42 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:48325 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbXACBCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:02:41 -0500
Message-ID: <459B00AB.3090004@pobox.com>
Date: Tue, 02 Jan 2007 20:02:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org> <5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com> <Pine.LNX.4.64.0701011209140.4473@woody.osdl.org> <459973F6.2090201@pobox.com> <20070102115834.1e7644b2@localhost.localdomain> <459AC808.1030807@pobox.com> <20070102212701.4b4535cf@localhost.localdomain> <459ACE9C.7020107@pobox.com> <20070102224559.2089d28d@localhost.localdomain> <459AE459.8030107@pobox.com> <20070102232706.49340349@localhost.localdomain> <459AEE36.7080500@pobox.com> <20070103003635.626cdfb3@localhost.localdomain>
In-Reply-To: <20070103003635.626cdfb3@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> Once combined mode is fixed not to abuse resources (and it originally
> did it that way for a good reason I grant and am not criticising that) the
> entire management for legacy mode, mixed mode and native mode resources
> for an ATA device (including 0x170, 0x3F6 and other wacky magic) becomes
> 
> 	if (pci_request_regions(pdev, "libata")) ...

> Make sense ?

Yes.  For 2.6.21.  As I've always said.

But for 2.6.20, we are only HALFWAY there, and all these /new/ bugs 
exist as a result.

Your patch makes far more sense for 2.6.21, where the "halfway to 
salvation" state, and associated rough edges, is not exposed to users.

Fixing the resource tree was only half the solution, since the drivers 
that /use/ the resource tree now need updating.

	Jeff



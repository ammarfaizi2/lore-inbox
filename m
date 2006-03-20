Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWCTQ3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWCTQ3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWCTQ3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:29:15 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28832 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751146AbWCTQ3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:29:13 -0500
Subject: Re: [git patches] libata updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060320111658.GA16172@havoc.gtf.org>
References: <20060320111658.GA16172@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Mar 2006 16:35:56 +0000
Message-Id: <1142872556.21455.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-20 at 06:16 -0500, Jeff Garzik wrote:
> Jeff Garzik:
>       [libata] Move PCI IDE BMDMA-related code to new file libata-bmdma.c.

This is a most confusing choice as 80% of the file has nothing to do
with bus mastering DMA, and a large amount of it has nothing to do with
PCI either. Also lots of DMA stuff is in the drivers so all the new bus
mastering drivers don't use bmdma.c

The split makes sense, the choice of name is peculiar, if not completely
broken 8)

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWEOPrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWEOPrG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWEOPrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:47:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52158 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751500AbWEOPrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:47:04 -0400
Subject: Re: Assorted bugs in the PIIX drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <44689A54.4020307@ru.mvista.com>
References: <1132929808.3298.18.camel@localhost.localdomain>
	 <44689A54.4020307@ru.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 16:59:43 +0100
Message-Id: <1147708783.26686.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 19:12 +0400, Sergei Shtylyov wrote:
>     For PIO2+ actually, according to Intel's PRM (29860004.pdf), and it's said
> to have no effect in the lower modes. This is actually not very correct since
> when one issues Set Transfer Mode ATA command with the value (8 + PIOn), this
> means select PIO _flow control_ mode n, so -IORDY is assumed to be in use.

PIO2 depends on the drive (there is a drive parameter telling you the
highest timing clock you can do with/without IORDY

> > I'm also not clear if the "no MWDMA0" list has been updated correctly
> > for the newer chipsets.
> 
>     What is/was the point for keeping MW DMA 0 support anyway? On PIIX, it's
> greatly slowed down (600 vs 480 ns cycle) and was never "offically" supported
> by Intel.

Some old old drives only do MWDMA0. The Intel docs I have here don't
describe it in any way as "unsupported", merely broken on some ICH
variants.

Alan


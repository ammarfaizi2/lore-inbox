Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265476AbUFIA3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbUFIA3u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 20:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265482AbUFIA3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 20:29:50 -0400
Received: from [213.146.154.40] ([213.146.154.40]:16619 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265476AbUFIA3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 20:29:47 -0400
Subject: Re: [PATCH] fix warnings in drivers/mtd/devices/doc200?.c
From: David Woodhouse <dwmw2@infradead.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0406090205170.25359@jjulnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0406090205170.25359@jjulnx.backbone.dif.dk>
Content-Type: text/plain
Date: Wed, 09 Jun 2004 01:29:41 +0100
Message-Id: <1086740981.5459.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 02:24 +0200, Jesper Juhl wrote:
> I must admit that I do not know what the purpose of "oobsel" is, nor do I
> know very much about these functions or mtd devices in general, but since
> the doc_*_ecc functions do not use the oobsel parameter at all I still
> think I can propose a safe fix by simply changing the functions to take a
> struct nand_oobinfo *  argument instead of their current  int  argument.
> Comments??

That works, but please don't do it without also adding something like:

#warning This driver should be updated to the new ECC API.

Or you could just leave the warning we already have :)

It works at the moment because the only thing that _uses_ the driver in
question is something which also doesn't use the new argument. We're
working on a new driver and at that point we'll also update the code
which uses it.

-- 
dwmw2


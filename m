Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265692AbUFIK1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbUFIK1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 06:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265574AbUFIK1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 06:27:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14751 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265692AbUFIK1a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 06:27:30 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH] tiny patch to kill warning in drivers/ide/ide.c
Date: Wed, 9 Jun 2004 12:31:20 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <Pine.LNX.4.56.0406090335260.25359@jjulnx.backbone.dif.dk>
In-Reply-To: <Pine.LNX.4.56.0406090335260.25359@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406091231.20049.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 of June 2004 03:38, Jesper Juhl wrote:
> To kill this warning :
>
> drivers/ide/ide.c: In function `ide_unregister_subdriver':
> drivers/ide/ide.c:2216: warning: implicit declaration of function
> `pnpide_init'
>
> I added a simple declaration of pnpide_init to drivers/ide/ide.c
>
> Here's a patch against 2.6.7-rc3 - please consider including it (or if
> that's not the way to do it, then don't) :)

Thanks but the real bug is to call pnpide_init() from
ide_unregister_subdriver(), I'll push ide-pnp update soon.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWCLBlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWCLBlJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 20:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWCLBlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 20:41:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8682 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751437AbWCLBlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 20:41:08 -0500
Date: Sat, 11 Mar 2006 17:38:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: kay.sievers@vrfy.org, ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-Id: <20060311173847.23838981.akpm@osdl.org>
In-Reply-To: <4412F53B.5010309@drzeus.cx>
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx>
	<20060301194532.GB25907@vrfy.org>
	<4406AF27.9040700@drzeus.cx>
	<20060302165816.GA13127@vrfy.org>
	<44082E14.5010201@drzeus.cx>
	<4412F53B.5010309@drzeus.cx>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>
>  Here is a patch for doing multi line modalias for PNP devices. This will
>  break udev, so that needs to be updated first.
> 
>  I had a longer look at the card part and it seems that module aliases
>  cannot be reliably used for it. Not without restructuring the system at
>  least. The possible combinations explode when you notice that the driver
>  ids needs to be just at subset of the card, without any ordering.
> 
>  If I got my calculations right, a PNP card would have to have roughly
>  2^(2n) aliases, where n is the number of device ids. So right now, I
>  lean towards only adding modalias support for the non-card part of the
>  PNP layer.
> 
>  Andrew, do you want a fix for the patch in -mm or can you remove the
>  part of it that modifies drivers/pnp/card.c by yourself?

I assume you mean that the drivers/pnp/card.c patch of
pnp-modalias-sysfs-export.patch needs to be removed and this patch applies
on top of the result.

But I don't want to break udev.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSGDRq6>; Thu, 4 Jul 2002 13:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSGDRq5>; Thu, 4 Jul 2002 13:46:57 -0400
Received: from [217.167.51.129] ([217.167.51.129]:25567 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S313181AbSGDRq5>;
	Thu, 4 Jul 2002 13:46:57 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.24 IDE 97
Date: Thu, 4 Jul 2002 19:51:25 +0200
Message-Id: <20020704175126.29120@192.168.4.1>
In-Reply-To: <Pine.SOL.4.30.0207041940310.28459-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0207041940310.28459-100000@mion.elka.pw.edu.pl>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>My tuning scheme satisfies your both demands, by ch->dma_base,
>ch->autodma and ch->modes_map host informs generic code about its
>capabilities.

Just keep in mind that some chipsets don't use dma_base
but still can do DMA (typically ide-pmac, and some embedded
controllers). They do DMA their own way, not using the PRD
tables. Actually, I would love beeing able to use that same
dma_base (and others) fields for my own stuffs, but the common
layer, last I looked at it, still does assumptions that when
those are filled, they match a legacy controller.

Ben.



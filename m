Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWEPPkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWEPPkT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWEPPkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:40:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35504 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751269AbWEPPkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:40:17 -0400
Subject: Re: PATCH: Fix broken PIO with libata
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kevin Radloff <radsaq@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3b0ffc1f0605160833k5f6355c5n3f2a9ab1b211a95@mail.gmail.com>
References: <1147790393.2151.62.camel@localhost.localdomain>
	 <3b0ffc1f0605160833k5f6355c5n3f2a9ab1b211a95@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 May 2006 16:53:11 +0100
Message-Id: <1147794791.2151.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-16 at 11:33 -0400, Kevin Radloff wrote:
> However, I still have a problem with pata_pcmcia (that I actually
> experienced also with the ide-cs driver) where sustained reading or
> writing to the CF card spikes the CPU with nearly 100% system time.

That is normal. The PCMCIA devices don't support DMA. As a result of
this the processor has to fetch each byte itself over the ISA speed
PCMCIA bus link.

Alan


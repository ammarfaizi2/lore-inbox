Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWEPRKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWEPRKx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWEPRKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:10:53 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:39558 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932158AbWEPRKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:10:52 -0400
Message-ID: <446A0796.5030606@pobox.com>
Date: Tue, 16 May 2006 13:10:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: PATCH: Fix broken PIO with libata
References: <1147790393.2151.62.camel@localhost.localdomain> <4469F169.2050708@gmail.com>
In-Reply-To: <4469F169.2050708@gmail.com>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Alan Cox wrote:
>> #2	The core sets ATA_DFLAG_PIO to indicate PIO commands should be used
>> on this channel. This same information is available in dev->dma_mode but
>> for some reason we get two sources of the info. The ATA_DFLAG_PIO is set
>> once during setup and then cleared but not re-computed by the revalidate
>> function. This causes DMA commands to be issued when PIO would be and
>> usually an Oops or hang
> 
> Hmmm... I tried to fix this problem in the following commit.  With it,
> ATA_DFLAG_PIO isn't cleared over ata_dev_configure().  Only
> ata_dev_set_mode() is allowed to diddle with it and does about the same
> thing as your patch does.

I presume he's looking at what users will hit when 2.6.17 is released...

	Jeff




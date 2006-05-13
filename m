Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWEMPZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWEMPZn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 11:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWEMPZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 11:25:43 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:64391 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751302AbWEMPZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 11:25:43 -0400
Message-ID: <4465FA85.1000605@drzeus.cx>
Date: Sat, 13 May 2006 17:25:57 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, sdhci-devel@list.drzeus.cx
Subject: Re: [Sdhci-devel] sdhci needs card to be present when loading module.
References: <20060512232940.GA30610@kroah.com>
In-Reply-To: <20060512232940.GA30610@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> In the 2.6.17-rc4 kernel (and 2.6.17-rc1), on my laptop, if you load the
> sdhci driver with no SD card in the slot, it never seems to be able to
> detect the insertion of a new card later on.
> 
> However, if I load the module with a card present.  Removing it and then
> plugging it (or another one) in later seems to work just fine.
> 
> Is this expected?
> 

No, this is a bug (hardware probably as I cannot find anything in the
specs that can even be remotely related). The chances of getting any
help from the manufacturer are slim at best. I've already contacted all
the major ones and requested erratas, but so far not a single reply.

> Any kernel log messages I can provide to help with this?

Not really, no. Since I assume this controller works fine in Windows,
I'm guessing it needs a very particular init sequence. It might have
something to do with the ios calls that are made when the slot is empty.

If you have the time, you could try adding some code that will make the
driver ignore ios calls until a card is inserted.

Rgds
Pierre


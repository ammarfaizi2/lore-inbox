Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVFEODE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVFEODE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 10:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVFEODE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 10:03:04 -0400
Received: from [85.8.12.41] ([85.8.12.41]:55730 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261569AbVFEODC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 10:03:02 -0400
Message-ID: <42A3061C.7010604@drzeus.cx>
Date: Sun, 05 Jun 2005 16:03:08 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ISA DMA controller hangs
References: <42987450.9000601@drzeus.cx> <1117288285.2685.10.camel@localhost.localdomain> <42A2B610.1020408@drzeus.cx>
In-Reply-To: <42A2B610.1020408@drzeus.cx>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> 
> I added some debug output to the driver, dumping the DMA controller's
> registers before and after suspend and it seems it goes completely
> apeshit. The registers are filled with, what it seems, random data. The
> reason it stops working seems to be that channel 4 gets disabled killing
> the cascaded channels. I'm going to try and confirm this today.
> 

Confirmed. By explicitly reenabling DMA channel 4 in the driver on
resumt the DMA transfers work fine.

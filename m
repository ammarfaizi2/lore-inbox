Return-Path: <linux-kernel-owner+w=401wt.eu-S1161333AbXAHQNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161333AbXAHQNl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 11:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161334AbXAHQNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 11:13:41 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:55486 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161333AbXAHQNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 11:13:40 -0500
Message-ID: <45A26DB0.8090106@pobox.com>
Date: Mon, 08 Jan 2007 11:13:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, uwe.koziolek@gmx.net
Subject: Re: [PATCH] sata_sis: Support for PATA supports
References: <20070108161107.121f196b@localhost.localdomain>
In-Reply-To: <20070108161107.121f196b@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> This is quick rework of the patch Uwe proposed but using Kconfig not
> ifdefs and user selection to sort out PATA support. Instead of ifdefs and
> requiring the user to select both drivers the SATA driver selects the
> PATA one.
> 
> For neatness I've also moved the extern into the function that uses it.
> 
> Two questions really
> 1.	Do you want the extern in a header file

not for an atom so small.

When I mentioned header files (if this was the genesis of your 
question), I intentionally referred to sata_promise.h as an example of 
sharing /code/ between two drivers.


> 2.	Is this now neat enough to keep you happy Jeff or shall I do
> the library split anyway ?

It's still ugly relying on an unused driver like this, but this 
[current] revision is clean enough that I'll go ahead and apply this patch.

	Jeff



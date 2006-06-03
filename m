Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbWFCVLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWFCVLa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 17:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWFCVLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 17:11:30 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:51594 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1030362AbWFCVL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 17:11:29 -0400
Message-ID: <4481FAFF.4000005@drzeus.cx>
Date: Sat, 03 Jun 2006 23:11:27 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2GB MMC/SD cards
References: <447AFE7A.3070401@drzeus.cx> <20060603141548.GA31182@flint.arm.linux.org.uk>
In-Reply-To: <20060603141548.GA31182@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> The specs I have say the following about WRITE_BL_PARTIAL:
>
> Samsung (csd v1.2 mmc v4.1):
> 0: means that only the WRITE_BL_LEN block size can be used for block oriented data write.
> 1: means that smaller blocks can be used as well. The minimum block size is one byte.
>
> Sandisk (csd v1.1 mmc v1.4):
> 0: means that only the WRITE_BL_LEN block size can be used for block oriented data write.
> 1: means that smaller blocks can be used as well. The minimum block size is one byte.
>
> The wording is identical from these two differing manufacturers, so I
> suspect it comes from the original spec.
>
>   

A sponsored copy of the official spec. is long overdue...

> I am not aware of any bug reports in this area, so I can't comment.  In
> fact, I see very few reports of MMC problems at all, so I just assume
> that it merely works.  Unless folk report bugs to me...
>   

For some reason, I get lots. :)
It's probably because I am the maintainer for the only two drivers for
hardware that is found in laptops. More average Joes in that market.

Like you, I unfortunately haven't got any of these cards for myself. But
I've gotten reports of both that "other" readers use 512 bytes[1],
regardless of WRITE_BL_LEN, and that cards that have WRITE_BL_LEN of
1024 and _not_ partial, still work just fine with 512 bytes[2].

[1] http://list.hades.drzeus.cx/pipermail/wbsd-devel/2006-May/000485.html
[2] http://list.drzeus.cx/pipermail/sdhci-devel/2006-May/000826.html

> I don't know what to do about this since I don't have any cards and
> I've not seen any bug reports to investigate what's going on.  So I'm
> just going to say "the code as it stands is correct as to my best
> knowledge, please provide details of it's failings."
>
>   

I'll point people to your patch then and ask them to have you as a cc.

Rgds
Pierre

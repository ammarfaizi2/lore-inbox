Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVBORDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVBORDc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVBORDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:03:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7864 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261792AbVBOQwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 11:52:22 -0500
Message-ID: <421228B7.2060204@pobox.com>
Date: Tue, 15 Feb 2005 11:52:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Witold Krecicki <adasi@kernel.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: sil_blacklist - are all those entries necessary?
References: <200502151706.04846.adasi@kernel.pl>
In-Reply-To: <200502151706.04846.adasi@kernel.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Witold Krecicki wrote:
> in sata_sil.c there is:
> sil_blacklist [] = {
>         { "ST320012AS",         SIL_QUIRK_MOD15WRITE },
>         { "ST330013AS",         SIL_QUIRK_MOD15WRITE },
>         { "ST340017AS",         SIL_QUIRK_MOD15WRITE },
>         { "ST360015AS",         SIL_QUIRK_MOD15WRITE },
>         { "ST380023AS",         SIL_QUIRK_MOD15WRITE },
>         { "ST3120023AS",        SIL_QUIRK_MOD15WRITE },
>         { "ST3160023AS",        SIL_QUIRK_MOD15WRITE },
>         { "ST3120026AS",        SIL_QUIRK_MOD15WRITE },
>         { "ST340014ASL",        SIL_QUIRK_MOD15WRITE },
>         { "ST360014ASL",        SIL_QUIRK_MOD15WRITE },
>         { "ST380011ASL",        SIL_QUIRK_MOD15WRITE },
>         { "ST3120022ASL",       SIL_QUIRK_MOD15WRITE },
>         { "ST3160021ASL",       SIL_QUIRK_MOD15WRITE },
>         { "Maxtor 4D060H3",     SIL_QUIRK_UDMA5MAX },
>         { }
> };
> I've got ST3120026AS and I've been using it with SIL3112 without this hack for 
> a long time - without any negative effects. The same impression on 
> ST3200822AS - is there any way to check if it is REALLY necessary? 15MB/s is 
> not what I'd expect on SATA...

It's necessary until we can prove otherwise.  Simply running well 
without your drive in the blacklist means nothing -- you just haven't 
hit the error condition yet.

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVBQBAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVBQBAT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 20:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVBQBAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 20:00:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50605 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262174AbVBQBAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 20:00:10 -0500
Message-ID: <4213EC86.9020108@pobox.com>
Date: Wed, 16 Feb 2005 19:59:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Witold Krecicki <adasi@kernel.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: sil_blacklist - are all those entries necessary?
References: <200502151706.04846.adasi@kernel.pl> <421228B7.2060204@pobox.com> <200502152129.11236.adasi@kernel.pl> <200502170143.00817.adasi@kernel.pl>
In-Reply-To: <200502170143.00817.adasi@kernel.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Witold Krecicki wrote:
> Dnia wtorek 15 luty 2005 21:29, napisa³e¶:
> 
>>Dnia wtorek 15 luty 2005 17:52, napisa³e¶:
>>
>>>Witold Krecicki wrote:
>>>
>>>>in sata_sil.c there is:
>>>>sil_blacklist [] = {
>>>>        { "ST320012AS",         SIL_QUIRK_MOD15WRITE },
>>>>        { "ST330013AS",         SIL_QUIRK_MOD15WRITE },
>>>>        { "ST340017AS",         SIL_QUIRK_MOD15WRITE },
>>>>        { "ST360015AS",         SIL_QUIRK_MOD15WRITE },
>>>>        { "ST380023AS",         SIL_QUIRK_MOD15WRITE },
>>>>        { "ST3120023AS",        SIL_QUIRK_MOD15WRITE },
>>>>        { "ST3160023AS",        SIL_QUIRK_MOD15WRITE },
>>>>        { "ST3120026AS",        SIL_QUIRK_MOD15WRITE },
>>>>        { "ST340014ASL",        SIL_QUIRK_MOD15WRITE },
>>>>        { "ST360014ASL",        SIL_QUIRK_MOD15WRITE },
>>>>        { "ST380011ASL",        SIL_QUIRK_MOD15WRITE },
>>>>        { "ST3120022ASL",       SIL_QUIRK_MOD15WRITE },
>>>>        { "ST3160021ASL",       SIL_QUIRK_MOD15WRITE },
>>>>        { "Maxtor 4D060H3",     SIL_QUIRK_UDMA5MAX },
>>>>        { }
>>>>};
>>>>I've got ST3120026AS and I've been using it with SIL3112 without this
>>>>hack for a long time - without any negative effects. The same
>>>>impression on ST3200822AS - is there any way to check if it is REALLY
>>>>necessary? 15MB/s is not what I'd expect on SATA...
>>>
>>>It's necessary until we can prove otherwise.  Simply running well
>>>without your drive in the blacklist means nothing -- you just haven't
>>>hit the error condition yet.
>>
>>So how can I proove it? Are there any tests? It's been running for over a
>>year, almost 24/7 and nothing...
> 
> Still no response - so again:
> is there ANY way to test if this hack is necessary for specific model of a 
> disk?

You need a bus analyzer, and need to test different sizes of FIS's.  If 
all possible sizes (2048 combinations) work on your device, the 
blacklist entry is not needed.

	Jeff



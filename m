Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWBZSnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWBZSnT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 13:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWBZSnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 13:43:19 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:46372 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751388AbWBZSnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 13:43:18 -0500
Date: Sun, 26 Feb 2006 12:43:06 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: hda: irq timeout: status=0xd0 DMA question
In-reply-to: <5KyFa-RL-1@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4401F6BA.5010607@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5KtPb-2oP-9@gated-at.bofh.it> <5Kxzs-7M7-19@gated-at.bofh.it>
 <5KxJa-7XQ-31@gated-at.bofh.it> <5KxT2-8a6-15@gated-at.bofh.it>
 <5KyFa-RL-1@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrik Persson wrote:
> Does happen once or twice a year.. Probably something funky with the
> cabling or some power-related issues.
> 
> Anyway, I would be happy if the IDE driver would "just not do that". :)

I can see the reasoning where the device just doesn't function properly 
with DMA at all (like on some Compact Flash-to-IDE adapters where the 
card claims to support DMA but the DMA lines aren't wired through in the 
adapter properly). In that case not disabling DMA would render it 
useless. The IDE layer could keep track of whether DMA was previously 
working on that device however, and not disable DMA on reset if it had 
previously been working.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


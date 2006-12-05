Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968149AbWLESDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968149AbWLESDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759954AbWLESDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:03:55 -0500
Received: from smtp.nokia.com ([131.228.20.170]:46030 "EHLO
	mgw-ext11.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759970AbWLESDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:03:53 -0500
Message-ID: <4575B52C.70403@indt.org.br>
Date: Tue, 05 Dec 2006 14:06:36 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
CC: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_lock_unlock.diff
References: <4564640B.1070004@indt.org.br> <45680308.4040809@drzeus.cx> <45746CD3.1000604@indt.org.br> <457483B5.8060205@drzeus.cx>
In-Reply-To: <457483B5.8060205@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2006 18:02:18.0605 (UTC) FILETIME=[80F581D0:01C71897]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext Pierre Ossman wrote:

> Anderson Briglia wrote:
>> Actually they represent the bits regarding the modes and it is used
>> when we
>> have to send the LOCK/UNLOCK mode on the command data block, according
>> to the MMC Spec.
>> If you take a look at mmc_lock_unlock function, we use those modes to
>> set the right bit
>> when composing the command data block.
>> This definition makes the code more legible and simple.
> 
> In that case you need to change the code to make sure it is clear that
> it is bits and not values.

Yes. As I sent another version after read your comment, I'll fix the V8 code just for this patch, ok? I don't see that 
we have to send another version.


> Also, your definition for
> MMC_LOCK_MODE_UNLOCK is wrong.

This definition:

#define MMC_LOCK_MODE_UNLOCK    (0<<2)

also tries to make the code more clear and legible. It is indicating that this bit is on the position 3 into the bits 
array, according to MMC Spec.
But, why zero? Well, the bit must be 1 for locking and 0 for unlocking. We are using the unlocking action, so we used zero.
Is there any issue using this piece of code?
If you prefer another approach we can adjust our patch.

Regards,

Anderson Briglia

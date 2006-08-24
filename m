Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWHXOs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWHXOs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 10:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWHXOs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 10:48:27 -0400
Received: from rtr.ca ([64.26.128.89]:54720 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932109AbWHXOs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 10:48:26 -0400
Message-ID: <44EDBC39.2070207@rtr.ca>
Date: Thu, 24 Aug 2006 10:48:25 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Johan Groth <johan.groth@linux-grotto.org.uk>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
Subject: Re: Scsi errors with Megaraid 300-8x
References: <44EB1875.3020403@linux-grotto.org.uk> <44EC73D2.9090302@rtr.ca> <44EC775C.7040003@linux-grotto.org.uk> <Pine.LNX.4.64.0608231145290.15031@p34.internal.lan> <44EC78CD.9010401@linux-grotto.org.uk>
In-Reply-To: <44EC78CD.9010401@linux-grotto.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Groth wrote:
> Justin Piszcz wrote:
>> Run badblocks in r+w mode on the bad disk and it will force the disk 
>> to re-allocate the bad sector if it can.
>>
>> Justin.
> 
> Is that possible to do in a non-destructive way? I don't want to loose 
> all data and apparently I can't back it up either :(.

Yes, it is perfectly doable, but I don't think anyone has yet bothered
to release a utility that actually does it.

OPPORTUNITY FOR FAME AND FORTUNE! (okay, maybe just some fame):
=================================
Hack the existing smartctl code to read out the failed sector numbers,
and then issue single-sector read-overwrite to each of those bad sectors.

Very simple code.  I'll do it myself eventually, but please beat me to it!

Cheers

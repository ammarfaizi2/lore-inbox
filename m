Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWHXQ5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWHXQ5b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWHXQ5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:57:31 -0400
Received: from rtr.ca ([64.26.128.89]:8942 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751616AbWHXQ5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:57:30 -0400
Message-ID: <44EDDA77.40307@rtr.ca>
Date: Thu, 24 Aug 2006 12:57:27 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Johan Groth <johan.groth@linux-grotto.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scsi errors with Megaraid 300-8x
References: <44EB1875.3020403@linux-grotto.org.uk> <44EC73D2.9090302@rtr.ca> <44EC775C.7040003@linux-grotto.org.uk> <Pine.LNX.4.64.0608231145290.15031@p34.internal.lan> <44EC78CD.9010401@linux-grotto.org.uk> <44EDBC39.2070207@rtr.ca> <44EDC135.4080007@linux-grotto.org.uk>
In-Reply-To: <44EDC135.4080007@linux-grotto.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Groth wrote:
> Mark Lord wrote:
>
>> OPPORTUNITY FOR FAME AND FORTUNE! (okay, maybe just some fame):
>> =================================
>> Hack the existing smartctl code to read out the failed sector numbers,
>> and then issue single-sector read-overwrite to each of those bad sectors.
>>
>> Very simple code.  I'll do it myself eventually, but please beat me to 
>> it!
> 
> Authors of badblocks already has with the -n option :)

Not quite.  As you pointed out:

> I would like to run badblocks again but only around the damaged part. 

The drive *knows* which sectors are bad -- it's mostly all in the S.M.A.R.T.
logs and such.  Which smartctl already knows how to read.

So now we just need a script-kiddie to do a nice little awk script for you,
which extracts the bad sectors info from the output of smartctl, and then
feeds this as input to badblocks.

Cheers

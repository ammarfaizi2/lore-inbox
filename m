Return-Path: <linux-kernel-owner+w=401wt.eu-S1751082AbXACTY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbXACTY1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbXACTY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:24:27 -0500
Received: from gate.crashing.org ([63.228.1.57]:53180 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbXACTY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:24:26 -0500
In-Reply-To: <411976.37299.qm@web50112.mail.yahoo.com>
References: <411976.37299.qm@web50112.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <eb0f8bb9742f0c4f179dae77700fa997@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Subject: [PATCH 2/2] EDAC: K8 Memory scrubbing patch
Date: Wed, 3 Jan 2007 20:24:59 +0100
To: Doug Thompson <norsk5@yahoo.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    One would also expect that cache scrubbing requires hardware
>    support.

You could just write-back invalidate the whole cache
periodically if there is no explicit hardware support
for cache scrubbing.  Less efficient, sure :-)

> Signed-off-by: doug thompson <norsk5@xmission.com>

Shouldn't you spell your name correctly (with capitalisation)
in the sign off?  It being a formal thing and all.

Some spelling and coding style nits:

> +/* Valid scrub rates for the K8 hardware memory scrubber. We map
> +   maps the scrubbing bandwith to a valid bit pattern. The 'set'

"map maps"

> +   Currently, we only do scrubbing of sdram - the caches are assumed
> +   to be excercised always by running code and if the scrubber is done

"excercised"

> +	   search for the bandwith that is eq or gt than the

"bandwith"

And please just write "greater or equal".

> +	for (i=0; scrubrates[i].bandwidth != SDRATE_EOD; i++) {

i = 0;

> +	/* find the bandwith matching the memory scrubber configuration

"bandwith" again

> +	for (i=0; scrubrates[i].bandwidth != SDRATE_EOD; i++) {

i = 0;

> +	/* the bit pattern is invalid - we might fix it
> +	   by applying the slowest scrub rate as this is
> +	   closest to the valid value, but we do not!

Why not?

> +	if (scrubrates[i].bandwidth == SDRATE_EOD) {
> +		edac_printk(KERN_WARNING, EDAC_MC,
> +				"Invalid sdram scrub control value: %d \n",

Space before the newline.

>  /* FIXME - stolen from msr.c - the calls in msr.c could be exported */

So fix it :-)


Segher


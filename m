Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWAEBgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWAEBgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWAEBgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:36:13 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:961 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750854AbWAEBgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:36:12 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.15-ck1
Date: Thu, 5 Jan 2006 12:36:04 +1100
User-Agent: KMail/1.8.2
Cc: Arjan van de Ven <arjan@infradead.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz
References: <200601041200.03593.kernel@kolivas.org> <1136406837.2839.67.camel@laptopd505.fenrus.org> <p73y81vxyci.fsf@verdi.suse.de>
In-Reply-To: <p73y81vxyci.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051236.04988.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006 12:22 pm, Andi Kleen wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> > sounds like we need some sort of profiler or benchmarker or at least a
> > tool that helps finding out which timers are regularly firing, with the
> > aim at either grouping them or trying to reduce their disturbance in
> > some form.
>
> I did one some time ago for my own noidletick patch. Can probably dig
> it out again. It just profiled which timers interrupted idle.
>
> Executive summary for my laptop: worst was the keyboard driver (it ran
> some polling driver to work around some hardware bug, but fired very
> often) , followed by the KDE desktop (should be mostly
> fixed now, I complained) and the X server and some random kernel
> drivers.
>
> I haven't checked recently if keyboard has been fixed by now.

I checked with Vojtech some time ago and he said we could change the polling 
from HZ/20 to about HZ/5 which I have included in the rolled up dynticks 
patch already. Not that 20 HZ is very frequent, but anything that splits up 
timer intervals potentially by 20 more adds up.

Cheers,
Con

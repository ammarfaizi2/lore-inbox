Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWAEXWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWAEXWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWAEXWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:22:13 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:17371 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750780AbWAEXWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:22:12 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Tomasz Torcz <zdzichu@irc.pl>
Subject: Re: 2.6.15-ck1
Date: Fri, 6 Jan 2006 10:22:45 +1100
User-Agent: KMail/1.8.2
Cc: ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <20060105175821.GA4010@irc.pl>
In-Reply-To: <20060105175821.GA4010@irc.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601061022.46026.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006 04:58 am, Tomasz Torcz wrote:
> On Wed, Jan 04, 2006 at 12:00:00PM +1100, Con Kolivas wrote:
> > Added:
> >  +2.6.15-dynticks-060101.patch
>
>   On practically unused (booted and logged in into GNOME, one terminal
> emulator, clock gdesklet ticking) desktop system -- Sempron 2500+,
> pmstats show between 450 and 600 Hz. Is this normal?

Chances are your hardware is one that doesn't play well with dynticks then. 
Compile in the timer info and use the timertop utility to see if there really 
is something increasing your timer activity to 450HZ and if there isn't then 
it's a problem with dynticks and your hardware. This is the problem I'm 
currently seeing on SMP configs (too many HZ) and I have yet to figure out 
what it is about the IO APIC that makes this happen.

Cheers,
Con

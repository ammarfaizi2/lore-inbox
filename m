Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTFPPXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 11:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263964AbTFPPXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 11:23:00 -0400
Received: from [81.80.245.157] ([81.80.245.157]:28574 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S263953AbTFPPW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 11:22:59 -0400
Date: Mon, 16 Jun 2003 17:36:57 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.21] meye driver update
Message-ID: <20030616153657.GA26958@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Michael Buesch <fsdeveloper@yahoo.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030615163138.GD1857@deep-space-9.dsnet> <200306151906.57099.fsdeveloper@yahoo.de> <20030615212935.GA1582@deep-space-9.dsnet> <200306161654.52825.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306161654.52825.fsdeveloper@yahoo.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 04:54:41PM +0200, Michael Buesch wrote:

> > Unused of ix86 because bus addresses are the same as virtual addresses.
> > This is not however the case on other architetures, see
> > Documentation/DMA-mapping.txt.
> 
> Yes, I now understand, why it is in 2.5, but isn't it better,
> to remove these parameters from your patch, because it is only
> a local copy in your driver and not used by any other drivers.
> And your driver is (if I didn't miss something) for running on
> i386 only; there is no other version of this function for
> other architectures, that need these parameters.
> So wouldn't it be better to simply remove them, because
> they are completely useless. IMHO their
> just confusing.

No, I hope that the DMA allocation function will be backported in the
near future from 2.5 into 2.4. If I get some time, I may even do it
myself and propose a patch.

And when it's done, I'll just have to remove the two definitions 
without changing anything in my code and it will just work.

Besides, having two versions (2.4 and 2.5) which don't diverge to much
is much easier for the maintainer.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com

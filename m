Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbVH2Mwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbVH2Mwk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 08:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVH2Mwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 08:52:40 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:10984 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750878AbVH2Mwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 08:52:39 -0400
Date: Mon, 29 Aug 2005 08:52:35 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: Thomas Zehetbauer <thomasz@hostmaster.org>, linux-kernel@vger.kernel.org
Subject: Re: Surround via SPDIF with ALSA/emu10k1?
Message-ID: <20050829125235.GW28551@csclub.uwaterloo.ca>
References: <1124755373.5763.4.camel@hostmaster.org> <1125166739.22285.66.camel@hostmaster.org> <20050827211726.GD28578@csclub.uwaterloo.ca> <1125179229.25011.94.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125179229.25011.94.camel@mindpipe>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2005 at 05:47:08PM -0400, Lee Revell wrote:
> For the best S/N ratio and dynamic range all mixer controls SHOULD be at
> 100%, assuming the volume control in your driver only attenuates
> signals.  This is the case for the emu10k1 which implements all mixer
> controls via DSP programs that run on the soundcard anyway, and handles
> overflow itself.

Well I don't want them all at 100% since I do want to be able to have
even levels between the cd, midi and wave, which isn't always the case
at 100%.  They sure sounded worse.

I certainly know some simpler sound cards would have more distrosion
when you ran the amplifiers on the card at 100%.

> Think about it, if you lower the mixer controls to 75%, you're not
> getting the full 16 bits of dynamic range, it's probably more like 14 or
> 15.  16 bits is barely enough headroom anyway, so you really don't want
> this.

Bit 16 is used as soon as the signal passes 50%.  After all it is
required when the signal goes past 32767 and is on all the way to 65535.

So at 75% depending on how things are done internally I will be either
using the full range just not amplified to the same amount, or if truly
done entirely digitally, then I will be using 75% of the range, which is
still more than even 15bit could handle (since 15 bit has half the range
of 16bit).

> Anyway the problem here is a bug in the emu10k1 driver, see alsa-devel
> for the resolution.

Well that probably helps.

Len Sorensen

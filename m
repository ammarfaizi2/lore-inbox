Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVH0VrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVH0VrM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 17:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVH0VrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 17:47:12 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:35744 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750751AbVH0VrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 17:47:11 -0400
Subject: Re: Surround via SPDIF with ALSA/emu10k1?
From: Lee Revell <rlrevell@joe-job.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Thomas Zehetbauer <thomasz@hostmaster.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050827211726.GD28578@csclub.uwaterloo.ca>
References: <1124755373.5763.4.camel@hostmaster.org>
	 <1125166739.22285.66.camel@hostmaster.org>
	 <20050827211726.GD28578@csclub.uwaterloo.ca>
Content-Type: text/plain
Date: Sat, 27 Aug 2005 17:47:08 -0400
Message-Id: <1125179229.25011.94.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-27 at 17:17 -0400, Lennart Sorensen wrote:
> As for volume settings, I always try to keep the sound card mixers at
> around 75 to 80% since it seems most amplifiers and mixer do distort a
> bit when you max them out.  Why would you want them all at 100%
> anyhow, then you might as well not have mixing control for the
> seperate audio channels at all. 

For the best S/N ratio and dynamic range all mixer controls SHOULD be at
100%, assuming the volume control in your driver only attenuates
signals.  This is the case for the emu10k1 which implements all mixer
controls via DSP programs that run on the soundcard anyway, and handles
overflow itself.

Think about it, if you lower the mixer controls to 75%, you're not
getting the full 16 bits of dynamic range, it's probably more like 14 or
15.  16 bits is barely enough headroom anyway, so you really don't want
this.

Anyway the problem here is a bug in the emu10k1 driver, see alsa-devel
for the resolution.

Lee


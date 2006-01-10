Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWAJBuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWAJBuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 20:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWAJBuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 20:50:04 -0500
Received: from mail3.uklinux.net ([80.84.72.33]:41603 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1750931AbWAJBuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 20:50:01 -0500
Date: Tue, 10 Jan 2006 02:00:17 +0000
From: John Rigg <ad@sound-man.co.uk>
To: Hannu Savolainen <hannu@opensound.com>
Cc: John Rigg <ad@sound-man.co.uk>, David Lang <dlang@digitalinsight.com>,
       =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       linux-sound@vger.kernel.org,
       ALSA development <alsa-devel@alsa-project.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
Message-ID: <20060110020017.GB5375@localhost.localdomain>
References: <20050726150837.GT3160@stusta.de> <200601091405.23939.rene@exactcode.de> <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi> <200601091812.55943.rene@exactcode.de> <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz> <20060109232043.GA5013@localhost.localdomain> <Pine.LNX.4.61.0601100212290.26233@zeus.compusonic.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601100212290.26233@zeus.compusonic.fi>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 02:48:35AM +0200, Hannu Savolainen wrote:
> On Mon, 9 Jan 2006, John Rigg wrote:
> 
> > Yes, but the CPU has plenty of other work to do. The sound cards that
> > would be worst affected by this are the big RME cards (non-interleaved) and
> > multiple ice1712 cards (non-interleaved blocks of interleaved data),
> ice1712 uses normal interleaving. There are no "non-interleaved blocks".

With two ice1712 cards I had to patch jackd for MMAP_COMPLEX
support to make them work together. My understanding was that the
individual cards use interleaved data, but when several are combined
the resulting blocks of data are not interleaved together. I realise the
usual way of dealing with this is to use the alsa route plugin with
ttable to interleave them, but I couldn't get it to work with these
cards.

John

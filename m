Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWAJCTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWAJCTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 21:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWAJCTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 21:19:41 -0500
Received: from host1.compusonic.fi ([195.238.198.242]:41843 "EHLO
	minor.compusonic.fi") by vger.kernel.org with ESMTP id S932262AbWAJCTk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 21:19:40 -0500
Date: Tue, 10 Jan 2006 04:17:03 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: John Rigg <ad@sound-man.co.uk>
Cc: David Lang <dlang@digitalinsight.com>,
       =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       linux-sound@vger.kernel.org,
       ALSA development <alsa-devel@alsa-project.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
In-Reply-To: <20060110020017.GB5375@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0601100408480.18971@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de> <200601091405.23939.rene@exactcode.de>
 <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi> <200601091812.55943.rene@exactcode.de>
 <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz>
 <20060109232043.GA5013@localhost.localdomain> <Pine.LNX.4.61.0601100212290.26233@zeus.compusonic.fi>
 <20060110020017.GB5375@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006, John Rigg wrote:

> On Tue, Jan 10, 2006 at 02:48:35AM +0200, Hannu Savolainen wrote:
> > On Mon, 9 Jan 2006, John Rigg wrote:
> > 
> > > Yes, but the CPU has plenty of other work to do. The sound cards that
> > > would be worst affected by this are the big RME cards (non-interleaved) and
> > > multiple ice1712 cards (non-interleaved blocks of interleaved data),
> > ice1712 uses normal interleaving. There are no "non-interleaved blocks".
> 
> With two ice1712 cards I had to patch jackd for MMAP_COMPLEX
> support to make them work together. My understanding was that the
> individual cards use interleaved data, but when several are combined
> the resulting blocks of data are not interleaved together. I realise the
> usual way of dealing with this is to use the alsa route plugin with
> ttable to interleave them, but I couldn't get it to work with these
> cards.
Right. If you use two cards then both of them have independently 
interleaved blocks. However if this kind of mapping belongs to the lowest 
level audio API or not is yet another API feature to argue about.  Higher 
level libraries like Jack could do this themselves.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM

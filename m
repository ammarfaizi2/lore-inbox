Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbUATBUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUATBTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:19:09 -0500
Received: from pD9E73F11.dip.t-dialin.net ([217.231.63.17]:13184 "EHLO
	abc.local") by vger.kernel.org with ESMTP id S263805AbUATBPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:15:43 -0500
Date: Tue, 20 Jan 2004 02:17:20 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4: ALSA es1968 DMA alloc problem
Message-ID: <20040120011720.GA1248@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Takashi Iwai <tiwai@suse.de>, arjanv@redhat.com,
	linux-kernel@vger.kernel.org
References: <20040117161013.GA3303@convergence.de> <s5hwu7n6gvz.wl@alsa2.suse.de> <1074531954.4443.6.camel@laptop.fenrus.com> <s5hoesz6eu3.wl@alsa2.suse.de> <s5hhdyru84m.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hhdyru84m.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 07:05:13PM +0100, Takashi Iwai wrote:
> At Mon, 19 Jan 2004 18:14:12 +0100,
> I wrote:
> > 
> > hmm, can calling pci_set_consistent_dma_mask() after
> > pci_set_dma_mask() fail?  then we need to fix
> > Documentation/DMA-mapping.txt, too.
> 
> well, anyway, the attached is one with checks of both returns.

The patch did not apply cleanly because it is against a newer
core/memalloc.c than the one in 2.6.1-mm4 (rev 1.19 vs. 1.20).
I fetched memalloc.c rev1.20 from ALSA CVS and applied the
patch on top of that: My es1968 soundcard works.

(To make sure the whole problem was not just caused by an
out-of-date memalloc.c in 2.6.1-mm4 I also tried just
the updated memalloc.c without your patch, but this did
not cure the "DMA buffer beyond 256MB" problem.)

Johannes

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWAZTTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWAZTTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWAZTTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:19:39 -0500
Received: from gold.veritas.com ([143.127.12.110]:1141 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964844AbWAZTTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:19:37 -0500
Date: Thu, 26 Jan 2006 19:19:22 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Takashi Iwai <tiwai@suse.de>
cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       tbm@cyrius.com, t.sailer@alumni.ethz.ch, perex@suse.cz,
       ralf@linux-mips.org
Subject: Re: ALSA on MIPS platform
In-Reply-To: <s5hzmljt1si.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.61.0601261910230.15596@goblin.wat.veritas.com>
References: <20060125.235007.126576298.anemo@mba.ocn.ne.jp> <s5hek2wb05q.wl%tiwai@suse.de>
 <20060127.002925.25911749.anemo@mba.ocn.ne.jp> <s5hzmljt1si.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Jan 2006 19:19:07.0229 (UTC) FILETIME=[609DF8D0:01C622AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Takashi Iwai wrote:
> At Fri, 27 Jan 2006 00:29:25 +0900 (JST),
> Atsushi Nemoto wrote:
> 
> > The most part of issue #1 will vanish if NEED_RESERVE_PAGES was
> > defined, and currently only ARM define this.  ARM defines
> > NEED_RESERVE_PAGES because it has dma_mmap_coherent(), right?
> 
> Well, the whole page-reserve kludge should disappear anyway in near
> future.  Right now it's in the process.

Yes, mark_pages() and unmark_pages() can just be removed as soon as
you like.

I didn't reply to the original posting because I noticed they're not
all of the virt_to_page()s in sound/core, and sometimes a part-answer
distracts someone more competent from responding with the full answer.

And I'm in no hurry to remove these PageReserved traces myself, since
it's not a bad idea to hold on to the bad_page cross-checking for a
release or two.

Hugh

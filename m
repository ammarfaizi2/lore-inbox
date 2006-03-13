Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751667AbWCMLN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbWCMLN2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 06:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWCMLN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 06:13:28 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:33226 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751642AbWCMLN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 06:13:28 -0500
Date: Mon, 13 Mar 2006 12:13:26 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: Faster resuming of suspend technology.
Message-ID: <20060313111326.GA29716@rhlx01.fht-esslingen.de>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060312213228.GA27693@rhlx01.fht-esslingen.de> <20060313100619.GA2136@elf.ucw.cz> <200603132136.00210.kernel@kolivas.org> <20060313104315.GH3495@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313104315.GH3495@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 13, 2006 at 11:43:15AM +0100, Pavel Machek wrote:
> On Po 13-03-06 21:35:59, Con Kolivas wrote:
> > wouldn't be too hard to add a special post_resume_swap_prefetch() which 
> > aggressively prefetches for a while. Excuse my ignorance, though, as I know 
> > little about swsusp. Are there pages still on swap space after a resume 
> > cycle?
> 
> Yes, there are, most of the time. Let me explain:
> 
> swsusp needs half of memory free. So it shrinks caches (by emulating
> memory pressure) so that half of memory if free (and optionaly shrinks
> them some more). Pages are pushed into swap by this process.
> 
> Now, that works perfectly okay for me (with 1.5GB machine). I can
> imagine that on 128MB machine, shrinking caches to 64MB could hurt a
> bit. I guess we'll need to find someone interested with small memory
> machine (if there are no such people, we can happily ignore the issue
> :-).

Why not simply use the mem= boot parameter?
Or is that impossible for some reason in this specific case?

I have a P3/450 256M machine where I could do some tests if really needed.

Andreas Mohr

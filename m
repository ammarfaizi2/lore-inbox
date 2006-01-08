Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030622AbWAHJmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030622AbWAHJmG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 04:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030599AbWAHJmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 04:42:06 -0500
Received: from gate.perex.cz ([85.132.177.35]:40653 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1030582AbWAHJmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 04:42:04 -0500
Date: Sun, 8 Jan 2006 10:42:02 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Olivier Galibert <galibert@pobox.com>
Cc: Takashi Iwai <tiwai@suse.de>,
       ALSA development <alsa-devel@alsa-project.org>,
       linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <20060108020335.GA26114@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.61.0601081039520.9470@tm8103.perex-int.cz>
References: <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de>
 <Pine.BSO.4.63.0601052022560.15077@rudy.mif.pg.gda.pl> <s5h8xtshzwk.wl%tiwai@suse.de>
 <20060108020335.GA26114@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006, Olivier Galibert wrote:

> On Sat, Jan 07, 2006 at 03:32:27PM +0100, Takashi Iwai wrote:
> > Yes, it's a known problem to be fixed.  But, it's no excuse to do
> > _everything_ in the kernel (which OSS requires).
> 
> OSS does not require to do anything in the kernel except an entry
> point.
> 
> 
> > And if the application doesn't support, who and where converts it?
> > With OSS API, it's a job of the kernel.
> 
> Once again no.  Nothing prevents the kernel to forward the data to
> userland daemons depending on a userspace-uploaded configuration.

But it's quite ineffecient. The kernel must switch tasks at least twice
or more. It's the major problem with the current OSS API.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

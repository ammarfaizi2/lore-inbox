Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWGAJ0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWGAJ0M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 05:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWGAJ0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 05:26:12 -0400
Received: from gate.perex.cz ([85.132.177.35]:54765 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932477AbWGAJ0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 05:26:11 -0400
Date: Sat, 1 Jul 2006 11:26:08 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Olivier Galibert <galibert@pobox.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Olaf Hering <olh@suse.de>
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
In-Reply-To: <20060701073133.GA99126@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.61.0607011118420.8553@tm8103.perex-int.cz>
References: <20060629192128.GE19712@stusta.de> <44A54D8E.3000002@superbug.co.uk>
 <20060630163114.GA12874@dspnet.fr.eu.org> <1151702966.32444.57.camel@mindpipe>
 <20060701073133.GA99126@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jul 2006, Olivier Galibert wrote:

> On Fri, Jun 30, 2006 at 05:29:26PM -0400, Lee Revell wrote:
> > Even if you reject this argument, the bug is in ALSA's in-kernel OSS
> > emulation, not the emu10k1 driver.
> 
> That's irrelevant.  You can't remove the oss emu10k1 driver in favor
> of alsa's until alsa provides an equivalent interface.  That's a basic
> compatibility requirement.

Sorry, but the OSS interface is not an issue for the emu10k1 driver. It 
already supports multi-open, because emu10k1/emu10k2 chip supports more 
voices in hardware. Lee was speaking about cheap versions of Sound Blaster 
cards and they are not supported with the OSS emu10k1 linux driver, too.

> > ALSA's in-kernel OSS emulation does not have these features and
> > never will.
> 
> "Never" is terribly long.

The questions is which feature is missing from the ALSA emu10k1 driver. 
Personally, I don't know about any, except some extra features like 
rear/center/lfe channel binding, but the old OSS app binaries does not 
know about them, so it's no worth to care.

In my opinion, the OSS emu10k1 driver is ready to be removed unless 
someone notify us about any missing feature.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWAJB41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWAJB41 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 20:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWAJB41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 20:56:27 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:61927 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750924AbWAJB40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 20:56:26 -0500
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Lang <dlang@digitalinsight.com>, John Rigg <ad@sound-man.co.uk>,
       =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>,
       Hannu Savolainen <hannu@opensound.com>, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       ALSA development <alsa-devel@alsa-project.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1136853898.12802.21.camel@localhost.localdomain>
References: <20050726150837.GT3160@stusta.de>
	 <200601091405.23939.rene@exactcode.de>
	 <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi>
	 <200601091812.55943.rene@exactcode.de>
	 <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz>
	 <20060109232043.GA5013@localhost.localdomain>
	 <Pine.LNX.4.62.0601091515570.4005@qynat.qvtvafvgr.pbz>
	 <20060110001617.GA5154@localhost.localdomain>
	 <Pine.LNX.4.62.0601091628340.4005@qynat.qvtvafvgr.pbz>
	 <1136853898.12802.21.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 20:56:21 -0500
Message-Id: <1136858181.2007.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 00:44 +0000, Alan Cox wrote:
> On Llu, 2006-01-09 at 16:29 -0800, David Lang wrote:
> > I was under the (apparently mistaken) impression that you couldn't DMA 
> > from userspace (something to do with the possibility that the userspace 
> > memory pages could be swapped out in the middle of the DMA)
> 
> Drivers can choose to support this two different ways. One is to have a
> buffer of kernel memory mapped into user space and shared with the
> hardware (this is how OSS did it), the other is to use the 2.6
> get_user_pages API to get the physical address of a set of pages and
> lock them down so they don't wander off during DMA.
> 
> Both have advantages for different uses.

ALSA would appear to use the first method (get_user_pages does not
appear in the source), presumably because new ALSA versions still
support 2.4 (and 2.2, maybe even 2.0).

Lee


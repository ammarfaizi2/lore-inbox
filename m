Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWAJEoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWAJEoB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 23:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWAJEoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 23:44:01 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13968 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751324AbWAJEoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 23:44:01 -0500
Subject: Re: [2.6 patch] VIDEO_SAA7134_ALSA shouldn't select SND_PCM_OSS
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br,
       video4linux-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060110043308.GC3911@stusta.de>
References: <20060110040605.GA3911@stusta.de>
	 <1136866446.2007.52.camel@mindpipe>  <20060110043308.GC3911@stusta.de>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 23:43:58 -0500
Message-Id: <1136868239.2007.58.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 05:33 +0100, Adrian Bunk wrote:
> On Mon, Jan 09, 2006 at 11:14:05PM -0500, Lee Revell wrote:
> > On Tue, 2006-01-10 at 05:06 +0100, Adrian Bunk wrote:
> > > There's no reason for an ALSA driver to select an OSS legacy userspace 
> > > interface.
> > 
> > Actually there is a reason.  While OSS may be deprecated the OSS API is
> > not - ALSA is committed to supporting it for the forseeable future.  And
> > as broken an interface as it is, a lot of people consider the sound
> > system broken if you can't just write() to /dev/dsp and have sound come
> > out.
> 
> No disagreement, but that's not the point.
> 
> SND_PCM_OSS gives an OSS API interface for userspace on top of ALSA.
> ALSA drivers shouldn't care whether they are controlled directly 
> through ALSA or through a legacy OSS API on top of ALSA.
> 
> If someone wants to use SND_PCM_OSS that is fine, but the ALSA interface 
> to my saa7134 card is working fine, so why does it force me to compile a 
> legacy OSS API interface into the kernel?

OK, makes sense.

Lee


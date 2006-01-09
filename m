Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWAINGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWAINGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWAINGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:06:05 -0500
Received: from mx02.qsc.de ([213.148.130.14]:65214 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S1751287AbWAINGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:06:02 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
Date: Mon, 9 Jan 2006 14:05:23 +0100
User-Agent: KMail/1.9
Cc: Hannu Savolainen <hannu@opensound.com>, Takashi Iwai <tiwai@suse.de>,
       linux-sound@vger.kernel.org,
       ALSA development <alsa-devel@alsa-project.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <20050726150837.GT3160@stusta.de> <Pine.LNX.4.61.0601080225500.17252@zeus.compusonic.fi> <Pine.LNX.4.61.0601081007550.9470@tm8103.perex-int.cz>
In-Reply-To: <Pine.LNX.4.61.0601081007550.9470@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091405.23939.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On Sunday 08 January 2006 10:24, Jaroslav Kysela
	wrote: > > > > > - PCM with non-interleaved formats > > > > There is no
	need to handle non-interleaved data in kernel level drivers > > > >
	because all the devices use interleaved formats. > > > > > > Many RME
	boards support only non-intereleave data. > > In such cases it's better
	to do interleavin/deinterleaving in the kernel > > rather than forcing
	the apps to check which method they should use. > > I don't think so.
	The library can do such conversions (and alsa-lib does) > quite easy. If
	we have a possibility to remove the code from the kernel > space without
	any drawbacks, then it should be removed. I don't see any > advantage to
	have such conversions in the kernel. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 08 January 2006 10:24, Jaroslav Kysela wrote:

> > > > > - PCM with non-interleaved formats
> > > > There is no need to handle non-interleaved data in kernel level drivers 
> > > > because all the devices use interleaved formats.
> > > 
> > > Many RME boards support only non-intereleave data.
> > In such cases it's better to do interleavin/deinterleaving in the kernel 
> > rather than forcing the apps to check which method they should use.
> 
> I don't think so. The library can do such conversions (and alsa-lib does) 
> quite easy. If we have a possibility to remove the code from the kernel 
> space without any drawbacks, then it should be removed. I don't see any 
> advantage to have such conversions in the kernel.

Also, when the data is already available as single streams in a user-space
multi track application, why should it be forced interleaved, when the hardware
could handle the format just fine?

Yours,
  Rene

-- 
ExactCODE, Berlin

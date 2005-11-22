Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVKVC1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVKVC1t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 21:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVKVC1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 21:27:49 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:61344 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S964868AbVKVC1s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 21:27:48 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: virtual OSS devices [for making selfish apps happy]
Date: Tue, 22 Nov 2005 02:26:48 +0000
User-Agent: KMail/1.9
Cc: Christian Parpart <trapni@gentoo.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <200511212216.10837.trapni@gentoo.org> <1132609221.29178.93.camel@mindpipe>
In-Reply-To: <1132609221.29178.93.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511220226.48074.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 21:40, Lee Revell wrote:
> On Mon, 2005-11-21 at 22:16 +0100, Christian Parpart wrote:
> > Hi all,
> >
> > I'm having some apps running on my desktop that all want
> > exclusive access to my sound device just for playing audio
> > (and a single app for capturing), namely:
> >
> >  * TeamSpeak (VoIP team voice chat)
> >  * Cedega (for playing some win32 games on my beloved box)
> >  * KDE/arts (my desktop wants to play some sounds as well wtf)
> >
> > While I could easily disable my desktop sounds, and yeah, forget about
> > the music, but I'd still like to be in TeamSpeak (talking to friends and
> > alike) while playing a game using cedega.
> >
> > Unfortunately, *all* those stupid (2) apps want exclusive access to the
> > OSS layout of my ALSA drivers, though, there just came into my mind to
> > buy a second audio device and wear a second headset (a little one
> > below/under my big one). But I couldn't find it handy anyway :(
>
> This problem is (mostly) solved already.  You have to use aoss (alsa-lib
> based OSS emulation) on top of dmix (software mixing for soundcards too
> lame to do it in hardware).  With a recent ALSA dmix is already used by
> default so the only change needed is to launch the OSS apps with the
> aoss wrapper e.g. aoss ./foo-oss-app.  Since it's not completely
> transparent this problem will have to be solved at the distro level, by
> making sure all OSS apps are run with this wrapper.
>
> This method should only be needed for closed source apps, an open source
> app like artsd should be ported to use the ALSA API.

Which it already has been, for literally years.

[alistair] 02:26 [~] artsd -A
possible choices for the audio i/o method:

  toss      Threaded Open Sound System
  null      No Audio Input/Output
  alsa      Advanced Linux Sound Architecture
  oss       Open Sound System

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

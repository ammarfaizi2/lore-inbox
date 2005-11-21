Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbVKUVk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbVKUVk1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbVKUVk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:40:26 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:46997 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750996AbVKUVkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:40:25 -0500
Subject: Re: virtual OSS devices [for making selfish apps happy]
From: Lee Revell <rlrevell@joe-job.com>
To: Christian Parpart <trapni@gentoo.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200511212216.10837.trapni@gentoo.org>
References: <200511212216.10837.trapni@gentoo.org>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 16:40:20 -0500
Message-Id: <1132609221.29178.93.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 22:16 +0100, Christian Parpart wrote:
> Hi all,
> 
> I'm having some apps running on my desktop that all want
> exclusive access to my sound device just for playing audio
> (and a single app for capturing), namely:
> 
>  * TeamSpeak (VoIP team voice chat)
>  * Cedega (for playing some win32 games on my beloved box)
>  * KDE/arts (my desktop wants to play some sounds as well wtf)
> 
> While I could easily disable my desktop sounds, and yeah, forget about the 
> music, but I'd still like to be in TeamSpeak (talking to friends and alike) 
> while playing a game using cedega.
> 
> Unfortunately, *all* those stupid (2) apps want exclusive access to the OSS 
> layout of my ALSA drivers, though, there just came into my mind to buy a 
> second audio device and wear a second headset (a little one below/under my 
> big one). But I couldn't find it handy anyway :(

This problem is (mostly) solved already.  You have to use aoss (alsa-lib
based OSS emulation) on top of dmix (software mixing for soundcards too
lame to do it in hardware).  With a recent ALSA dmix is already used by
default so the only change needed is to launch the OSS apps with the
aoss wrapper e.g. aoss ./foo-oss-app.  Since it's not completely
transparent this problem will have to be solved at the distro level, by
making sure all OSS apps are run with this wrapper.

This method should only be needed for closed source apps, an open source
app like artsd should be ported to use the ALSA API.

Lee


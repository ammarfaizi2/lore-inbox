Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316300AbSFEUSg>; Wed, 5 Jun 2002 16:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSFEUSf>; Wed, 5 Jun 2002 16:18:35 -0400
Received: from dsl-213-023-039-098.arcor-ip.net ([213.23.39.98]:44227 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316300AbSFEUSe>;
	Wed, 5 Jun 2002 16:18:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Paul Zimmerman <Paul_Zimmerman@inSilicon.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 22:17:57 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <7FD8B823E5024E44B027221DEB34C087536524@scl-exch.phoenix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17FhEE-0001ee-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2002 21:01, Paul Zimmerman wrote:
> On Wednesday 05 June 2002 18:26, Daniel Phillips wrote: 
> > Both approaches have their uses. The second is the one I'm interested in,
> > if that isn't already obvious. The first is just a quick hack that will
> > give you guaranteed-skipless audio playback, something that Linux is
> > currently unable to do. 
> 
> What if I'm unfortunate enough to have my sound card share an interrupt
> with my IDE controller? Won't my realtime audio player still be at the
> mercy of my non-realtime Linux IDE driver? Or does Adeos have a way to
> handle that?

Adeos handles that.  Each task in the pipeline gets to look at the
shared interrupt and decide whether to pass it on or not, so the in
this case, the RTOS would handle the interrupt if it's for the sound
card, or kick it back into the pipeline if it isn't.

-- 
Daniel

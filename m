Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317107AbSGNUb6>; Sun, 14 Jul 2002 16:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSGNUb5>; Sun, 14 Jul 2002 16:31:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21488 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317107AbSGNUb4>; Sun, 14 Jul 2002 16:31:56 -0400
Subject: Re: [RFC][Patch] DMA for CD-ROM audio
From: Robert Love <rml@tech9.net>
To: Kristian Peters <kristian.peters@korseby.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020714113341.786b3600.kristian.peters@korseby.net>
References: <20020714113341.786b3600.kristian.peters@korseby.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Jul 2002 13:34:43 -0700
Message-Id: <1026678886.1244.417.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-14 at 02:33, Kristian Peters wrote:

> I've taken the CD-audio-DMA patch from Andrew Morton and made it available
> as a config option. You're now able to choose whether you still want
> the old code which uses PIO or the new code which decreases CPU load
> (on some systems up to 70%) and improves total time of read.
> 
> It should be safe with old systems. My broken AMD 386 falls back to PIO.

If the code is truly safe on older systems, what I think makes more
sense is merging it without a configure option and having DMA-capable
systems use DMA CD-audio and older systems fall back to PIO.

It seems wiser to me to support something entirely as correct and sane
or consider it not an issue.  This is not a separate feature, for
example like IDE itself which should be an option, but an evolutionary
feature of which we should just do it.

This would clean up all those nasty ifdefs and perhaps we could
generalize the two codepaths together, further reducing size.

I like the patch... up for my idea for 2.5?

I wonder what akpm thinks..

	Robert Love


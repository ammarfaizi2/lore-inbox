Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbTCaOdq>; Mon, 31 Mar 2003 09:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbTCaOdq>; Mon, 31 Mar 2003 09:33:46 -0500
Received: from Mail1.KONTENT.De ([81.88.34.36]:44713 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id <S261685AbTCaOdp>;
	Mon, 31 Mar 2003 09:33:45 -0500
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Helge Hafting <helgehaf@aitel.hist.no>, erik@hensema.net
Subject: Re: Delaying writes to disk when there's no need
Date: Mon, 31 Mar 2003 16:45:02 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net> <slrnb8gbfp.1d6.erik@bender.home.hensema.net> <3E8845A8.20107@aitel.hist.no>
In-Reply-To: <3E8845A8.20107@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303311645.02635.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A manual solution is possible if we can have two "knobs"
> for this:
> 1. Treshold for when to start writing out stuff
> 2. Treshold for when to throttle processes.
>
> The latter may or may not be necessary, the point is that the former
> should kick in long before throttling is necessary.
>
> This is usually expressed as how many % of memory that is dirty, but
> I'm not sure that is the right thing.  It assumes that 100% will be
> available after cleaning, which may be way off.
>
> Something like % of memory that is still available (free,
> or instantly freeable by reclaiming clean unpinned cache)

Is there any sense in allowing a task to keep dirty a certain percentage
of free memory? If you have a task that has to be throttled amyway,
is any memory that this task keeps dirty wasted anyway, if it's more
than needed to send efficient io requests to the device? Somebody
else might have better uses for that memory.

	Regards
		Oliver


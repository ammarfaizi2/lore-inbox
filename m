Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281817AbRK0XsD>; Tue, 27 Nov 2001 18:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281789AbRK0Xrx>; Tue, 27 Nov 2001 18:47:53 -0500
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:28405 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S281817AbRK0Xrl>; Tue, 27 Nov 2001 18:47:41 -0500
Date: Wed, 28 Nov 2001 00:35:18 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011128003518.A3895@storm.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200111270123.BAA02056@mauve.demon.co.uk> <0111261800340R.02001@localhost.localdomain> <9tuugv$f72$1@cesium.transmeta.com> <0111261919540W.02001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0111261919540W.02001@localhost.localdomain>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 07:19:54PM -0500, Rob Landley wrote:
> Now a journal track that's next to where the head parks could combine the 
> "park" sweep with that one seek, and presumably be spring powered and hence 
> save capacitor power.  But I'm not 100% certain it would be worth it.

When time if of essence it should be worth it (drive makers will use the
smallest possible capacitor, of course).  Given that current 7200 RPM
disks have marketed seek times of 8 or 9 ms worst case seeks can be much
longer.

That 8ms is average and likely read seeks are weighted higher than write
seeks.  Writes have to be exact, but reads can be seeked sloppier
(without waiting for the head to stop oscillating after braking) and
error correction will take care of the rest.  This would gives us what
in worst case?  15ms (just a guess)?

A journal track could be near parking track and have directly adjacent
tracks left free to allow for slightly sloppier/faster seeking.  An
expert could probably tell us whether this is complete BS or even
feasible.

> (Are 
> normal with-power-on seeks towards the park area powered by the spring, or 
> the... I keep wanting to say "stepper motor" but I don't think those are what 
> drives use anymore, are they?  Sigh...)

A simple spring is too slow, I guess.  Also, it should not be so hard
that it would slow down seeks against the spring.

-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44

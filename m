Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272862AbTG3MaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272865AbTG3MaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:30:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53010 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272862AbTG3MaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:30:05 -0400
Date: Wed, 30 Jul 2003 14:15:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030730121554.GG2601@openzaurus.ucw.cz>
References: <200307291915.h6TJF6YB000421@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307291915.h6TJF6YB000421@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I haven't had chance to test this yet, but I really like the idea - by
> an amasing co-incidence, I was actually thinking about the possibility
> of doing a parallel port connected front panel earlier today!
> 
> Does anybody have any suggestions for recommended standard uses for
> parallel port connected LEDs?
> 
> Disk spinning up/disk ready
> Root login active
> 
> Any other suggestions?

At one point I had 12 LEDs on parport. LEDs were fast enough to be drive at interrupt entry/exit.
They were: 
Yellow not idle task
Green interrupt
" bh
" pagefault
Red lowest 4 bits of PID
Red, low intensity serial i/o
" network i/o

It actually looked very good. Glow of interrupt led
told you interrupt load, pid LEDs told you about what kind of load
it is experiencing (you could tell shell script from make and from computation, and
if machine hard-died, you at least knew if it
was interrupt or process context).
But this kind of blinkenlights needed pretty fast LEDs. (At 486 time I decided that parport on ISA is fast enough..)
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...


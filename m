Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272733AbTG3G3c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272782AbTG3G2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:28:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57352 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272779AbTG3G2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:28:10 -0400
Date: Wed, 30 Jul 2003 07:08:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>, zwane@arm.linux.org.uk,
       linux-yoann@ifrance.com, linux-kernel@vger.kernel.org, akpm@digeo.com,
       vortex@scyld.com, jgarzik@pobox.com, vojtech@suse.cz
Subject: Re: another must-fix: major PS/2 mouse problem
Message-ID: <20030730050857.GF2601@openzaurus.ucw.cz>
References: <3EDCF47A.1060605@ifrance.com> <1054681254.22103.3750.camel@cube> <3EDD8850.9060808@ifrance.com> <1058921044.943.12.camel@cube> <20030724103047.31e91a96.akpm@osdl.org> <1059097601.1220.75.camel@cube> <20030725201914.644b020c.akpm@osdl.org> <Pine.LNX.4.53.0307261112590.12159@montezuma.mastecende.com> <1059447325.3862.86.camel@cube> <20030728201459.78c8c7c6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728201459.78c8c7c6.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Loosing too many ticks!
> > TSC cannot be used as a timesource. (Are you running with SpeedStep?)
> > Falling back to a sane timesource.
> > psmouse.c: Lost synchronization, throwing 3 bytes away.
> > psmouse.c: Lost synchronization, throwing 1 bytes away.
> > 
> > Arrrrgh! The TSC is my only good time source!
> 
> Arrrgh!  More PS/2 problems!
> 
> I think the lost synchronisation is the problem, would you agree?
> 
> The person who fixes this gets a Nobel prize.


If you set ps/2 synchronization timeout to 20 seconds, you are going to make vojtech
unhappy (he likes that code :-), but at least 2.6.0 will not be worse than 2.4.x...

Do you want me to create a patch?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...


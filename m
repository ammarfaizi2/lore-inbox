Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314398AbSDVSQg>; Mon, 22 Apr 2002 14:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314405AbSDVSQf>; Mon, 22 Apr 2002 14:16:35 -0400
Received: from zero.tech9.net ([209.61.188.187]:27913 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314398AbSDVSQf>;
	Mon, 22 Apr 2002 14:16:35 -0400
Subject: Re: 2.5.8: preemption + SMP broken ?
From: Robert Love <rml@tech9.net>
To: Pavel Machek <pavel@suse.cz>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020421185705.B155@toy.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 22 Apr 2002 14:16:30 -0400
Message-Id: <1019499391.934.9.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-04-21 at 14:57, Pavel Machek wrote:

> Wel, if race is in migration code, you should fix migration, not add
> preempt_disable(), right? [Or is race preempt-onlly?]

I was not sure where the race was - I really did not see a preempt-only
race there, but I could not pinpoint the cause for an SMP race.  Since
it was only showing itself as a preempt-related race, I disabled
preemption.

Erich Focht later pointed out that interrupts should be disabled in
migration_init and we sent a patch off to Linus.  I will do some testing
and see if this fixes it (I suspect it may) and subsequently remove the
preempt code.

	Robert Love


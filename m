Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965726AbWKDWgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965726AbWKDWgv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 17:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965724AbWKDWgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 17:36:51 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:30921 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965727AbWKDWgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 17:36:50 -0500
Date: Sat, 4 Nov 2006 23:36:49 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2048 CPUs [was: Re: New filesystem for Linux]
In-Reply-To: <787b0d920611041154l69db46abv4c8c467809ada57c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611042332240.20974@artax.karlin.mff.cuni.cz>
References: <787b0d920611041154l69db46abv4c8c467809ada57c@mail.gmail.com>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Does one Linux kernel run on system with 1024 cpus? I guess it
>> must fry spinlocks... (or even lockup due to spinlock livelocks)
>
> The SGI Altix can have 2048 CPUs.

And does it run one image of Linux? Or more images each on few cpus?

How do they solve problem with spinlock livelocks?

If time-spent-outside-spinlock/time-spent-in-spinlock < number-of-cpus, 
the spinlock livelock may happen --- this condition is not true normally 
with 2 or 4 cpus, but for that high amount of cpus, there is a danger.

Or do they have some special hardware spinlock instruction that guarantees 
fairness?

Mikulas

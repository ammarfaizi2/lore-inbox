Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288370AbSAHVN4>; Tue, 8 Jan 2002 16:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288364AbSAHVNq>; Tue, 8 Jan 2002 16:13:46 -0500
Received: from zero.tech9.net ([209.61.188.187]:34312 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288351AbSAHVNn>;
	Tue, 8 Jan 2002 16:13:43 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Andrew Morton <akpm@zip.com.au>,
        Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201081907040.2985-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201081907040.2985-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 08 Jan 2002 16:15:31 -0500
Message-Id: <1010524532.3383.106.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-08 at 16:08, Rik van Riel wrote:

> The preemptible kernel ALSO has to wait for a scheduling point
> to roll around, since it cannot preempt with spinlocks held.
> 
> Considering this, I don't see much of an advantage to adding
> kernel preemption.

It only has to wait if locks are held and then only until the locks are
dropped.  Otherwise it will preempt on the next return from interrupt.

Future work would be to look into long-held locks and see what we can
do.

Without preempt-kernel, we have none of this: either run until
completion or explicit scheduling points. 

	Robert Love


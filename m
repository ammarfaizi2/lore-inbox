Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131531AbRADVzM>; Thu, 4 Jan 2001 16:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131550AbRADVyx>; Thu, 4 Jan 2001 16:54:53 -0500
Received: from nrg.org ([216.101.165.106]:27172 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S131531AbRADVyi>;
	Thu, 4 Jan 2001 16:54:38 -0500
Date: Thu, 4 Jan 2001 13:54:24 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Andi Kleen <ak@suse.de>
cc: Anton Blanchard <anton@linuxcare.com.au>,
        Daniel Phillips <phillips@innominate.de>,
        ludovic fernandez <ludovic.fernandez@sun.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <20010104134435.A25106@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.05.10101041341550.4778-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Andi Kleen wrote:
> The problem is that current Linux semaphores are very costly locks -- they
> always cause a context switch.

My preemptible kernel patch currently just uses Linux semaphores to
implement sleeping kernel mutexes, but we (at MontaVista Software) are
working on a new implementation that also does priority inheritance,
to avoid the priority inversion problem, and that does the minimum
necessary context switches.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

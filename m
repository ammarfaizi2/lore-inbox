Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266812AbUBMOhr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 09:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267034AbUBMOhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 09:37:46 -0500
Received: from mail.shareable.org ([81.29.64.88]:45442 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266812AbUBMOhp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 09:37:45 -0500
Date: Fri, 13 Feb 2004 14:37:39 +0000
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: bug, or is it? - SCHED_RR and futex related
Message-ID: <20040213143739.GB28100@mail.shareable.org>
References: <20040212205708.GA1679@ss1000.ms.mff.cuni.cz> <20040213101351.GB19072@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213101351.GB19072@ss1000.ms.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudo Thomas wrote:
> I tracked it down to an infinite waiting in futex( ..., FUTEX_WAIT, 2, NULL).
> Can THIS hang the machine hard when running with SCHED_RR policy?

Do you mean that a task running with SCHED_RR calls futex( ...,
FUTEX_WAIT, 2, NULL), and there are no other SCHED_RR or SCHED_FIFO
tasks?

That cannot lock the machine hard.  When the futex call waits, the task sleeps.

-- Jamie

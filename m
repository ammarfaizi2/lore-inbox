Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWGAXpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWGAXpA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 19:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWGAXpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 19:45:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45982 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932355AbWGAXo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 19:44:58 -0400
Date: Sat, 1 Jul 2006 16:43:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, benh@kernel.crashing.org,
       davem@davemloft.net
Subject: Re: [RFC][patch 00/44] Consolidate irq_action flags
Message-Id: <20060701164338.192c0acd.akpm@osdl.org>
In-Reply-To: <20060701145211.856500000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Jul 2006 14:54:18 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> The recent interrupt rework introduced bit value conflicts with sparc.
> Instead of introducing new architecture flags mess, move the interrupt
> SA_ flags out of the signal namespace and replace them by interrupt
> related flags.
> 
> This allows to remove the obsolete SA_INTERRUPT flag and clean up
> the bit field values.
> 
> The patch was mostly created by a script, manually fixed up and reviewed.
> Compile tested on various platforms. Boot tested on i386/x86_64
> 

The amount of downstream wreckage from these changes is remarkably small -
I only had to diddle four or five patches and none of the git trees appear
to be affected.  Right now, when the subsystems trees are maximally-merged
is the best time for this sort of thing.


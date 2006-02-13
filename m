Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWBMPym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWBMPym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWBMPym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:54:42 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:1505 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750701AbWBMPyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:54:41 -0500
Date: Mon, 13 Feb 2006 16:54:37 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] hrtimer: remove useless const
In-Reply-To: <20060213114612.GA30500@elte.hu>
Message-ID: <Pine.LNX.4.61.0602131649560.30994@scrub.home>
References: <Pine.LNX.4.61.0602130209340.23804@scrub.home>
 <1139830116.2480.464.camel@localhost.localdomain> <Pine.LNX.4.61.0602131235180.30994@scrub.home>
 <20060213114612.GA30500@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Ingo Molnar wrote:

> your patch makes code larger on gcc3. Please investigate why.

Ok, I checked with 3.3.6 and 3.4.5 and adding const to ktime_divns/ 
posix_cpu_nsleep fixes the problem (actually the kernel becomes even 
smaller because posix_cpu_clock_getres is better off without const), both 
are complex and noncritical functions.
Andrew, I'd really prefer to keep the patch and I'll send a patch to add 
the const where it's actually an improvement.

bye, Roman

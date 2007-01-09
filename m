Return-Path: <linux-kernel-owner+w=401wt.eu-S932460AbXAIWlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbXAIWlZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbXAIWlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:41:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34945 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932460AbXAIWlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:41:24 -0500
Date: Tue, 9 Jan 2007 23:41:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] local_t : Documentation
Message-ID: <20070109224100.GB6555@elf.ucw.cz>
References: <20061221001545.GP28643@Krystal> <20061223093358.GF3960@ucw.cz> <20070109031446.GA29426@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109031446.GA29426@Krystal>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > These patches extend and standardise local_t operations on each architectures,
> > > allowing a rich set of atomic operations to be done on per-cpu data with
> > > minimal performance impact. On some architectures, there seems to be no
> > > difference between the SMP and UP operation (same memory barriers, same
> > > LOCking), local.h simply includes asm-generic/local.h, which removes duplicated
> > > code.
> > 
> > Could you provide some Documentation/? Knowing when local_t can be
> > used is kind-of important.
> 
> Hi Pavel,
> 
> Thanks for this appropriate comment. I totally agree that there is a need for
> documentation about how local_t variables should be used. Here is the patch
> that adds Documentation/local_ops.txt. Comments are welcome.

AFAICT this fails to mention... Is local_t as big as int? As big as
long? Or perhaps smaller because high bits may be needed for locking?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263179AbTDBWQ5>; Wed, 2 Apr 2003 17:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263180AbTDBWQ4>; Wed, 2 Apr 2003 17:16:56 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:21232 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S263179AbTDBWQz>;
	Wed, 2 Apr 2003 17:16:55 -0500
Date: Thu, 3 Apr 2003 00:35:57 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Robert Love <rml@tech9.net>
Cc: Antonio Vargas <wind@cocodriloo.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030402223557.GD13168@wind.cocodriloo.com>
References: <20030401125159.GA8005@wind.cocodriloo.com> <20030401164126.GA993@holomorphy.com> <20030401221927.GA8904@wind.cocodriloo.com> <20030402124643.GA13168@wind.cocodriloo.com> <20030402163512.GC993@holomorphy.com> <20030402213629.GB13168@wind.cocodriloo.com> <1049319300.2872.21.camel@localhost> <20030402220734.GC13168@wind.cocodriloo.com> <1049321427.2872.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049321427.2872.25.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 05:10:27PM -0500, Robert Love wrote:
> On Wed, 2003-04-02 at 17:07, Antonio Vargas wrote:
> 
> > Hmmm, we had some way for executing code just after an interrupt,
> > but outside interrupt scope... was it a bottom half? Can you
> > point me to some place where it's done?
> 
> Unfortunately uidhash_lock cannot be used from a bottom half either.
> 
> You can push it into a work queue.  See schedule_work() and the default
> events queue.

I'll take a look.

> > Ok, I did know m68k can do it, but wasn't sure about all other arches :)
> 
> Yep.  Everyone architecture I know of - and certainly all that Linux
> support - can do atomic read/writes to a word.  Thinking about it, it
> would be odd if not (two writes to a single word interleaving?).  There
> are places this assumption is used.
> 
> Anything more complicated, of course, needs atomic operations or locks.

"word == basic unit of transfer from/to memory" on your reasoning, I suppose.

I'm coding this now, hope I can post a basic implementation.

Greets, Antonio.

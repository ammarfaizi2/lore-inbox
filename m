Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267128AbTAURYM>; Tue, 21 Jan 2003 12:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbTAURYM>; Tue, 21 Jan 2003 12:24:12 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:8399 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S267128AbTAURYK>; Tue, 21 Jan 2003 12:24:10 -0500
Date: Tue, 21 Jan 2003 09:33:04 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [PATCH][2.5] hangcheck-timer
Message-ID: <20030121173303.GU20972@ca-server1.us.oracle.com>
References: <20030121011954.GO20972@ca-server1.us.oracle.com> <20030121081158.A21080@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030121081158.A21080@infradead.org>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 08:11:58AM +0000, Christoph Hellwig wrote:
> I can't your see the driver reference CONFIG_* directly anywhere.

	I don't, but I swear something needed it somewhere.  I'll look into
removing it.

> > +static int hangcheck_tick = DEFAULT_IOFENCE_TICK;
> > +static int hangcheck_margin = DEFAULT_IOFENCE_MARGIN;
> > +static int hangcheck_reboot = 0;  /* Do not reboot */
> 
> no need to initialize static variables to zero, they'll just go into .bss.

	No need, but it is good to explicity mention that the default is
not to reboot.

> It might be worth using Rusty's new module paramters for new code submitted
> to 2.5 instead of the legacy interfaces.

	I guess I should.  I'm still encountering the fact that the
module loader in 2.5.59 has issues.

> #if DEBUG maybe? or VERBOSE?

	Probably just to remove.  Missed it.

Joel

-- 

 One look at the From:
 understanding has blossomed
 .procmailrc grows
	- Alexander Viro


Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

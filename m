Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUE1NJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUE1NJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 09:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUE1NJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 09:09:48 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:58271 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263100AbUE1NJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:09:37 -0400
Date: Fri, 28 May 2004 15:09:35 +0200
From: bert hubert <ahu@ds9a.nl>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, arnd@arndb.de, drepper@redhat.com,
       linux-kernel@vger.kernel.org, mingo@redhat.com, schwidefsky@de.ibm.com
Subject: DOCUMENTATION Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-ID: <20040528130935.GA16819@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Jakub Jelinek <jakub@redhat.com>, Andrew Morton <akpm@osdl.org>,
	arnd@arndb.de, drepper@redhat.com, linux-kernel@vger.kernel.org,
	mingo@redhat.com, schwidefsky@de.ibm.com
References: <20040520093817.GX30909@devserv.devel.redhat.com> <20040520233639.126125ef.akpm@osdl.org> <20040521074358.GG30909@devserv.devel.redhat.com> <200405221858.44752.arnd@arndb.de> <20040524073407.GC4736@devserv.devel.redhat.com> <20040524011203.3be81d0a.akpm@osdl.org> <20040524081958.GD4736@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524081958.GD4736@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's a bit of a shame that you need to be a rocket scientist to 
> > understand the futex syscall interface.  Bert, are you still maintaining
> > the manpage?  If so, is there enough info here to update it?
> 
> The latest futex(2) or futex(4) manpage I saw doesn't mention FUTEX_REQUEUE
> at all.

Now fixed, please see http://ds9a.nl/futex-manpages - but please realise I'm
somewhat out of my depth. Comments welcome.

Futexes have mutated into complicated things, I wonder if this was the last
of the changes needed.

The big change in the manpages is the addition of FUTEX_REQUEUE and
FUTEX_CMP_REQUEUE. Furthermore, I realised that the futex system call does
not return EAGAIN etc, it returns -EAGAIN. I guesstimated that CMP_REQUEUE
will be merged before 2.6.7.

To clarify the overloaded situation wrt the futex syscall, I split it up in
three prototypes. 

Ulrich, does/will glibc provide a futex(2) function? Or should people just
call the syscall themselves? 

There were also some complaints I did not address futexfs but as far as I
can see, it is a kernel internal matter of no interest to userspace coders?

> Also, any futex man page should probably SEE ALSO Ulrich's futex paper:
> http://people.redhat.com/drepper/futex.pdf

Referenced, thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

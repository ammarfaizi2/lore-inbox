Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUE1PkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUE1PkL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 11:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbUE1PkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 11:40:11 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:56488 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263585AbUE1Pj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 11:39:56 -0400
Date: Fri, 28 May 2004 17:39:54 +0200
From: bert hubert <ahu@ds9a.nl>
To: Jakub Jelinek <jakub@redhat.com>
Cc: arnd@arndb.de, drepper@redhat.com, jamie@shareable.org,
       linux-kernel@vger.kernel.org, mingo@redhat.com, schwidefsky@de.ibm.com
Subject: Re: DOCUMENTATION Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-ID: <20040528153953.GA20648@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Jakub Jelinek <jakub@redhat.com>, arnd@arndb.de, drepper@redhat.com,
	jamie@shareable.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	schwidefsky@de.ibm.com
References: <20040520093817.GX30909@devserv.devel.redhat.com> <20040520233639.126125ef.akpm@osdl.org> <20040521074358.GG30909@devserv.devel.redhat.com> <200405221858.44752.arnd@arndb.de> <20040524073407.GC4736@devserv.devel.redhat.com> <20040524011203.3be81d0a.akpm@osdl.org> <20040524081958.GD4736@devserv.devel.redhat.com> <20040528130935.GA16819@outpost.ds9a.nl> <20040528140234.GH4736@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528140234.GH4736@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 10:02:34AM -0400, Jakub Jelinek wrote:

> The man pages in the 2nd section document the behaviour of the userland
> wrappers (see e.g. read(2)), not what the kernel actually returns.

Ok - but in the absence of futex(2), is it perhaps better to move this page
to futex(9)? Or merge it into futex(4)?

> > Ulrich, does/will glibc provide a futex(2) function? Or should people just
> > call the syscall themselves? 
> 
> glibc doesn't provide a futex(2) function, so at least ATM people can use
> #include <sys/syscall.h>

If it will provide one, I'll change the page to be in line with how futex(2)
will probably work, with errno etc.

Regarding the verbiage, I need input about the use of the word 'process', as
I'm not sure if there is a generic word covering both processes and threads.
Jamie suggests 'tasks', but that is kernel lingo and of little use for
userspace developers. Suggestions?

Thanks.

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

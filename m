Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVAGOnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVAGOnR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVAGOnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:43:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1677 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261439AbVAGOnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:43:08 -0500
Date: Fri, 7 Jan 2005 15:42:23 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Christoph Hellwig <hch@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107144223.GA28466@devserv.devel.redhat.com>
References: <20050107142637.GB20398@devserv.devel.redhat.com> <200501071438.j07EccJ0018170@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501071438.j07EccJ0018170@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 09:38:38AM -0500, Paul Davis wrote:
> >> rlimit_memlock limits the *amount* of memory that mlock() can be used
> >> on, not whether mlock can be used. at least, thats my understanding of
> >> the POSIX design for this. the man page and the source code for mlock
> >> support make that reasonably clear.
> >
> >eh no. It defaults to zero, but if you increase it for a specific user, that
> >user is allowed to mlock more.
> 
> from mm/mlock.c:do_mlock() in 2.6.8:
> 
> 	if (on && !capable(CAP_IPC_LOCK))
> 		return -EPERM;

now try 2.6.9 ;)
this deficiency got already fixed

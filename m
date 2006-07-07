Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWGGJ1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWGGJ1A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWGGJ1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:27:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14490 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932077AbWGGJ07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:26:59 -0400
Date: Fri, 7 Jul 2006 05:26:36 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Michael Kerrisk <michael.kerrisk@gmx.net>
Cc: Arjan van de Ven <arjan@infradead.org>, mtk-manpages@gmx.net,
       mtk-lkml@gmx.net, rlove@rlove.org, roland@redhat.com,
       eggert@cs.ucla.edu, torvalds@osdl.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       drepper@redhat.com
Subject: Re: Strange Linux behaviour with blocking syscalls and stop signals+SIGCONT
Message-ID: <20060707092636.GU3115@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com> <44AD5CB6.7000607@redhat.com> <20060707043220.186800@gmx.net> <44ADE9B6.1020900@redhat.com> <20060707050731.186770@gmx.net> <44ADFD43.4040204@redhat.com> <20060707070334.186790@gmx.net> <1152256856.3111.20.camel@laptopd505.fenrus.org> <20060707080212.186780@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707080212.186780@gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 10:02:12AM +0200, Michael Kerrisk wrote:
> There have been ABI changes in the past.  In the end, I assume 
> it's a question of relative desirability ("how broken is existing 
> behaviour"; or: "was that behaviour ever desirable/portable 
> anyway?") versus relative likelihood of breaking applications.

In futex(2) case (except FUTEX_LOCK_PI where we want it to be restartable),
getting EINTR rather than the getting the syscall restarted is very
desirable though and several NPTL routines rely on it.

	Jakub

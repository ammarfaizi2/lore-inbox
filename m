Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424204AbWKIW5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424204AbWKIW5S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424228AbWKIW5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:57:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44986 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424204AbWKIW5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:57:18 -0500
To: Zach Brown <zach.brown@oracle.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC][PATCH] Fix lock inversion aio_kick_handler()
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <20060729001032.GA7885@tetsuo.zabbo.net>
	<20060729013446.GA3387@kvack.org> <44CAC1AF.6010505@oracle.com>
	<x49velokztg.fsf@segfault.boston.devel.redhat.com>
	<4553B10F.1020505@oracle.com>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Thu, 09 Nov 2006 17:57:10 -0500
In-Reply-To: <4553B10F.1020505@oracle.com> (Zach Brown's message of "Thu, 09 Nov 2006 14:51:59 -0800")
Message-ID: <x49r6wckz3t.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> On Thu, 09 Nov 2006 14:51:59 -0800, Zach Brown <zach.brown@oracle.com> said:

Zach> > Zach> > Doh.  Unfortunately, this patch isn't entirely correct
Zach> as it > Zach> could race with > __put_ioctx() which sets
Zach> ioctx->mm = NULL.
Zach> > 
Zach> > Zach> Aha, yeah, that's what I was missing.  Thanks.
Zach> > 
Zach> > Zach> > Something like the following should do the trick:
Zach> > 
Zach> > Zach> Cool, I'll respin and send it out.
Zach> > 
Zach> > Did you ever resend this patch, Zach?

Zach> Sadly, no.  I vaguely remember thinking that the refcounting was
Zach> pretty messed up in these paths and that more than just this
Zach> patch was needed.  I don't remember the details.

Zach> Maybe I should take a look again :/.

Zach> > current kernels.  I'm still running into the lockdep warnings.

Zach> When doing what?  Working with that IO_CMD_EPOLL_WAIT patch?

Yep.  =)

-Jeff

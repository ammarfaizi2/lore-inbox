Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424226AbWKIWwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424226AbWKIWwB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424223AbWKIWwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:52:00 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:12774 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1424226AbWKIWwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:52:00 -0500
Message-ID: <4553B10F.1020505@oracle.com>
Date: Thu, 09 Nov 2006 14:51:59 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
MIME-Version: 1.0
To: Jeff Moyer <jmoyer@redhat.com>
CC: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC][PATCH] Fix lock inversion aio_kick_handler()
References: <20060729001032.GA7885@tetsuo.zabbo.net>	<20060729013446.GA3387@kvack.org> <44CAC1AF.6010505@oracle.com> <x49velokztg.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49velokztg.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Zach> > Doh.  Unfortunately, this patch isn't entirely correct as it
> Zach> could race with > __put_ioctx() which sets ioctx->mm = NULL.
> 
> Zach> Aha, yeah, that's what I was missing.  Thanks.
> 
> Zach> > Something like the following should do the trick:
> 
> Zach> Cool, I'll respin and send it out.
> 
> Did you ever resend this patch, Zach?

Sadly, no.  I vaguely remember thinking that the refcounting was pretty
messed up in these paths and that more than just this patch was needed.
 I don't remember the details.

Maybe I should take a look again :/.

> current kernels.  I'm still running into the lockdep warnings.

When doing what?  Working with that IO_CMD_EPOLL_WAIT patch?

- z

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWFSVIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWFSVIr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWFSVIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:08:47 -0400
Received: from xenotime.net ([66.160.160.81]:17540 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964888AbWFSVIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:08:47 -0400
Date: Mon, 19 Jun 2006 14:11:27 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hr
Subject: Re: [PATCH] ktime/hrtimer: fix kernel-doc comments
Message-Id: <20060619141127.abdfdac0.rdunlap@xenotime.net>
In-Reply-To: <1150750822.29299.86.camel@localhost.localdomain>
References: <20060619130948.6ea3998c.rdunlap@xenotime.net>
	<1150750822.29299.86.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 23:00:22 +0200 Thomas Gleixner wrote:

> Randy,
> 
> On Mon, 2006-06-19 at 13:09 -0700, Randy.Dunlap wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Fix kernel-doc formatting in ktime.h and hrtimer.[ch] files.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > ---
> >  include/linux/hrtimer.h |    3 ---
> >  include/linux/ktime.h   |    8 --------
> >  kernel/hrtimer.c        |   11 +----------
> >  3 files changed, 1 insertion(+), 21 deletions(-)
> > 
> > --- linux-2617-pv.orig/include/linux/ktime.h
> > +++ linux-2617-pv/include/linux/ktime.h
> > @@ -66,7 +66,6 @@ typedef union {
> >  
> >  /**
> >   * ktime_set - Set a ktime_t variable from a seconds/nanoseconds value
> > - *
> >   * @secs:	seconds to set
> >   * @nsecs:	nanoseconds to set
> >   *
> <.....>
> 
> Is there any real reason for doing this, expect for removing the blank
> comment lines ? 

Hm, have you looked at the kernel-doc output of those functions?

With the blank line, the function Description section (if there
is one) is duplicated.  If there is not a Description section
in the source file, then there is a (false) header generated
for it but nothing below it.

> My personal preference is to keep that line, as it makes it easier to
> read. But as always: de gustibus non est disputandum :)

Feel free to send patches for scripts/kernel-doc instead.  :)

---
~Randy

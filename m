Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWA2Tcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWA2Tcg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 14:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWA2Tcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 14:32:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751124AbWA2Tcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 14:32:36 -0500
Date: Sun, 29 Jan 2006 11:32:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Only allow a threaded init to exec from the
 thread_group_leader
Message-Id: <20060129113212.5b4a50ed.akpm@osdl.org>
In-Reply-To: <20060129152451.GD1764@elf.ucw.cz>
References: <m14q3nh7zi.fsf@ebiederm.dsl.xmission.com>
	<20060129003606.7887ecd9.akpm@osdl.org>
	<m1irs38h5v.fsf@ebiederm.dsl.xmission.com>
	<20060129024831.4474142f.akpm@osdl.org>
	<20060129152451.GD1764@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> On Ne 29-01-06 02:48:31, Andrew Morton wrote:
> > ebiederm@xmission.com (Eric W. Biederman) wrote:
> > >
> > >  If process id namespaces become a reality init stops being
> > >  terribly special, and becomes something you may have several
> > >  of running at any one time.  If one of those inits is compromised
> > >  by a hostile user I having the whole system go down so we can
> > >  avoid executing a cheap test sounds terribly wrong.  That is
> > >  why I really care.
> > 
> > Wouldn't it be better to do nothing until/unless there's some code in the
> > kernel or init which actually needs the change?
> 
> It is common to do init=/bin/bash, and I guess people are doing it
> with all kinds of wonderful apps....

err, good point.  And no reports of peculiar things happening with
threading.  Eric's check has the (slight) potential to cause some things to
stop working though.

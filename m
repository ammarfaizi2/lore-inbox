Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWHPE3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWHPE3k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 00:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWHPE3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 00:29:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750738AbWHPE3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 00:29:39 -0400
Date: Tue, 15 Aug 2006 21:28:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, containers@lists.osdl.org,
       linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [Containers] [PATCH 2/7] pid: Add do_each_pid_task
Message-Id: <20060815212847.6f88e63a.akpm@osdl.org>
In-Reply-To: <20060816031043.GE15241@sergelap.austin.ibm.com>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	<11556661923847-git-send-email-ebiederm@xmission.com>
	<20060816031043.GE15241@sergelap.austin.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 22:10:43 -0500
"Serge E. Hallyn" <serue@us.ibm.com> wrote:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
> > To avoid pid rollover confusion the kernel needs to work with
> > struct pid * instead of pid_t.  Currently there is not an iterator
> > that walks through all of the tasks of a given pid type starting
> > with a struct pid.  This prevents us replacing some pid_t instances
> > with struct pid.  So this patch adds do_each_pid_task which walks
> > through the set of task for a given pid type starting with a struct pid.
> > 
> > Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> > ---
> >  include/linux/pid.h |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/linux/pid.h b/include/linux/pid.h
> > index 93da7e2..4007114 100644
> > --- a/include/linux/pid.h
> > +++ b/include/linux/pid.h
> > @@ -118,4 +118,17 @@ #define while_each_task_pid(who, type, t
> >  				1; }) );				\
> >  	}
> >  
> > +#define do_each_pid_task(pid, type, task)				\
> 
> Hmm, defining do_each_pid_task right after do_each_task_pid could result
> in some frustration  :)

That's all right - developers can read the comments to work out what each
one does.

<seems I'm having a sarcastic day>


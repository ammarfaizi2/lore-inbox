Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVGGAXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVGGAXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVGFUBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:01:19 -0400
Received: from mailsrvr2.bull.com ([192.90.162.8]:48295 "EHLO
	mailsrvr2.bull.com") by vger.kernel.org with ESMTP id S262371AbVGFRIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:08:47 -0400
In-Reply-To: <1120608033.10572.72.camel@c-67-188-6-232.hsd1.ca.comcast.net>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resend:[RFC/Patch] Robust futexes
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OF9B9E3D47.B339361B-ON07257036.005CA230-07257036.005E257A@us-phx1.az05.bull.com>
From: Todd.Kneisel@Bull.com
Date: Wed, 6 Jul 2005 10:08:19 -0700
X-MIMETrack: Serialize by Router on US-PHX1/US/BULL(Release 6.5.1|January 21, 2004) at
 07/06/2005 10:08:29 AM,
	Serialize complete at 07/06/2005 10:08:29 AM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've made relatively minor changes to the glibc side since posting
the patch to the robust mutexes list.
- added EOWNERDEAD and ENOTRECOVERABLE to the glibc error reporting
  mechanism, so that strerror() works.
- added function prototypes to pthread.h for 
pthread_mutexattr_getrobust_np,
  pthread_mutexattr_setrobust_np, and pthread_mutex_consistent_np.
- defined a constant for accessing the pid that's stored in the futex.
- Changed copyrights from Bull SA (the French division of our company)
  to Bull HN (The U.S. division).

We expect to receive the FSF contracts for copyright assignment any
day now. If anyone would like to see the glibc changes, I can provide
the patch under the Bull HN copyright. The patch applies to glibc-2.3.4.

Todd.


Daniel Walker <dwalker@mvista.com> wrote on 07/05/2005 05:00:32 PM:

> 
> You might want to CC Andrew Morton , and Rusty Russell.
> 
> What is the status of the glibc side of this?
> 
> Daniel
> 
> 
> On Tue, 2005-07-05 at 16:11 -0700, Todd Kneisel wrote:
> > This is a resend of my patch to add robust futex support to the 
existing
> > sys_futex system call. The patch applies to 2.6.12. Any comments or
> > discussion will be welcome.
> > 
> > Changes since my last posted version:
> > - Applies to 2.6.12, was 2.6.12-rc6
> > - Added config option CONFIG_ROBUST_FUTEX, depends on existing 
CONFIG_FUTEX
> >    and defaults to no.
> > - Commented functions, using kernel-doc style comments
> > - Cleaned up some CodingStyle violations
> > 

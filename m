Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422670AbWBAQML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422670AbWBAQML (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422671AbWBAQML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:12:11 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:8401 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422670AbWBAQMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:12:10 -0500
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060201132607.GA670@elte.hu>
References: <1138736609.7088.35.camel@localhost.localdomain>
	 <20060201130818.GA26481@elte.hu>
	 <1138800181.7088.51.camel@localhost.localdomain>
	 <20060201132607.GA670@elte.hu>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 11:11:56 -0500
Message-Id: <1138810316.7088.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 14:26 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 2006-02-01 at 14:08 +0100, Ingo Molnar wrote:
> > > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > [pls. use -p when generating patches]
> > > 
> > 
> > OK, how do you make quilt do that?
> 
> hm, i'm using 0.42, and this command:
> 
>   #!/bin/bash
> 
>   quilt refresh --diffstat --sort --no-timestamps -p 1 $@
> 
> does the -p thing automatically. (the -p option to quilt is for the 
> patch-file-depth, not for the function-name thing.)

Found it.  Do you have QUILT_DIFF_OPTS set as an environment variable?
If I do the following:

QUILT_DIFF_OPTS='-p' quilt refresh

It works.

I guess I'll add that to my .bash_profile.

Thanks,

-- Steve



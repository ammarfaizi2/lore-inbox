Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318941AbSH2HFv>; Thu, 29 Aug 2002 03:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318965AbSH2HFv>; Thu, 29 Aug 2002 03:05:51 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:47726 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318941AbSH2HFu>; Thu, 29 Aug 2002 03:05:50 -0400
Date: Thu, 29 Aug 2002 03:10:08 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Daniel Jacobowitz <dan@debian.org>, junkio@cox.net,
       linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>,
       geert@linux-m68k.org, schwidefsky@de.ibm.com, torvalds@transmeta.com
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1)
Message-ID: <20020829031008.T7920@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20020829032642.GA9201@nevyn.them.org> <20020829015407.7DFCE2C0D9@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020829015407.7DFCE2C0D9@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Aug 29, 2002 at 04:29:04PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 04:29:04PM +1000, Rusty Russell wrote:
> In message <20020829032642.GA9201@nevyn.them.org> you write:
> > Also disagree; besides, the evidence implies that Keith is wrong.  GCC
> > 2.95.3:
> 
> i386, m68k, s390 and s390x define inline strlen() versions, so they
> are don't optimize strlen("literal").
> 
> This premature optimization should probably be fixed,

Well, IMHO at least for the more recent GCC versions kernel
should leave the job to GCC (ie. either just prototype str* functions,
or define them to __builtin_str* variants).

	Jakub

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262406AbTC0Bqe>; Wed, 26 Mar 2003 20:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbTC0Bqe>; Wed, 26 Mar 2003 20:46:34 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:3055 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262406AbTC0Bqd>; Wed, 26 Mar 2003 20:46:33 -0500
Date: Wed, 26 Mar 2003 17:56:00 -0800
From: Chris Wright <chris@wirex.com>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setfs[ug]id syscall return value and include/linux/security.h question
Message-ID: <20030326175600.A20611@figure1.int.wirex.com>
Mail-Followup-To: David Wagner <daw@mozart.cs.berkeley.edu>,
	linux-kernel@vger.kernel.org
References: <20030326181509.Q13397@devserv.devel.redhat.com> <b5tdbk$hoj$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <b5tdbk$hoj$1@abraham.cs.berkeley.edu>; from daw@mozart.cs.berkeley.edu on Wed, Mar 26, 2003 at 11:33:08PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Wagner (daw@mozart.cs.berkeley.edu) wrote:
> Jakub Jelinek  wrote:
> >Before include/linux/security.h was added, setfsuid/setfsgid always returned
> >old_fsuid, no matter if the fsuid was actually changed or not.
> 
> Out of curiousity:
> 
> Do you have any idea why setfsuid() returns the old fsuid, rather than
> 0 or -EPERM like all the other set*id() calls?

I agree, it seems odd.

> I find it mysterious that setfsuid()'s interface is so different.
> It is also strange that setfsuid() has no way to indicate whether the
> call failed or succeeded.  Does this inconsistency with the rest of the
> set*id() interface strike anyone else as a little odd?

You're not alone ;-)  Even the manpage suggests this is a bug.

> It is also mysterious that there is no getfsuid() call.  One has to use
> /proc to find this information.  Do you have any idea why the fsuid/fsgid
> interface was designed this way?  Is this an old kludge that we now have
> to live with, was it designed this way for a reason, or do we have the
> opportunity to fix the semantics of the interface?

I can't comment on the history of the interface.  While it's Linux
specific, I'm not sure of the legacy impact of changing the semantics of
the current interface.  Ugh.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266105AbTLIUcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266104AbTLIUSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:18:05 -0500
Received: from zeus.kernel.org ([204.152.189.113]:37280 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266111AbTLIUPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:15:39 -0500
To: "Chris Croswhite" <csc@cadence.com>
Cc: <linux-kernel@vger.kernel.org>, <nfs@lists.sourceforge.net>
Subject: Re: [NFS] Re: [NFS client] NFS locks not released on abnormal process termination
References: <EE335453C5C57840823404C684F9F61702417581@exmbx01sj.cadence.com>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 09 Dec 2003 11:26:48 -0800
In-Reply-To: <EE335453C5C57840823404C684F9F61702417581@exmbx01sj.cadence.com>
Message-ID: <87wu95u70n.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chris Croswhite" <csc@cadence.com> writes:

> Philippe,
> 
> What patches are you refering to?

The one in <87llpms8yr.fsf@ceramic.fifi.org> named
linux-2.4.23-nfs-lock-race-2.patch 

Here a link to MARC, since the sourceforge mailing list web page
sucks:

  http://marc.theaimsgroup.com/?l=linux-nfs&m=107095817723325&w=2

Phil.

> -----Original Message-----
> From:	Philippe Troin [mailto:phil@fifi.org]
> Sent:	Tue 09-Dec-03 10:46
> To:	Trond Myklebust
> Cc:	Kenny Simpson; linux-kernel@vger.kernel.org; nfs@lists.sourceforge.net
> Subject:	[NFS] Re: [NFS client] NFS locks not released on abnormal process termination
> Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> 
> > >>>>> " " == Philippe Troin <phil@fifi.org> writes:
> > 
> >      > From my reading of the patch, it supersedes the old patch, and
> >      > is only
> >      > necessary on the client. Is also does not compile :-)
> > 
> > Yeah, I admit I didn't test it out...
> > 
> >      > Here's an updated patch which does compile.
> > 
> > Thanks.
> > 
> >      > I am still running tests, but so far it looks good (that is all
> >      > locks are freed when a process with locks running on a NFS
> >      > client is killed).
> > 
> > Good...
> 
> I've ran test overnight on four boxen, and no locks were lost.
> I guess you can send this patch to Marcello now.
> 
> I've tested with the enclosed program.
> 
>  
> > There are still 2 other issues with the generic POSIX locking code.
> > Both issues have to do with CLONE_VM and have been raised on
> > linux-kernel & linux-fsdevel. Unfortunately they met with no response,
> > so I'm unable to pursue...
> 
> Can we help? Pointers?
> 
> Phil.
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> NFS maillist  -  NFS@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/nfs

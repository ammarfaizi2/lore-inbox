Return-Path: <linux-kernel-owner+w=401wt.eu-S965100AbWLOFCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWLOFCE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 00:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWLOFCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 00:02:04 -0500
Received: from [213.184.169.238] ([213.184.169.238]:32845 "EHLO
	localhost.localdomain" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965100AbWLOFCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 00:02:01 -0500
From: Al Boldi <a1426z@gawab.com>
To: Nikolai Joukov <kolya@cs.sunysb.edu>
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
Date: Fri, 15 Dec 2006 08:03:01 +0300
User-Agent: KMail/1.5
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
References: <Pine.GSO.4.53.0612122217360.22195@compserv1> <200612141412.30686.a1426z@gawab.com> <Pine.GSO.4.53.0612141828220.8234@compserv1>
In-Reply-To: <Pine.GSO.4.53.0612141828220.8234@compserv1>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200612150803.01246.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikolai Joukov wrote:
> > > We started the project in April 2004.  Right now I am using it as my
> > > /home/kolya file system at home.  We believe that at this stage RAIF
> > > is mature enough for others to try it out.  The code is available at:
> > >
> > > 	<ftp://ftp.fsl.cs.sunysb.edu/pub/raif/>
> > >
> > > The code requires no kernel patches and compiles for a wide range of
> > > kernels as a module.  The latest kernel we used it for is 2.6.13 and
> > > we are in the process of porting it to 2.6.19.
> > >
> > > We will be happy to hear your back.
> >
> > When removing a file from the underlying branch, the oops below happens.
> > Wouldn't it be possible to just fail the branch instead of oopsing?
>
> This is a known problem of all Linux stackable file systems.  Users are
> not supposed to change the file systems below mounted stackable file
> systems (but they can read them).  One of the ways to enforce it is to use
> overlay mounts.  For example, mount the lower file systems at
> /raif/b0 ... /raif/bN and then mount RAIF at /raif.  Stackable file
> systems recently started getting into the kernel and we hope that there
> will be a better solution for this problem in the future.  Having said
> that, you are right: failing the branch would be the right thing to do.

Good.  It seems that there is also some tmpfs/raif-over-nfs deadlock 
situation.  Can't really tell if it's the kernel or the raif, but when do 
you think the patches could be brought into sync with the current mainline?


Thanks!

--
Al


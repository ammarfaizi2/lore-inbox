Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbTBJR5m>; Mon, 10 Feb 2003 12:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbTBJR5m>; Mon, 10 Feb 2003 12:57:42 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48215 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262208AbTBJR5l>; Mon, 10 Feb 2003 12:57:41 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net, fastboot@osdl.org
Subject: Re: [Fastboot] Re: Kexec on 2.5.59 problems ?
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org>
	<3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org>
	<20030210164401.A11250@in.ibm.com>
	<1044896964.1705.9.camel@andyp.pdx.osdl.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Feb 2003 11:07:06 -0700
In-Reply-To: <1044896964.1705.9.camel@andyp.pdx.osdl.net>
Message-ID: <m13cmwyppx.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Mon, 2003-02-10 at 03:14, Suparna Bhattacharya wrote:
> > I am using the OSDL versions of the kexec patches for
> > 2.5.59 (plm 1442 and 1444) for lkcd-kexec based crash dump
> > work.
> 
> <snip>
> 
> > 
> > Surprisingly though, when I tried just a simple 
> > kexec -e today (having loaded the kernel earlier on), 
> > I ran into the following Oops, consistently:
> > 
> > I'm using kexec-tools-1.8, and this has worked for me
> > earlier. The test system is a 4way SMP machine.
> > 
> > Has anyone seen this as well ?  (I'd already issued init 1 
> > and unmounted filesystems by this point)

Hmm.  Would love to know which cpu this is on...

I think the primary candidate if this only occurs in smp is
the switch_mm.  It may be that modifying the init_mm is not safe,
or it gets zapped somewhere else.

As soon as I get distractions in other directions under control
I will take a look.

Eric

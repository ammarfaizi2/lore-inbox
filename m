Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263081AbSJaUxU>; Thu, 31 Oct 2002 15:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbSJaUxU>; Thu, 31 Oct 2002 15:53:20 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:18127 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S263081AbSJaUxT>; Thu, 31 Oct 2002 15:53:19 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "David C. Hansen" <haveblue@us.ibm.com>
Cc: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Date: Thu, 31 Oct 2002 12:49:50 -0800 (PST)
Subject: Re: Reiser vs EXT3
In-Reply-To: <1036090969.4272.59.camel@nighthawk>
Message-ID: <Pine.LNX.4.44.0210311248030.25405-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

note that breaking up this locking bottleneckhas been done in the 2.5
kernel series so when 2.6 is released this should be much less significant
(Q2 2003 is the current thought, but don't count on it until it's out)

David Lang

On 31 Oct 2002, David C. Hansen wrote:

> Date: 31 Oct 2002 11:02:49 -0800
> From: David C. Hansen <haveblue@us.ibm.com>
> To: Robert L. Harris <Robert.L.Harris@rdlg.net>
> Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
> Subject: Re: Reiser vs EXT3
>
> On Thu, 2002-10-31 at 06:19, Robert L. Harris wrote:
> >
> >   Still working on that replacement mail server and a new rumor has hit
> > the mix.  It follows that reiserfs is much faster than ext3 (made ext3,
> > not converted from ext2 if it matters) and this is causing some
> > problems.  On a 200Gig filesystem is this truely an issue?
>
> ext3 has some SMP scalability problems.  The BKL is used to protect many
> journal operations, and we see huge amounts of CPU spent spinning on it
> on 4/8/16 proc machines.  So much CPU, that it masks anything else we're
> doing on the system.  But, on a single-proc or just a 2-way, you
> probably won't see much of this to be significant.
>
> We haven't tested reiser extensively here, but from what I've seen it
> scales much, much better than ext3 (as does jfs and probably xfs too).
> --
> Dave Hansen
> haveblue@us.ibm.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

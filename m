Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbSCKSng>; Mon, 11 Mar 2002 13:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287631AbSCKSn0>; Mon, 11 Mar 2002 13:43:26 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:30177 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S287408AbSCKSnU>; Mon, 11 Mar 2002 13:43:20 -0500
Message-Id: <200203111755.KAA11787@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: elenstev@mesatop.com, Hans Reiser <reiser@namesys.com>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Date: Mon, 11 Mar 2002 11:41:00 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203110508080.17717-100000@mhw.ULib.IUPUI.Edu> <3C8CD687.5000608@namesys.com> <200203111540.IAA11492@tstac.esa.lanl.gov>
In-Reply-To: <200203111540.IAA11492@tstac.esa.lanl.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 March 2002 09:25 am, Steven Cole wrote:
> On Monday 11 March 2002 09:08 am, Hans Reiser wrote:
> > Steven Cole wrote:
> > >Quoting from "VMS General User's Manual", section 2.1.1 Filenames,
> > > Types, and Versions, "You can control the number of versions of a file
> > > by specifying the /VERSION_LIMIT qualifier to the DCL commands
> > > CREATE/DIRECTORY, SET DIRECTORY, and SET FILE."
> > >
> > >It has been a while (about 12 years), but IIRC, you could set
> > > /VERSION_LIMIT=1 and effectively get rid of the annoying versions.  But
> > > some people, the Aunt Tillie types, were always tripping over their
> > > shoelaces and unintentially deleting files. For those people, the
> > > version feature probably seemed a blessing rather than a curse.
> > >
> > >Steven
> >
> > So with every command to create a directory you had to add an extra
> > parameter specifying that you didn't want extra versions or else you got
> > them?
> >
> > Hans
>
> That is not my recollection.  What I remember is that our system
> admistrator set up people's accounts so that the default behaviour was as
> desired by the individual.  This has gotten me curious, so I went out to a
> storage container and dug out an old VAX 4000/60 which hasn't run since
> about 1992.  If it works, I'll be able to answer with more than vague
> memories.  At least for VMS 5.1, which is just a bit out of date as the
> current version is 7.3 or so.  Now, if can just remember the SYSTEM
> password. ;-)
>

Apologies to all who don't care about VMS and file version numbers..
OK, no more vague memories.  I got my old VAX 4000 powered up, and three
amazing things happened:

1) The VAX booted even though it had been gathering dust for 10 years.
2) I remembered the SYSTEM password, and my password too!
3) VMS 5.5-2 was Y2K ready in 1992, taking today's date with no problem.

I fiddled around a bit with VMS, and it looks like the following command set things
up for me so that I only have one version for any new files I create:

SET DIRECTORY/VERSION_LIMIT=1 SYS$SYSDEVICE:[USERS.STEVEN]

This change was persistant across logins.  Hope this helps.

Steven

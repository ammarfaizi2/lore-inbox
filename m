Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293689AbSCKLFF>; Mon, 11 Mar 2002 06:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293688AbSCKLEz>; Mon, 11 Mar 2002 06:04:55 -0500
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:59084 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S293684AbSCKLEp>; Mon, 11 Mar 2002 06:04:45 -0500
Date: Mon, 11 Mar 2002 06:04:45 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.GSO.4.21.0203101623400.7778-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0203110549350.17717-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2002, Alexander Viro wrote:
> On Sun, 10 Mar 2002, Alan Cox wrote:
>
> > Its trickier than that - because all your other semantics have to align,
> > its akin to the undelete problem (in fact its identical). Do you version on
> > a rewrite, on a truncate, only on an O_CREAT ?
>
> Even better, what do you do upon link(2)?  Or rename(2) over one of the
> versions...

TOPS-20 never had the concept of link(2), and VMS has an anemic version
that nobody ever used so far as I know.  (There are a few VMS programs
which use the ability to create a file with *no directory links at all*,
which occasionally leaves some interesting puzzles for the sysadmin after
a crash.)

Renaming would create a new version, I think, so it might push the oldest
version off the end.  Explicitly renaming as existing version N should
have no side-effects (other than deletion of the original content of
version N).

> VMS is not UNIX.  And union of these two will be hell - incompatible models,
> let alone features.  "Well, I don't use <list of Unix features>" is not an
> answer - other people have different sets of things they don't use and you
> can be sure that every thing you don't care about is absolute must-have
> for somebody else.

True.  Studying other OSes for useful ideas is sensible, but swiping those
ideas wholesale only works if the two are fairly closely aligned in the
affected area.  Sometimes the idea needs major rework, and sometimes the
graft produces a monster.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Our lives are forever changed.  But *that* is exactly as it always was.


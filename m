Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293676AbSCKKqn>; Mon, 11 Mar 2002 05:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293678AbSCKKqe>; Mon, 11 Mar 2002 05:46:34 -0500
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:55756 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S293676AbSCKKqT>; Mon, 11 Mar 2002 05:46:19 -0500
Date: Mon, 11 Mar 2002 05:46:16 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <200203101941.g2AJfSD19756@lmail.actcom.co.il>
Message-ID: <Pine.LNX.4.33.0203110508080.17717-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2002, Itai Nahshon wrote:
> On Sunday 10 March 2002 10:36, Hans Reiser wrote:
> > I think that if version control becomes as simple as turning on a plugin
> > for a directory or file, and then adding a little to the end of a
> > filename to see and list the old versions, Mom can use it.
>
> IIRC that was a feature in systems from DEC even before
> VMS (I'm talking about the late 70's).  eg. file.txt;2 was revision 2
> of file.txt.
>
> I don't know if this feature was in the file-system or in the text editor
> that I have used.

It's part of the TOPS-20 filesystem.  If you try to create a file which
already exists, you get a new version of the file with length zero.  Each
file has a version limit in its directory entry, and when the limit is
exceeded the oldest version is automagically deleted.  The version limit
is copied from the highest existing version to the new version, and the
limit on the highest version determines whether old versions are dropped.

VMS does something similar, although ODS-2 tries to be clever by packing
all of the versions' index-file pointers together after a single copy of
the version-less name in the directory block.  Originally the two used
different punctuation to set off the version number, but when Digital
killed the PDP10 line VMS was adjusted to accept the TOPS-20 form as well,
as a sop to LCG customers who were being steered into an unfamiliar
product line.  IIRC TOPS-20 names were name.extension.version, while VMS
native names are name.extension;version .

RSX-11 (VMS' ancestor) may have had versions too.  I've only used the
hacked RSX20F variety used as the console monitor for KL10 systems, but I
seem to recall versioning there.  Or maybe I'm recalling the RSX-11 flavor
(POS) which ran the Pro300 console on the VAX 8800.

> The basic features were not even close to what you get from RCS or
> SCCS.

Indeed.  The only essential relationship between two versions of a file is
that their names resemble each other.  The content is entirely distinct.
It was usually used to prevent the "oops, I shouldn't have saved that"
syndrome.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
; 11-Mar-2002	MHW	Support the 2080


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317853AbSFNAAu>; Thu, 13 Jun 2002 20:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317854AbSFNAAt>; Thu, 13 Jun 2002 20:00:49 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:266 "EHLO
	whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S317853AbSFNAAt>; Thu, 13 Jun 2002 20:00:49 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: viro@math.psu.edu
X-Envelope-Sender: stevie@qrpff.net
Message-Id: <5.1.0.14.2.20020613195114.0225abd0@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 13 Jun 2002 19:54:22 -0400
To: Alexander Viro <viro@math.psu.edu>, Francois Gouget <fgouget@free.fr>
From: Stevie O <stevie@qrpff.net>
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0206130454040.18281-100000@weyl.math.psu.edu
 >
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:18 AM 6/13/2002 -0400, Alexander Viro wrote:
>I don't see where VFS would come into the game - what you had described
>is behaviour of ->symlink() and ->lookup() of filesystem in question.
>For VFS name components are arbitrary sequences of characters other than
>'\0' and '/'.  Period.  It has no idea of extensions, maximal component
>lengths, etc.
>
>Moreover, names returned by ->readdir() are not interpreted - they are
>responsibility of filesystem in question.  Ditto for limits you place
>on the names acceptable for ->create(), ->mkdir(), etc. - it's up to
>filesystem.
>
>Same goes for the way you store and interpret symlinks - VFS has no
>business messing with that; that's what ->readlink() and ->follow_link()
>are for.
>
>_If_ you want to use "add magical 4 bytes to the end of component to
>indicate a symlink" - more power to you, but that's nothing but a
>detail of your filesystem layout.  You are making a directory with
>both 'foo' and 'foo.!nk' invalid, but that's the matter of fsck for
>your filesystem and ability of fs driver to cope with such error
>gracefully.

Sounds great.

Now add this to NTFS, iso9660, and vfat, without directly modifying any of the three filesystems (otherwise you'd need to maintain patches for different versions of these filesystem drivers).


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE


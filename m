Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbTB0JBv>; Thu, 27 Feb 2003 04:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTB0JBv>; Thu, 27 Feb 2003 04:01:51 -0500
Received: from dsl-212-144-205-077.arcor-ip.net ([212.144.205.77]:24961 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id <S262449AbTB0JBu> convert rfc822-to-8bit; Thu, 27 Feb 2003 04:01:50 -0500
From: Dominik Kubla <dominik@kubla.de>
To: Kasper Dupont <kasperd@daimi.au.dk>
Subject: Re: About /etc/mtab and /proc/mounts
Date: Thu, 27 Feb 2003 10:11:59 +0100
User-Agent: KMail/1.5
Cc: Miles Bader <miles@gnu.org>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
References: <20030219112111.GD130@DervishD> <200302270808.21035.dominik@kubla.de> <3E5DC86C.93AFA6CB@daimi.au.dk>
In-Reply-To: <3E5DC86C.93AFA6CB@daimi.au.dk>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200302271012.02283.dominik@kubla.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 February 2003 09:12, Kasper Dupont wrote:
> Dominik Kubla wrote:
> > I would recommend to replace /etc/mtab with a pseudo-FS like Sun did
> > for /etc/mnttab:
...
> How does that thing behave? I have considered a /proc/mtab implementation,
> that might be slightly similar. 

Quoting the Solaris 8 man page:

File Formats                                            mnttab(4)

NAME
     mnttab - mounted file system table

DESCRIPTION
     The file /etc/mnttab is really a file system  that  provides
     read-only  access  to  the table of mounted file systems for
     the current host. /etc/mnttab is read by programs using  the
     routines  described in getmntent(3C). Mounting a file system
     adds an entry to this table.  Unmounting  removes  an  entry
     from  this table. Remounting a file system causes the infor-
     mation in the mounted file system table  to  be  updated  to
     reflect any changes caused by the remount. The list is main-
     tained by the kernel in order of mount time.  That  is,  the
     first  mounted file system is first in the list and the most
     recently mounted file system is  last.  When  mounted  on  a
     mount  point  the file system appears as a regular file con-
     taining the current mnttab information.
[...]
NOTES
     The snapshot of the mnttab information is taken any  time  a
     read(2)  is  performed  at  offset  0 (the beginning) of the
     mnttab file. The file modification time returned by  stat(2)
     for  the  mnttab  file  is  the  time  of the last change to
     mounted file  system  information.  A  poll(2)  system  call
     requesting  a POLLRDBAND event can be used to block and wait
     for the system's mounted file system information to be  dif-
     ferent  from  the most recent snapshot since the mnttab file
     was opened.

Regards,
  Dominik Kubla
-- 
"What this  country needs is  a short, victorious war  to stem the  tide of
revolution." (V.K. von Plehve, Russian Minister  of Interior on the  eve of
the Russo-Japanese war.)


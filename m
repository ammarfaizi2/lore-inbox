Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289212AbSASNTY>; Sat, 19 Jan 2002 08:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289211AbSASNTP>; Sat, 19 Jan 2002 08:19:15 -0500
Received: from 90dyn204.com21.casema.net ([62.234.21.204]:36747 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S289213AbSASNS5>; Sat, 19 Jan 2002 08:18:57 -0500
Message-Id: <200201191318.OAA13552@cave.bitwizard.nl>
Subject: Re: rm-ing files with open file descriptors
In-Reply-To: <1011444389.25261.5.camel@bip> from Xavier Bestel at "Jan 19, 2002
 01:46:29 pm"
To: Xavier Bestel <xavier.bestel@free.fr>
Date: Sat, 19 Jan 2002 14:18:52 +0100 (MET)
CC: Alexander Viro <viro@math.psu.edu>, Matthias Schniedermeyer <ms@citd.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:
> On Sat, 2002-01-19 at 13:29, Alexander Viro wrote:
> > 
> > 
> > On 19 Jan 2002, Xavier Bestel wrote:
> > 
> > > On Sat, 2002-01-19 at 13:16, Matthias Schniedermeyer wrote:
> > > > > > Well no. new_fd will refer to a completely new, empty file
> > > > > > which has no relation to the old file at all.
> > > > > > 
> > > > > > There is no way to recreate a file with a nlink count of 0,
> > > > > > well that is until someone adds flink(fd, newpath) to the kernel.
> > > > > > 
> > > > > 
> > > > > This *might* work:
> > > > > 
> > > > > link("/proc/self/fd/40", newpath);
> > > > 
> > > > cat /proc/<id>/fd/<nr> > whatever
> > > > actually works.
> > > 
> > > Once it's unliked ? I doubt it.
> > 
> > Egads...  It certainly works, unlinked or not.  Please learn the basics of
> > Unix filesystem semantics.
> 
> Indeed, it works, but it doesn't with a true symlink. What kind of a
> link is that /proc/<id>/fd/<nr> entry ? It's not a symlink even if it
> looks like one.

Highly correct!

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUBOBgq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 20:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbUBOBgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 20:36:46 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:55182 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263775AbUBOBgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 20:36:43 -0500
Date: Sun, 15 Feb 2004 01:36:42 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Szakacsits Szabolcs <szaka@sienet.hu>
cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ntfs-dev@lists.sourceforge.net,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [Linux-NTFS-Dev] [2.4] off-by-one kmalloc in ntfs
In-Reply-To: <Pine.SOL.4.58.0402150122360.18477@yellow.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0402150135330.18477@yellow.csi.cam.ac.uk>
References: <Pine.LNX.4.21.0402141308460.20885-100000@mlf.linux.rulez.org>
 <Pine.SOL.4.58.0402150122360.18477@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Feb 2004, Anton Altaparmakov wrote:

> On Sat, 14 Feb 2004, Szakacsits Szabolcs wrote:
> > On Sat, 14 Feb 2004, Herbert Xu wrote:
> > > This patch fixes an off-by-one kmalloc bug in ntfs in 2.4.24.
> > Thanks for your time fixing bugs in the legacy driver.
> >
> > May I be interested in your motivations? Recently there is a clear flow of
> > RedHat refugees to Debian and if you would like better NTFS support then
> > perhaps Debian should use the backport of the rewritten NTFS driver too,
> > just like all other distros do who care about NTFS support.
> >
> > You can find some of the differences between the legacy (in vanilla 2.4)
> > and the Linux-NTFS project's NTFS driver (it's in in 2.6 and there is
> > a backport maintained for 2.4):
> >
> > 	http://linux-ntfs.sourceforge.net/status.html
> >
> > Besides the several drawbacks vanila 2.4 driver has, I'm aware of only two
> > features it's capable but not the rewritten one:
> >
> >    - NTFS can be exported via NFS. This came without any work but it would
> >      need some time to support with the new driver. There was one request
> >      for this feature in the last two years so it's not the highest priority
>
> The to be released NTFS 2.0.7 for 2.6 kernel adds support for exporting

oops, I meant 2.1.7

> via NFS.  (-:  Unfortunately last week the hd at my computer at work blew
> up so I didn't get round to doing my final testing so I haven't officially
> released 2.0.7 yet but hopefully I will release it next week.  Assuming

and again 2.1.7

> 2.4 now uses the same mechanism for exporting via NFS (I am not sure if
> the 2.6 changes were backported or not) it will be easy to update the NTFS
> backport with this feature.
>
> >    - one can trash his/her NTFS or the box (the legacy diver is not SMP,
> >      reentrant safe). AFAIK, no plan to add this feature to the new driver
> >      neither in the short nor in long term.
>
> Yes, most definitely we have no intention of implementing that feature in
> the new driver! (-:
>
> Best regards,
>
> 	Anton
>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

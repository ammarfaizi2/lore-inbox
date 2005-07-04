Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVGDQDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVGDQDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 12:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVGDQCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 12:02:15 -0400
Received: from ms-smtp-04-lbl.southeast.rr.com ([24.25.9.103]:30928 "EHLO
	ms-smtp-04-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S261364AbVGDPzq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 11:55:46 -0400
Message-Id: <200507041555.j64FtFL4010937@ms-smtp-04-eri0.southeast.rr.com>
From: "Gautam Singaraju" <gsingara@uncc.edu>
To: "'Anton Altaparmakov'" <aia21@cam.ac.uk>,
       "'Daniel Drake'" <dsd@gentoo.org>
Cc: "=?iso-8859-1?Q?'David_G=F3mez'?=" <david@pleyades.net>,
       "'Robert Love'" <rml@novell.com>,
       "'John McCutchan'" <ttb@tentacle.dhs.org>,
       "'Linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Problem with inotify
Date: Mon, 4 Jul 2005 11:55:01 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-index: AcWAqyzXcTC33QXBR8uaazBVdeG3ogAAlkdw
In-reply-to: <1120489922.11399.10.camel@imp.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton,

I had used the 2.6.12 kernel with the latest Inotify. There was no
"I_WILL_FREE" in the any place. And, there was no problem in compilation.

I believe Inotify is very useful and should be included in the next versions
of the kernel. Are there any ongoing plans for this?
 
Thanks,
Gautam Singaraju
SIS Dept., UNC Charlotte

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Anton Altaparmakov
Sent: Monday, July 04, 2005 11:12 AM
To: Daniel Drake
Cc: David Gómez; Robert Love; John McCutchan; Linux-kernel
Subject: Re: Problem with inotify

On Mon, 2005-07-04 at 15:39 +0100, Anton Altaparmakov wrote:
> On Mon, 2005-07-04 at 15:27 +0100, Anton Altaparmakov wrote:
> > On Sun, 2005-07-03 at 11:34 +0100, Daniel Drake wrote:
> > > I reverted the patch you sent earlier
> > > (inotify_unmount_inodes-list-iteration-fix.diff) and applied the one
you
> > > attached here (inotify_unmount_inodes-list-iteration-fix2.diff).
> > > 
> > > The good news is that the hang is gone. The bad news is that you cured
the
> > > hang by introducing an oops :(
> > 
> > )-:  I have addressed the only things I can think off that could cause
> > the oops and below is the resulting patch.  Could you please test it?
> 
> I forgot to say that this patch is a replacement for the previous
> (inotify_unmount_inodes-list-iteration-fix{,2}.diff}.

Note I seem to remember you are using 2.6.12?  If so I am not sure when
the I_WILL_FREE stuff came into existence, so should inotify.c not
compile after applying this patch just delete the " | I_WILL_FREE " in
the two places it occurs introduced by the patch and all should be fine.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUE1LNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUE1LNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 07:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUE1LNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 07:13:08 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:13695 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S261530AbUE1LND convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:13:03 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: ftp.kernel.org
Date: Fri, 28 May 2004 12:10:28 +0100
User-Agent: KMail/1.6.1
References: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net> <200405280941.38784.m.watts@eris.qinetiq.com> <20040528085523.GP1912@lug-owl.de>
In-Reply-To: <20040528085523.GP1912@lug-owl.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405281210.32382.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> On Fri, 2004-05-28 09:41:38 +0100, Mark Watts <m.watts@eris.qinetiq.com>
>
> wrote in message <200405280941.38784.m.watts@eris.qinetiq.com>:
> > > On Thu, 27 May 2004, Martin J. Bligh wrote:
> > > That would explain it.  The default is to turn it off.
> > >
> > > >Why would you mirror via ftp, instead of rsync anyway?
> > >
> > > I have more control with mirror.  And I've been using mirror for
> > > *ahem* a decade.  I've been using rsync for mirroring debian, but
> > > it's slow and often fails to complete.  Mirror has never let me
> > > down ('tho it has deleted entire archives before *grin*)
> >
> > Agreed - fmirror is so much more reliable than rsync (imho) that it makes
> > rsync into a worst-case option for retrieving files.
>
> Disagree! Mirroring with ftp is possibly quite a waste of bandwidth (at
> least in case partial file transfers etc.), and IIRC you can't reliably
> mirror symlinks (IIRC the "ls"/"dir" output is only ment to be
> human-readable), hardlinks and the like.
>
> If you see aborts, properly set the timeout parameter...

Not aborts, more like this every so often:


rsync: connection unexpectedly closed (598189175 bytes read so far)
rsync error: error in rsync protocol data stream (code 12) at io.c(189)
rsync: writefd_unbuffered failed to write 4092 bytes: phase "unknown": Broken
pipe
rsync error: error in rsync protocol data stream (code 12) at io.c(666)


Mirroring from sunsite.uio.no onto a Dual Xeon with a 1.6TB SCSI RAID 
(hardware) array, connected via GigE to a Cisco 4507r GigE switch., using the 
following rsync command:

rsync -av --stats --progress --bwlimit=2000 \ 
rsync://sunsite.uio.no/Mandrakelinux .

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAtx4nBn4EFUVUIO0RAvxXAKDn3KdNcaRbchkR/weaYuvGlEmEdwCfS0KG
e5Wf/skFHm2sXjzYhDzr2f4=
=aG9D
-----END PGP SIGNATURE-----

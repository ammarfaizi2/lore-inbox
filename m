Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSHXPH0>; Sat, 24 Aug 2002 11:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSHXPH0>; Sat, 24 Aug 2002 11:07:26 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:50897 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316491AbSHXPHY>; Sat, 24 Aug 2002 11:07:24 -0400
Message-Id: <5.1.0.14.2.20020824160921.00aeb550@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 24 Aug 2002 16:11:59 +0100
To: Pawel Kot <pkot@echelon.pl>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [BK-2.4 PATCH] Fix compile with highmem and highio
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0208241603390.7446-100000@urtica.linuxnews.p
 l>
References: <E17i1gF-00034U-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:08 24/08/02, Pawel Kot wrote:
>On Fri, 23 Aug 2002, Anton Altaparmakov wrote:
>
> >   Remove duplicate & bogus kmap_prot and kmap_pte exports.
> >   These are arch specific and only four architectures implement them. So
> >   on all other orchitectures with highmem enabled compilation would 
> fail with
> >   these exports in ksyms.c...
>
>No, only these 4 architectures allow to set HIGHMEM. So no failure here.
>
> >   The architectures which need them already export them via their 
> arch-ksyms files.
>
>No. They don't. At least in 2.4.20-pre4. I think they may be exported in
>your tree, because of the ntfs backport patch.

Oops. You are right. I need to reclone a clean 2.4 tree. Mine has somehow 
managed to gain a few "extra" changesets. Ahem.

Sorry for the noise.

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


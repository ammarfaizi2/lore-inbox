Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279392AbRJWMAP>; Tue, 23 Oct 2001 08:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279394AbRJWMAF>; Tue, 23 Oct 2001 08:00:05 -0400
Received: from mail301.mail.bellsouth.net ([205.152.58.161]:13182 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279392AbRJWL7q>; Tue, 23 Oct 2001 07:59:46 -0400
Message-ID: <3BD55BE5.2507784F@mandrakesoft.com>
Date: Tue, 23 Oct 2001 08:00:37 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 module build failure (2.4.13pre6)
In-Reply-To: <XFMail.20011023134632.ast@domdv.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:
> 
> # nm ./lib/modules/2.4.13-pre6/kernel/fs/ext2/ext2.o | \
> > grep generic_direct_IO
>          U generic_direct_IO
> #
> 
> Now what's that? some ghost?

I guess so :)

> [jgarzik@cum linux-2.4.13-pre6]$ bzcat /g/download/kernel/patch-2.4.13-pre6.bz2  | grep generic_direct_IO
> [jgarzik@cum linux-2.4.13-pre6]$ bzcat /g/download/kernel/linux-2.4.12.tar.bz2 |grep generic_direct_IO
> [jgarzik@cum linux-2.4.13-pre6]$ grep -r generic_direct_IO .
> [jgarzik@cum linux-2.4.13-pre6]$ cd ~/cvs/linux_2_4/
> [jgarzik@cum linux_2_4]$ nm vmlinux | grep generic_direct_IO
> [jgarzik@cum linux_2_4]$ 

> 
> On 23-Oct-2001 Jeff Garzik wrote:
> > Andreas Steinmetz wrote:
> >>
> >> ext2 build as a module fails to missing export of generic_direct_IO which
> >> the
> >> attached patch fixes.
> >>
> >> <grumble>
> >> posted this at 2.4.13pre2 time, now we're up to pre6 and nobody cares...
> >> </grumble>
> >
> > Interesting considering this function does not exist at all in
> > 2.4.13-pre6...
> >
> >       Jeff
> >
> >
> > --
> > Jeff Garzik      | Only so many songs can be sung
> > Building 1024    | with two lips, two lungs, and one tongue.
> > MandrakeSoft     |         - nomeansno
> >
> >
> 
> Andreas Steinmetz
> D.O.M. Datenverarbeitung GmbH

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno


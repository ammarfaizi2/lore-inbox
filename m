Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRLNXKc>; Fri, 14 Dec 2001 18:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280365AbRLNXKM>; Fri, 14 Dec 2001 18:10:12 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:4903 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S278701AbRLNXKA> convert rfc822-to-8bit; Fri, 14 Dec 2001 18:10:00 -0500
Date: Fri, 14 Dec 2001 21:16:06 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Peter Bornemann <eduard.epi@t-online.de>
cc: Jens Axboe <axboe@suse.de>, Kirk Alexander <kirkalx@yahoo.co.nz>,
        <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <Pine.LNX.4.33.0112142248290.4722-100000@eduard.t-online.de>
Message-ID: <20011214210728.K2427-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Dec 2001, Peter Bornemann wrote:

> On Fri, 14 Dec 2001, [ISO-8859-1] Gérard Roudier wrote:
> > By the way, for now, I haven't received any report about sym-2 failing
> > when sym-1 or ncr succeeds, and my feeling is that this could well be very
> > unlikely.
> >
>
> Ahemm -- well,
> maybe I'm the first one. I have a symbios card, which is recognized by
> lspci:  SCSI storage controller: LSI Logic Corp. / Symbios Logic Inc.
> (formerly NCR) 53c810 (rev 23).
>
> This card goes into an endless loop during parity-checking. So tried to
> disable it for the new sym53cxx in modules.conf:
> options sym53c8xx mpar:n spar:n
> This did not help in this case, however.
>
> There have been so far three ways to solve  this problem:
> 1. Use the very old ncr53c7,8 or so driver. This is working rather
> unreliable for me.
> 2. Use the ncr53c8xx, which works usually well
> 3. Use sym53c8xx(old) compiled with parity disabled
>
> Probably there is a way around that, but somebody trying to install Linux
> from a SCSI-CDROM with this card for the first time will very likely not
> succeed. I have seen this with (for instance) Corel-Linux and FreeBSD
> (same driver).
> NB Parity checking for me is not really all that important as there is no
> hardrive connected to that card. Only CD and scanner.

About what parity sort are you talking about ?
PCI parity ? SCSI parity ?

PCI parity checking is not an option. If it is this one, then your
hardware is simply broken. For such broken hardwares that returns such
spurious PCI parity error early during HBA probing, sym-2 can detect this
and disable PCI parity checking. This has been reported to work well under
FreeBSD. And sym-2 is also supposed to accept the manual disabling, either
by compiled-in option or using the mpar=n boot-up options.

For SCSI parity, which is different matter, both drivers try to cope and
still sym-2 should accept the spar=n boot-up option.

Could you, please,  report me more accurate information.
TIA,
  Gérard.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289739AbSBKOUf>; Mon, 11 Feb 2002 09:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289752AbSBKOU1>; Mon, 11 Feb 2002 09:20:27 -0500
Received: from Expansa.sns.it ([192.167.206.189]:58126 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S289739AbSBKOUT>;
	Mon, 11 Feb 2002 09:20:19 -0500
Date: Mon, 11 Feb 2002 15:20:04 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Alex Riesen <fork0@users.sourceforge.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
In-Reply-To: <20020211131713.A8614@steel>
Message-ID: <Pine.LNX.4.44.0202111518510.2643-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Feb 2002, Alex Riesen wrote:

> On Mon, Feb 11, 2002 at 12:52:27PM +0100, Luigi Genoni wrote:
> > I got the same with 2.5.4-pre1 on a  ATA66 disk,
> > chipset i810, PentiumIII with 256 MBRAM,
> > and then on Athlon 1300 Mhz, scsi disk, adaptec
> > 2940UW, 512MB RAM.
> >
> > I saw then just after a reboot.
> > Those file has been opened three or four days before the reboot expect of
> > .history.
> > I got no messages, and, that is the most interesting thing, this
> > corruption was just for text file. I also edited some binary file with
> > kexedit and them have not been corrupted after the reboot.
> was the edited file all the time on reiserfs? I mean, maybe kexedit
> uses temporary file on some other fs?
NO, the backup file is in the same directory with the edited file.
But the binary file are very big, while the text file are small,
and maybe so small that they are stored in the leaf node and not in
a stat data
>
>
> >
> > reiserfsck does not show any corruption, and the HW is good.
> > I know it is just a "me too", but i can do every test you need on the
> > PentiumIII
> Oleg, i may have to give you another set of apologies :) The fs problems
> the reiserfsck have found could well be from the old kernels (although
> the box crashes very rarely, just because the longest uptime is about 3
> hours).
>
>
> >
> > Luigi Genoni
> >
> > On Mon, 11 Feb 2002, Oleg Drokin wrote:
> >
> > > Hello!
> > >
> > > On Fri, Feb 08, 2002 at 11:07:13PM +0100, Alex Riesen wrote:
> > >
> > > > hmm.. You're demanding too much(mkreiserfs) - it's my home partition :)
> > > At least reiserfsck before any tests is almost mandratory ;)
> > >
> > > > Maybe the corruptions are from previous kernels, but the zero-files
> > > > are observed for the first time, particularly in the .bash_history.
> > > Yes, but you said with the patch you cannot reproduce zero files anymore.
> > >
> > > > Sorry for such a dirty test environment, i was really not prepared.
> > > > Logs attached.
> > > I am sorry, but there are so many variables, these logs are barely useful as
> > > of now.
> > > If you can reproduce on a clean filesystem with not faulty hardware, that
> > > would be interesting, though.
> ...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


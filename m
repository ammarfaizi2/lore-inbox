Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310637AbSDXJaN>; Wed, 24 Apr 2002 05:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310666AbSDXJaM>; Wed, 24 Apr 2002 05:30:12 -0400
Received: from Expansa.sns.it ([192.167.206.189]:36111 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S310637AbSDXJaL>;
	Wed, 24 Apr 2002 05:30:11 -0400
Date: Wed, 24 Apr 2002 11:29:52 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
In-Reply-To: <3CC66794.5040203@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0204241127410.24630-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a similar oops loading ide-cd module, without ide-scsi or similar.
EIP is the same, but since loading the module freezes the system, I do not
have a complite oops.
The system il a PentiumIII 512 MB ram,with i810 chipset.
Unfortunatelly all the other test systems I have right now are scsi based
even for the cd reader, so I cannot test on other chipset.



On Wed, 24 Apr 2002, Martin Dalecki wrote:

> U¿ytkownik Miles Lane napisa³:
> > On Tue, 2002-04-23 at 10:39, Miles Lane wrote:
> >
> >>On Tue, 2002-04-23 at 01:00, Martin Dalecki wrote:
> >>
> >>>Miles Lane wrote:
> >>>
> >>>>I should probably add the /proc/ksyms snapshotting stuff to
> >>>>get the module information for you as well.  I hope this
> >>>>current batch of info helps, for starters.
> >>>>
> >>>>ksymoops 2.4.4 on i686 2.4.7-10.  Options used
> >>>>     -v /usr/src/linux/vmlinux (specified)
> >>>>     -K (specified)
> >>>>     -L (specified)
> >>>>     -o /lib/modules/2.5.9/ (specified)
> >>>>     -m /boot/System.map-2.5.9 (specified)
> >>>
> >>>
> >>>Looks like the oops came from module code.
> >>>Which modules did you use: ide-flappy and ide-scsi are still
> >>>in need of the same medication ide-cd got.
> >>
> >>CONFIG_BLK_DEV_IDESCSI=m
> >>CONFIG_SCSI=m
> >>CONFIG_BLK_DEV_SD=m
> >>CONFIG_BLK_DEV_SR=m
> >>CONFIG_CHR_DEV_SG=m
> >
> >
> > Hmm.  You probably need this, too.  Sorry for not sending this
> > in the first reply.
>
>
> OK I assume that the oops happens inside the ide-scsi module.
> This will be fixed in one of the forthcomming patch sets.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


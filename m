Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317853AbSGPO2W>; Tue, 16 Jul 2002 10:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317855AbSGPO2V>; Tue, 16 Jul 2002 10:28:21 -0400
Received: from 12-236-56-248.client.attbi.com ([12.236.56.248]:41380 "EHLO
	turtle.carumba.com") by vger.kernel.org with ESMTP
	id <S317853AbSGPO2P> convert rfc822-to-8bit; Tue, 16 Jul 2002 10:28:15 -0400
Date: Tue, 16 Jul 2002 07:28:44 -0700 (PDT)
From: Jauder Ho <jauderho@carumba.com>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: vojtech@suse.cz, <James.Bottomley@steeleye.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207161249.g6GCnQZ9021743@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.4.44.0207160719260.16633-100000@turtle.carumba.com>
X-Mailer: UW Pine 4.33 + a bunch of schtuff
X-BOFH-Msg: Use vi not Emacs.
X-There-Is-No-Hidden-Message-In-This-Email: There are no tyops either
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And path_to_inst does not always do the RightThing(tm). [1] [2] Two
systems identically configured has the potential of having path_to_inst
look different. Especially if you have previously installed a device or
moved stuff around. And if the expectation is that a group of devices will
come up in a certain sequence (think shared tape devices for instance) and
it changes, it quickly becomes a nightmare. Not a fun proposition by any
means.

--Jauder

[1] eg http://www.myri.com/scs/documentation/mug/installation/solaris.html
[2] http://www.magma.com/support/sun.htm

On Tue, 16 Jul 2002, Joerg Schilling wrote:

> >From vojtech@ucw.cz Tue Jul 16 13:59:27 2002
>
> >> It would help, if somebody would correct the current SCSI addressng scheme used
> >> in Linux. Linux currently uses something called BUS/channel/target/lun.
> >> This does not reflect reality.
> >>
> >> What Linux calls a SCSI bus is definitely not a SCSI bus but a SCSI HBA card.
> >> What Linux calls a channel really is one of possibly more SCSI busses going
> >> off one of the SCSI HBA cards. It makes sense to just count SCSI busses.
>
> >Well, no. It doesn't. Because the numbers will change if you add a card
> >(even at runtime - hotplugging USB SCSI is something real happening
> >today. And that'd be a very bad thing.
>
> It hey change, then this is a Linux kernel problem. On Solaris they don't
> change because Solaris manages /etc/path_to_inst
>
> Jörg
>
>  EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
>        js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
>        schilling@fokus.gmd.de		(work) chars I am J"org Schilling
>  URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264932AbTIDMRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTIDMRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:17:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:52608 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264932AbTIDMRQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:17:16 -0400
Date: Thu, 4 Sep 2003 08:18:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nmi errors?
In-Reply-To: <20030903213417.GT7353@rdlg.net>
Message-ID: <Pine.LNX.4.53.0309040809570.2955@chaos>
References: <20030903212038.GQ7353@rdlg.net> <Pine.LNX.4.53.0309031724470.362@chaos>
 <20030903213417.GT7353@rdlg.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Robert L. Harris wrote:

>
>
> We ran "memtest" on the machine over the weekend and it completed 3
> times without any problems.  Know a better or different test?
>
>

Write 0x80 out port 0x70, and hope nobody accesses the RTC. This
will (should) disable the NMI line. Then see if the error messages
go away. If they do, it's a real NMI and you really do have bad
RAM somewhere. If they don't, your motherboard is getting glitched
either by bad design or something plugged into a slot that doesn't
have the correct timing specs.

If everything works, in spite of the NMI, just comment out the
kernel printk() and cross your fingers.

> Thus spake Richard B. Johnson (root@chaos.analogic.com):
>
> > On Wed, 3 Sep 2003, Robert L. Harris wrote:
> >
> > >
> > >
> > > Can anyone tell me what this is?
> > >
> > > 16:00:09 mailserver kernel: Uhhuh. NMI received for unknown reason 31.
> > > 16:00:09 mailserver kernel: Dazed and confused, but trying to continue
> > > 16:00:09 mailserver kernel: Do you have a strange power saving mode enabled?
> > > 16:00:34 mailserver kernel: Uhhuh. NMI received for unknown reason 21.
> > > 16:00:34 mailserver kernel: Dazed and confused, but trying to continue
> > >
> > > A coworker put a script on a server which loads up quite afew arrays
> > > with pre-set values and then compares the values against arrays.  As soon as he
> > > kicked off the script I got alot of these in my log files.  Not much longer and the
> > > machine crashed hard.
> > >
> >
> > Possible bad RAM.
> >
> > Cheers,
> > Dick Johnson
> > Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
> >             Note 96.31% of all statistics are fiction.
> >
>
> :wq!
> ---------------------------------------------------------------------------
> Robert L. Harris                     | GPG Key ID: E344DA3B
>                                          @ x-hkp://pgp.mit.edu
> DISCLAIMER:
>       These are MY OPINIONS ALONE.  I speak for no-one else.
>
> Life is not a destination, it's a journey.
>   Microsoft produces 15 car pileups on the highway.
>     Don't stop traffic to stand and gawk at the tragedy.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.



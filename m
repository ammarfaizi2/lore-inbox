Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265862AbUAQBEj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 20:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265866AbUAQBEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 20:04:37 -0500
Received: from cmsrelay01.mx.net ([165.212.11.110]:725 "HELO cmsrelay01.mx.net")
	by vger.kernel.org with SMTP id S265862AbUAQBEf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 20:04:35 -0500
X-USANET-Auth: 165.212.8.7     AUTO bradtilley@usa.net uwdvg007.cms.usa.net
Date: Fri, 16 Jan 2004 20:04:28 -0500
From: Brad Tilley <bradtilley@usa.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Brad Tilley <bradtilley@usa.net>
Subject: Re: [Re: Possible Bug in 2.4.24???]
CC: <linux-kernel@vger.kernel.org>, Oleg Drokin <green@linuxhacker.ru>
X-Mailer: USANET web-mailer (CM.0402.7.03)
Mime-Version: 1.0
Message-ID: <514iaqBeC5488S07.1074301468@uwdvg007.cms.usa.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> 
> 
> On Fri, 16 Jan 2004, Brad Tilley wrote:
> 
> > While running a script that recursively changes permissions on a ftp
> > directory, I received an error to the term window where the script was
> > running. I then checked out /var/log/messages and saw the below kernel
errors.
> > The machine was generally unresponsive and had to be physically rebooted
at
> > the power switch. It worked fine upon reboot an fsck ran w/o producing
any
> > error... the script ran fine too. This is a HP XW4100 with a P4, 1.5GB DDR
RAM
> > and two very fast (15,000 RPM), very large (140GB) SCSI HDDs. It had been
up
> > for 9 days (since compiling and installing 2.4.24) and has worked fine
until
> > this point. Could someone tell me if this is or isn't a kernel bug?
> >
> >
> > Jan 16 11:50:43 athop1 kernel: SCSI disk error : host 0 channel 0 id 1 lun
0
> > return code = 8000002
> > Jan 16 11:50:43 athop1 kernel: Info fld=0x2cd1bd9, Current sd08:15: sense
key
> > Hardware Error
> > Jan 16 11:50:43 athop1 kernel: Additional sense indicates Internal target
> > failure
> > Jan 16 11:50:43 athop1 kernel:  I/O error: dev 08:15, sector 54128
> > Jan 16 11:50:43 athop1 kernel: journal-601, buffer write failed
> > Jan 16 11:50:43 athop1 kernel:  (device sd(8,21))
> > Jan 16 11:50:43 athop1 kernel: kernel BUG at prints.c:341!
> > Jan 16 11:50:43 athop1 kernel: invalid operand: 0000
> > Jan 16 11:50:43 athop1 kernel: CPU:    0
> > Jan 16 11:50:43 athop1 kernel: EIP:    0010:[<c0189878>]    Tainted: P
> 
> Brad,
> 
> A device error happened (you see the "SCSI disk error : " message and
> "Additional sense indicates Internal target failure") which reiserfs
> could not handle.
> 
> kernel BUG at prints.c:341 == reiserfs_panic().

Thanks for the reply Marcelo,

Does this mean that there is a physical or mechanical problem with the drive
itself? I do use 
reiserfs as it's the best fs available for my purposes. Could the drive
attempt to write 
outside its physical bounds? Move the arm right when it was instructed to go
left? I don't 
understand how the drive could have an error w/o affecting the filesystem.




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290794AbSARTmP>; Fri, 18 Jan 2002 14:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290792AbSARTl6>; Fri, 18 Jan 2002 14:41:58 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:49675 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S290791AbSARTlp>; Fri, 18 Jan 2002 14:41:45 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 18 Jan 2002 11:48:08 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andre Hedrick <andre@linuxdiskcert.org>
cc: Jens Axboe <axboe@suse.de>, Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <Pine.LNX.4.10.10201181127270.4260-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.40.0201181146100.934-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Andre Hedrick wrote:

> On Fri, 18 Jan 2002, Davide Libenzi wrote:
>
> > On Fri, 18 Jan 2002, Jens Axboe wrote:
> >
> > > On Fri, Jan 18 2002, Davide Libenzi wrote:
> > > > On Fri, 18 Jan 2002, Anton Altaparmakov wrote:
> > > >
> > > > > Since the new IDE core from Andre is now solid as reported by various
> > > > > people on IRC, here is my local patch (stable for me) which you can apply
> > > > > to play with the shiny new IDE core (IDE core fix is same as
> > > > > ata-253p1-2.bz2 from Jens). (-:
> > > >
> > > > I would like to say the same. I worked with the fixed kernel
> > > > 2.5.3-pre1+ata-253p1-2 yesterday w/out problems. I rebootedt the machine
> > > > before leaving the office yesterday night and this morning it had a full
> > > > screen :
> > > >
> > > > hda: lost interrupt
> > > > hda: lost interrupt
> > > > hda: lost interrupt
> > > > hda: lost interrupt
> > > > hda: lost interrupt
> > >
> > > What mode? PIO and no multi mode, or?
> >
> >
> > This is what reports me 2.5.2 :
> >
> >
> > [root@blue1 davide]# cat /proc/ide/hda/settings
> > name                    value           min             max             mode
> > ----                    -----           ---             ---             ----
> > bios_cyl                2495            0               65535           rw
> > bios_head               255             0               255             rw
> > bios_sect               63              0               63              rw
> > breada_readahead        4               0               127             rw
> > bswap                   0               0               1               r
> > current_speed           0               0               69              rw
> > failures                0               0               65535           rw
> > file_readahead          124             0               16384           rw
> > ide_scsi                0               0               1               rw
> > init_speed              0               0               69              rw
> > io_32bit                0               0               3               rw
> > keepsettings            0               0               1               rw
> > lun                     0               0               7               rw
> > max_failures            1               0               65535           rw
> > multcount               8               0               8               rw
>
> There is a / 2 factor here, thus reality is 16,0,16

Guys, instead of requiring an -m8 to every user that is observing this
problem, isn't it better that you limit it inside the driver until things
gets fixed ?




- Davide



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbUCELmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 06:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUCELmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 06:42:25 -0500
Received: from goliath.sylaba.poznan.pl ([213.17.226.43]:18438 "EHLO
	goliath.sylaba.poznan.pl") by vger.kernel.org with ESMTP
	id S262522AbUCELmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 06:42:22 -0500
Subject: Re: 2.6.3 BUG - can't write DVD-RAM - reported as write-protected
From: Olaf =?iso-8859-2?Q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040305082350.GO31750@suse.de>
References: <1078434953.1961.13.camel@venus.local.navi.pl>
	 <20040305082350.GO31750@suse.de>
Content-Type: text/plain
Message-Id: <1078487159.3300.23.camel@venus.local.navi.pl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 05 Mar 2004 12:45:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-05 at 09:23, Jens Axboe wrote:
> On Thu, Mar 04 2004, Olaf Fr?czyk wrote:
> > Hi,
> > I switched to 2.6.3 from 2.4.x serie.
> > When I mount DVD-RAM it is mounted read-only:
> > 
> > [root@venus olaf]# mount /dev/dvdram /mnt/dvdram
> > mount: block device /dev/dvdram is write-protected, mounting read-only
> > [root@venus olaf]#
> > 
> > In 2.4 it is mounted correctly as read-write.
> > 
> > Drive: Panasonic LF-201, reported in Linux as:
> > MATSHITA        DVD-RAM LF-D200         A120
> > 
> > SCSI controller: Adaptec 2940U2W
> 
> What does cat /proc/sys/dev/cdrom/info say? Do you get any kernel
> messages in dmesg when the rw mount fails?

I get nothing in /var/log/dmesg and in /var/log/messages
In /proc/sys/dev/cdrom/info I get:
[olaf@venus olaf]$ cat /proc/sys/dev/cdrom/info
CD-ROM information, Id: cdrom.c 3.20 2003/12/17
 
drive name:             sr1     sr0     hdc
drive speed:            0       16      44
drive # of slots:       1       1       1
Can close tray:         1       1       1
Can open tray:          1       1       1
Can lock tray:          1       1       1
Can change speed:       1       1       1
Can select disk:        0       0       0
Can read multisession:  1       1       1
Can read MCN:           1       1       1
Reports media changed:  1       1       1
Can play audio:         1       1       1
Can write CD-R:         0       1       1
Can write CD-RW:        0       1       1
Can read DVD:           1       0       0
Can write DVD-R:        0       0       0
Can write DVD-RAM:      1       0       0
Can read MRW:           0       0       1
Can write MRW:          0       0       1

The one I'm mounting is /dev/scd1.
As there is capablity to write-protect DVD-RAM disk (like a 1.44"
Floppy), I think that the linux kernel interprets some message from
device in wrong way.

Regards,

Olaf



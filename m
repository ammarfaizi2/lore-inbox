Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282236AbRLHQlg>; Sat, 8 Dec 2001 11:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282222AbRLHQlb>; Sat, 8 Dec 2001 11:41:31 -0500
Received: from smtp-rt-14.wanadoo.fr ([193.252.19.224]:12679 "EHLO
	adansonia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S282271AbRLHQlL>; Sat, 8 Dec 2001 11:41:11 -0500
Message-ID: <3C12421C.47337242@wanadoo.fr>
Date: Sat, 08 Dec 2001 17:38:52 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre7+devfs-v203 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre7 ide-cd module
In-Reply-To: <3C1235C4.BC20AC8E@wanadoo.fr> <20011208161847.GK11567@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Sat, Dec 08 2001, Pierre Rousselet wrote:
> > Attached is dmesg with 2.5.1-pre7 + devfs-patch-v203.
> >
> > The first and second manual loading of the ide-cd module give something
> > different.
> >
> > #modprobe ide-cd ; rmmod ide-cd ; modprobe ide-cd
> >
> > hdc: ATAPI CD-ROM drive, 0kB Cache, DMA
> > Uniform CD-ROM driver Revision: 3.12
> > hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
> 
> Upon first load, could you cat /proc/sys/dev/cdrom/info? It would appear
> that the drive is sending zeroed data but not reporting a failure.

First load :
CD-ROM information, Id: cdrom.c 3.12 2000/10/18

drive name:             hdc
drive speed:            0
drive # of slots:       1
Can close tray:         0
Can open tray:          1
Can lock tray:          1
Can change speed:       1
Can select disk:        0
Can read multisession:  1
Can read MCN:           1
Reports media changed:  1
Can play audio:         0
Can write CD-R:         0
Can write CD-RW:        0
Can read DVD:           0
Can write DVD-R:        0
Can write DVD-RAM:      0

Second load :
CD-ROM information, Id: cdrom.c 3.12 2000/10/18

drive name:             hdc
drive speed:            1
drive # of slots:       1
Can close tray:         1
Can open tray:          1
Can lock tray:          1
Can change speed:       1
Can select disk:        0
Can read multisession:  1
Can read MCN:           1
Reports media changed:  1
Can play audio:         1
Can write CD-R:         0
Can write CD-RW:        0
Can read DVD:           0
Can write DVD-R:        0
Can write DVD-RAM:      0

> Is this a new problem?

The same is in 2.5.1-pre5 (i reported the 'Can play audio : 0' to l-k).

Pierre
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

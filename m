Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283004AbRLHRfR>; Sat, 8 Dec 2001 12:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283009AbRLHRfH>; Sat, 8 Dec 2001 12:35:07 -0500
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:16851 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S283004AbRLHRfD>; Sat, 8 Dec 2001 12:35:03 -0500
Message-ID: <3C124EC1.7DA2A1B4@wanadoo.fr>
Date: Sat, 08 Dec 2001 18:32:49 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre7+devfs-v203 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre7 ide-cd module
In-Reply-To: <3C1235C4.BC20AC8E@wanadoo.fr> <20011208161847.GK11567@suse.de> <3C12421C.47337242@wanadoo.fr> <20011208164552.GR11567@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Sat, Dec 08 2001, Pierre Rousselet wrote:
> > > Is this a new problem?
> >
> > The same is in 2.5.1-pre5 (i reported the 'Can play audio : 0' to l-k).
> 
> How about 2.4.16? Try attached patch.

With your patch applied on ide-cd.c (i double-checked it is applied):
#modprobe ide-cd ; cat /proc/sys/dev/cdrom/info
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
#rmmod ide-cd ; modprobe ide-cd ; cat /proc/sys/dev/cdrom/info
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



-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

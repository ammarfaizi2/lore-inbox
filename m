Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275809AbRJBFTt>; Tue, 2 Oct 2001 01:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275816AbRJBFTk>; Tue, 2 Oct 2001 01:19:40 -0400
Received: from unthought.net ([212.97.129.24]:63899 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S275809AbRJBFTV>;
	Tue, 2 Oct 2001 01:19:21 -0400
Date: Tue, 2 Oct 2001 07:19:49 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: "Oleg A. Yurlov" <kris@spylog.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID sync
Message-ID: <20011002071949.B5302@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	"Oleg A. Yurlov" <kris@spylog.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1101445461994.20011001182753@spylog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <1101445461994.20011001182753@spylog.com>; from kris@spylog.com on Mon, Oct 01, 2001 at 06:27:53PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2001 at 06:27:53PM +0400, Oleg A. Yurlov wrote:
> 
>         Privet :-)
> 
>         Kernel 2.4.6.SuSE-4GB-SMP, 2 CPU, 2Gb RAM, 4 HDD SCSI, M/B Intel L440GX.
> Messages from dmesg:
> 
...
> md: sdc2 [events: 0000001e](write) sdc2's sb offset: 15815872
> md: considering sdb2 ...
> md:  adding sdb2 ...
> md:  adding sda2 ...
> md: created md0
> md: bind<sda2,1>
> md: bind<sdb2,2>
> md: running: <sdb2><sda2>
> md: now!
> md: sdb2's event counter: 0000001c
> md: sda2's event counter: 0000001d
> md: superblock update time inconsistency -- using the most recent one
> md: freshest: sda2
> md0: max total readahead window set to 508k
> md0: 1 data-disks, max readahead per data-disk: 508k
> raid1: device sdb2 operational as mirror 1
> raid1: device sda2 operational as mirror 0
> raid1: raid set md0 active with 2 out of 2 mirrors
> md: updating md0 RAID superblock on device
> md: sdb2 [events: 0000001e](write) sdb2's sb offset: 15815872
> md: sda2 [events: 0000001e](write) sda2's sb offset: 15815872
> md: ... autorun DONE.
> 
>         Why RAID do not start synchronization ? It is normal ?

Doesn't it ?

Try "cat /proc/mdstat"

Synchronization is a background operation - your array is functional
immediately.

(this behaviour was changed from the really really old RAID code in unpatched
 2.2 to standard 2.4)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269543AbRHTVrI>; Mon, 20 Aug 2001 17:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269542AbRHTVqb>; Mon, 20 Aug 2001 17:46:31 -0400
Received: from pm1-modem32.inet-direct.com ([204.71.22.32]:11140 "HELO NewStar")
	by vger.kernel.org with SMTP id <S269506AbRHTVpe>;
	Mon, 20 Aug 2001 17:45:34 -0400
Date: Mon, 20 Aug 2001 17:07:17 -0500
From: mhobgood@inet-direct.com
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.8-ac5 and earlier] fatal mount-problem
Message-ID: <20010820170717.A6893@inet-direct.com>
In-Reply-To: <E15YnGB-0005sr-00@the-village.bc.nu> <Pine.GSO.4.21.0108200732190.1313-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.GSO.4.21.0108200732190.1313-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Aug 20, 2001 at 07:42:24AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a plain vanilla 2.4.7 using ide-scsi driver it works okay on
the double mount, and returns device busy.  It will however
segfault if you try to mount scd0 with no media in the drive.

Cordially,
Mike Hobgood


On Mon, Aug 20, 2001 at 07:42:24AM -0400, Alexander Viro wrote:
> 
> 
> On Mon, 20 Aug 2001, Alan Cox wrote:
> 
> > > > (as modules) and you do the same mount again on the same (not unmounted)
> > > > device, the mount-programm hangs up and never comes back. It doesn't
> > > > recognize, that the device is allready mounted.
> > > 
> > > strace, please. -ac5 and 2.4.9 have the same code in fs/super.c, so
> 
> Aha. They actually don't (sorry - I was thinking of 2.4.7-ac5), but...
> > > I really wonder what the hell is happening...
> > 
> > Duplicated here with 2.4.8-ac6
> > Booted with ide-scsi as the cd driver
> 
> I can't reproduce it with /dev/hda and /dev/hdd (ide-disk and ide-cd resp.)
> here. I'll build kernel with ide-scsi and see what's going on with that.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262111AbREPWWr>; Wed, 16 May 2001 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262113AbREPWWa>; Wed, 16 May 2001 18:22:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18956 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262111AbREPWWS>;
	Wed, 16 May 2001 18:22:18 -0400
Date: Thu, 17 May 2001 00:21:18 +0200
From: Jens Axboe <axboe@suse.de>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010517002118.B20976@suse.de>
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.05.10105160921220.23225-100000@callisto.of.borg> <200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca> <3B02D6AB.E381D317@transmeta.com> <200105162001.f4GK18X10128@vindaloo.ras.ucalgary.ca> <3B02DD79.7B840A5B@transmeta.com> <200105162054.f4GKsaF10834@vindaloo.ras.ucalgary.ca> <3B02F2EC.F189923@transmeta.com> <20010517001155.H806@nightmaster.csn.tu-chemnitz.de> <3B02FBA6.86969BDE@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B02FBA6.86969BDE@transmeta.com>; from hpa@transmeta.com on Wed, May 16, 2001 at 03:13:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16 2001, H. Peter Anvin wrote:
> Ingo Oeser wrote:
> > 
> > We do this already with ide-scsi. A device is visible as /dev/hda
> > and /dev/sda at the same time. Or think IDE-CDRW: /dev/hda,
> > /dev/sr0 and /dev/sg0.
> > 
> > All at the same time.
> > 
> 
> ... and if you don't know about this funny aliasing, you get screwed. 
> This is BAD DESIGN, once again.

And he's wrong too, we don't do this all the time. If /dev/hda is ide-cd
controlled, then it can't be accessed through /dev/sr0 -- and vice
versa. sg vs sr is different, one is a char the other a block device.

-- 
Jens Axboe


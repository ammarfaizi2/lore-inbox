Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVAXQsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVAXQsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 11:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVAXQso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 11:48:44 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:6636 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261529AbVAXQsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 11:48:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mbO056sn3sKabc7DFcmIGPGMoFyJW7yjzW4jhTrONrEpkp5nPRCsMpyF6U0kDlhCNcFEjVIkMmhr/sUNksOJvhBjFKuqTWYnymXkK9P4ZNYfk2kSlGaXqNqFPU0+vKsYYu6/lK/t9LeqWD7DHIdYZbxQRFyfBl3VBEtMG0IugIw=
Message-ID: <5a4c581d05012408481adbd5f4@mail.gmail.com>
Date: Mon, 24 Jan 2005 17:48:40 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: DVD burning still have problems
Cc: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050124150755.GH2707@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de>
	 <5a4c581d050123125967a65cd7@mail.gmail.com>
	 <20050124150755.GH2707@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 16:07:55 +0100, Jens Axboe <axboe@suse.de> wrote:
> On Sun, Jan 23 2005, Alessandro Suardi wrote:
> > On Sun, 23 Jan 2005 21:26:55 +0100, Volker Armin Hemmann
> > <volker.armin.hemmann@tu-clausthal.de> wrote:
> > > Hi,
> > >
> > > have you checked, that cdrecord is not suid root, and growisofs/dvd+rw-tools
> > > is?
> > >
> > > I had some probs, solved with a simple chmod +s growisofs :)
> >
> > Lucky you. Burning as root here, cdrecord not suid. Tried also
> >  burning with a +s growisofs, but...
> >
> >  794034176/4572807168 (17.4%) @2.4x, remaining 18:47
> >  805339136/4572807168 (17.6%) @2.4x, remaining 18:42
> > :-[ WRITE@LBA=60eb0h failed with SK=3h/ASC=0Ch/ACQ=00h]: Input/output error
> > builtin_dd: 396976*2KB out @ average 2.4x1385KBps
> > :-( write failed: Input/output error
> 
> As with the original report, the drive is sending back a write error to
> the issuer. Looks like bad media.

I'm definitely unconvinced about the possibility of bad media...

Retrying the burn process works, sometimes on first attempt,
 sometimes after tray reload, and all checksums from original
 files to the burned files are just okay. This happens with different
 discs from different brands.

So far I had *one* bad disc - that would keep the light on my
 DVD burner blinking forever until I hit the eject button, and
 made my laptop (2.6.11-rc2-bk1) DVD player barf:

Jan 24 03:02:13 incident kernel: ATAPI device hdc:
Jan 24 03:02:13 incident kernel:   Error: Not ready -- (Sense key=0x02)
Jan 24 03:02:13 incident kernel:   No reference position found (media
may be upside down) -- (asc=0x06, ascq=0x00)
Jan 24 03:02:13 incident kernel:   The failed "Read Cd/Dvd Capacity"
packet command was:
Jan 24 03:02:13 incident kernel:   "25 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 "



Earlier FC3 kernels had another problem (that now isn't surfacing
 anymore) that I described on the cdwrite list:

http://lists.debian.org/cdwrite/2004/12/msg00088.html

--alessandro
 
 "And every dream, every, is just a dream after all"
  
    (Heather Nova, "Paper Cup")

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131165AbRCGTV0>; Wed, 7 Mar 2001 14:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131168AbRCGTVS>; Wed, 7 Mar 2001 14:21:18 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:10769 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131165AbRCGTVN>;
	Wed, 7 Mar 2001 14:21:13 -0500
Date: Wed, 7 Mar 2001 20:20:16 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paul Bristow <paul@paulbristow.net>
Cc: Konrad Stopsack <konrad@stopsack.de>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE bug in 2.4.2-ac12?
Message-ID: <20010307202016.B5030@suse.cz>
In-Reply-To: <01030620134000.00343@Stopsack> <01030621324600.01403@zoltar.paulbristow.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01030621324600.01403@zoltar.paulbristow.lan>; from paul@paulbristow.net on Tue, Mar 06, 2001 at 09:32:46PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 09:32:46PM +0000, Paul Bristow wrote:
> On Tuesday 06 March 2001 19:13, Konrad Stopsack wrote:
> > Hello guys,
> >
> > I hope you've read my posting "DMA problem with ZIP drive and VIA
> > VT82C598MVP / VT82C586B chip" (why does anybody answer?).
> > I now tried the 2.4.2-ac12 kernel including the latest VIA 82c586b driver
> > (version 3.21), but the effects were almost the same:
> > - just when the kernel tried to access to the hard disk during boot, DMA
> > errors were occured
> > - "hdparm /dev/hda" displayed 9 MB per second (and not 11 MB like without
> > ZIP) - /proc/ide/via reported 16 MB transfer rate (and not 33MB like
> > without ZIP drive)
> > - Kernel 2.4.2-ac12 reports a "ide-floppy: hdd: I/O error, pc = 5a, key = 
> > 5, asc = 24, ascq =  0" error, 2.4.2 doesn't
> >
> > My IDE configuration is:
> > /dev/hda: Hard disk  => Primary IDE controller
> > /dev/hdc CD-ROM  => Secondary IDE controller
> > /dev/hdd: ZIP           => Secondary IDE controller
> >
> > Could you please tell me whether it's a bug or a feature?
> 
> OK.  The ZIP drive can not handle uDMA, so it's normal for the secondary 
> controller to drop back.  In my opinion, the primary controller should stay 
> at uDMA speed, but it is PC hardware so it is perfectly possible there is 
> something cheap that locks them together.  I will bring up ac-12 and check 
> the error message...

Actually I'm beginning to suspect the PSU here ... does removing the
CD-ROM (leaving just the HDD and the ZIP in) help? Does the ZIP cause
errors even when connected just to the power cable (and not the IDE
cable)?

-- 
Vojtech Pavlik
SuSE Labs

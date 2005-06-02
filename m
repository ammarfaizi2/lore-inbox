Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVFBN5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVFBN5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 09:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVFBN5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 09:57:47 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:58589 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261415AbVFBN5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 09:57:38 -0400
Date: Thu, 2 Jun 2005 09:57:37 -0400
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: External USB2 HDD affects speed hda
Message-ID: <20050602135737.GO23621@csclub.uwaterloo.ca>
References: <429BA001.2030405@keyaccess.nl> <20050601081810.GA23114@elf.ucw.cz> <429DFD90.10802@keyaccess.nl> <200506011240.09540.david-b@pacbell.net> <429E3338.9000401@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429E3338.9000401@keyaccess.nl>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 12:14:16AM +0200, Rene Herman wrote:
> Sound scary. Must say I do generally have a lot of faith in this chipset 
> (AMD751/756). The machine's been as stable as a rock for years now. A 
> logic analyser I do not have, nor the ability to interpret it if I did.
> 
> I did just now try two different PCI slots. Again no change.
> 
> Erhhm. rmmoding ehci-hcd works. I suppose it tells the hardware to shut 
> up on module_exit. is there any way to have it tell the hardware the 
> same while keeping it loaded? Any other ideas?

I just tried pluging in my usb2 flash reader which ought to d the same
thing to usb-storage as pluging in the external usb2 hd.

Reading from a 120G SATA WD drive gets about 41MB/s without the USB2
drive connected and about the same with.  That is on an nforce2
motherboard with it's builtin usb controller and using 2.6.10.

Trying on an Athlon64 with a 250G SATA WD drive and the same usb flash
reader, I get 57MB/s both with and without the usb2 drive connected.
That one uses a VIA K8T800 chipset and also 2.6.10.

I wonder what is different with your hardware/software mix.

I tried unloading everything to do with usb to try and see if I could
make it get a higher speed with hdparm, but no change no matter what.

Len Sorensen

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbTFVHut (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 03:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbTFVHut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 03:50:49 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:40341 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263802AbTFVHus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 03:50:48 -0400
Date: Sun, 22 Jun 2003 12:03:01 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: severe FS corruption w/ reiserfs and 2.5.72-bk3
Message-ID: <20030622080301.GA17062@linuxhacker.ru>
References: <3EF4C0CC.6090100@folkwang-hochschule.de> <200306212021.h5LKLGdv004822@car.linuxhacker.ru> <3EF4DDF1.2010101@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF4DDF1.2010101@folkwang-hochschule.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Jun 22, 2003 at 12:36:33AM +0200, Joern Nettingsmeier wrote:

> >JN> i just completely and utterly trashed my filesystems with 2.5.72-bk2 
> >and JN> reiserfs. there are metric shitloads of errors on journal replay 
> >and i JN> end up in repair mode. did a couple of --rebuild-tree's, but new 
> >errors JN> cropped up after every reboot.
> >JN> happens both on scsi and ide drives and ate almost all of my machine...
> >Hm. Can I ask for your kernel config, and kernel logs (if possible),
> >reiserfsck /dev/device -l /somewhere/device.log , and send those logs to
> >me too.
> sorry, i can't really get anything in and out of that box.
> i've been able to extract some parts of the fsck log, they look like this:
> vpf-10680: The file [2406 26400] has the wrong block count in the 
> (8), should be (1)

These are not looking dangerous, probably some symlinks created long ago.
(we changed block accounting for symlinks some time ago).

> it tells me it can fix it with the --fixable option, done that a couple 
> of times, new errors after that.

You mean new errors of the same kind?

> it's an smp box with 2 p3s, intel bx chipset, aic7xxx scsi, ide and scsi 
> compiled into the kernel, reiserfs too. tagged queuing enabled, ignore 

Well, TQ was broken on IDE some time ago, but then Jens Axboe said he
fixed that, anyway that does not explain why all the disks got eaten.

> >JN> if anyone wants me to do some forensics on the machine, speak up. 
> >JN> otherwise i'll swipe it clean and start over from scratch.
> >I wonder if you can create clean fs, copy some stuff there with 2.5.72-mm2
> >and see what happens?
> /var is totally FUBAR, the system won't boot into my fallback kernel. i 
> don't have a second machine around to compile another kernel on... sorry.

Sigh.

> i might be able to put the ide disk into another box tomorrow and try 
> another reiserfsck with proper logging, but i have no place to check the 
> scsi disks. i'll keep you posted when i get it done.

Ok, perhaps you can put some kind of rescue system on that IDE disk,
and try to boot it in original box?

Bye,
    Oleg

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWAYPep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWAYPep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 10:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWAYPep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 10:34:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9822 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751232AbWAYPeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 10:34:44 -0500
Date: Wed, 25 Jan 2006 16:30:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Albert Cahalan <acahalan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, schilling@fokus.fraunhofer.de,
       matthias.andree@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060125153057.GG4212@suse.de>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25 2006, Jan Engelhardt wrote:
> 
> >
> >- you don't need -scanbus. If
> >users think they do, it's either because Joerg brain washed them or
> >because they have been used to that bad interface since years ago when
> >it was unfortunately needed.
> 
> Now you're unfair.
> -scanbus does a nice output of what cdwriters (and other capable devices) 
> are present. For me, that lists the cd writer and a CF slot from the 
> multitype usb flash reader.
> 
> There's one kind of not-so-advanced linux newbies that just go to walmart, 
> buy a computer and whack a linux system on it for fun, and they still don't 
> know if their cdrom is at /dev/hdb or /dev/hdc. Looking for dmesg is 
> usually a nightmare for them, and apart that -scanbus lists scsi 
> host,id,lun instead of /dev/hd* (don't comment on this kthx), it is 
> convenient for this sort of users to find out what's available.
> 
> So, and what about that compactflash reader? It is subject to dynamic 
> usb->scsi device association (depending on when you connect it, it may 
> either become sda, or sdb, or sdc, etc.), and -scanbus yet again provides 
> some way (albeit not useful, because it lists scsi,id,lun rather than 
> /dev/sd* - don't comment either) to see where it actually is.

You just want the device naming to reflect that. The user should not
need to use /dev/hda, but /dev/cdrecorder or whatever. A real user would
likely be using k3b or something graphical though, and just click on his
Hitachi/Plextor/whatever burner. Perhaps some fancy udev rules could
help do this dynamically even.

If you are using cdrecord on the command line, you are by definition an
advanced user and know how to find out where that writer is.

-- 
Jens Axboe


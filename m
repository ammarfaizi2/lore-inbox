Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266165AbUAGJ5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUAGJ5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:57:14 -0500
Received: from ns.suse.de ([195.135.220.2]:7634 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266165AbUAGJ4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:56:34 -0500
Date: Wed, 7 Jan 2004 10:56:32 +0100
From: Olaf Hering <olh@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Andries Brouwer <aebr@win.tue.nl>,
       Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040107095632.GA22213@suse.de>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103133749.A3393@pclin040.win.tue.nl> <20040103124216.GA31006@suse.de> <200401031905.31806.arvidjaar@mail.ru> <20040103175414.GX5523@suse.de> <20040107094321.GC21059@suse.de> <20040107095029.GX3483@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040107095029.GX3483@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 07, Jens Axboe wrote:

> No need to put it in the kernel, user space fits the bil nicely. I don't
> see how this would lead to IO errors?

Ok, how should it be done on my SCSI and parallel port ZIP? An ATAPI ZIP
with 2.4 behaves like that:


nectarine:~ # blockdev --rereadpt /dev/hdd
/dev/hdd: Eingabe-/Ausgabefehler
nectarine:~ # dmesg | tail
nfs: server Hilbert2 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
ide-floppy: hdd: I/O error, pc =  0, key =  2, asc = 3a, ascq =  0
ide-floppy: hdd: I/O error, pc = 1b, key =  2, asc = 3a, ascq =  0
hdd: No disk in drive
nectarine:~ # cat /proc/ide/hdd/model 
IOMEGA ZIP 100 ATAPI


I have not checked 2.6, but I doubt it is smarter.


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

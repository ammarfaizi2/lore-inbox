Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbUACRy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 12:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUACRy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 12:54:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26337 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263605AbUACRy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 12:54:27 -0500
Date: Sat, 3 Jan 2004 18:54:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Olaf Hering <olh@suse.de>, Andries Brouwer <aebr@win.tue.nl>,
       Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040103175414.GX5523@suse.de>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103133749.A3393@pclin040.win.tue.nl> <20040103124216.GA31006@suse.de> <200401031905.31806.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401031905.31806.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03 2004, Andrey Borzenkov wrote:
> > Is there really no way to get a media change notification from ZIP or
> > JAZ drives?
> 
> If anyone knows please tell me - I will put it into supermount ...
> 
> AFAIK in case of SCSI this is impossible simply by virtue of protocol - SCSI 
> device is not initiator. So you need something to poll device for status. 
> That is usually done on device open except in this case you can't open 
> because you do not yet have handle.

You could queue a media notification request for long periods of time,
being completed by the drive when a media change happens. At least mmc
allows for this, doubt anyone has ever done it.

So yeah, poll...

-- 
Jens Axboe


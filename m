Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263545AbUACQIh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 11:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUACQIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 11:08:36 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:20748 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263545AbUACQIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 11:08:35 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Olaf Hering <olh@suse.de>, Andries Brouwer <aebr@win.tue.nl>
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Date: Sat, 3 Jan 2004 19:05:31 +0300
User-Agent: KMail/1.5.3
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200401012333.04930.arvidjaar@mail.ru> <20040103133749.A3393@pclin040.win.tue.nl> <20040103124216.GA31006@suse.de>
In-Reply-To: <20040103124216.GA31006@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401031905.31806.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 January 2004 15:42, Olaf Hering wrote:
>  On Sat, Jan 03, Andries Brouwer wrote:
> > On Sat, Jan 03, 2004 at 11:51:33AM +0300, Andrey Borzenkov wrote:
> > > yes. So what - how does it help? User needs /dev/sda4. User has
> > > /dev/sda only. Any attempt to refer to /dev/sda4 simply returns "No
> > > such file or directory"
> >
> > Things are far from perfect here, but "blockdev --rereadpt /dev/sda"
> > helps.
>

sure. But that requires manual user intervention. And it has been working 
without any manual user intervention before. That is why I called it 
regression.

I just try to draw attention to simple (but very nasty for users) problem in 
udev. This quotation removed too much from my original post to reduce the 
problem to simple "how to reread partition table".

> Is there really no way to get a media change notification from ZIP or
> JAZ drives?

If anyone knows please tell me - I will put it into supermount ...

AFAIK in case of SCSI this is impossible simply by virtue of protocol - SCSI 
device is not initiator. So you need something to poll device for status. 
That is usually done on device open except in this case you can't open 
because you do not yet have handle.

thank you

-andrey


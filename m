Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbTHaSiO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 14:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTHaSiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 14:38:13 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:30982 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S261999AbTHaSiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 14:38:11 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Ali Akcaagac <aliakc@web.de>
Subject: Re: 2.4/2.6 - ATAPI Zip problem in SCSI mode (DEVFS)
Date: Sun, 31 Aug 2003 22:37:32 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200308312117.42848.arvidjaar@mail.ru> <1062352558.24793.4.camel@localhost>
In-Reply-To: <1062352558.24793.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308312237.32891.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 August 2003 21:55, Ali Akcaagac wrote:
> On Sun, 2003-08-31 at 19:17, Andrey Borzenkov wrote:
> > > For 2.5 this doesn't work anymore and whenever you want to mount a Zip
> > > disk you need to boot Linux together with a Disk inside the Drive, so
> > > during boot it detects the Zip drive + the Disk.
> >
> > yes devfs was castrated in 2.6 and removable media revalidation has been
> > removed without providing any suitable replacement.
>
> Ahh, thanks for letting me know this.
>
> But this leads to the question why CD-ROM removable media revalidation
> works. I mean let's see an SCSI CD-ROM, an ATAPI CD-ROM (in SCSI mode)
> and ATAPI Zip (in SCSI mode) as *the same*.
>

CD-ROM is not partitioned device, Zip is. You always have handle for the whole 
disk (/dev/scsi/.../disc) - if not please let me know it is a bug. But 
partitions are registered only when something is forcing media revalidation 
i.e. attempts to access device. Just listing the devfs directory does not 
count as access now.

> They all have a host device (the mechanics itself), they all talk
> through the same interface (straight SCSI or SCSI emulation). But CD-ROM
> removable media revalidation works. E.g. I plug a CD in and it does the
> trick, the Zip should be alike in my opinion. How does a Zip as
> removable media differ from a CD for example.
>
> By the way it would be pretty nice to improve devfs in this case. I also
> heard a while back that it will be re-written anyways. Would be cool to
> have a native support for that (Kernel related solution).
>

well ... it was not me who removed this code ...

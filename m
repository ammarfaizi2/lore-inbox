Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVECHLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVECHLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 03:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVECHLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 03:11:20 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:37911 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261408AbVECHLL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 03:11:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LKX2mvEEjIdEHTR5aqcAFUm5YzjBg1Q35vT3ZEUXDLcIl0vJ4T4HcxpaPmJqwAWrIOs3u6ZogZ8vTBb+uYNb88yph9RrrDF83DcTPiWm6Y4O4vRO2W/3FKypbqT2NUIKem+EUIq0JvPdOHCqptMKZM/BDBx/BsrAVvcFcWjE9ak=
Message-ID: <58cb370e05050300117f125506@mail.gmail.com>
Date: Tue, 3 May 2005 09:11:08 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.12-rc3-mm2 - /proc/ide/sr0/model: No such file or directory
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       juhl-lkml@dif.dk, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <20050503044805.GA14750@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050430164303.6538f47c.akpm@osdl.org>
	 <Pine.LNX.4.62.0505010429050.2491@dragon.hyggekrogen.localhost>
	 <20050503031158.GA6917@kroah.com>
	 <20050502201823.0ab02e96.akpm@osdl.org>
	 <20050503044805.GA14750@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/05, Greg KH <greg@kroah.com> wrote:
> On Mon, May 02, 2005 at 08:18:23PM -0700, Andrew Morton wrote:
> > Greg KH <greg@kroah.com> wrote:
> > >
> > > On Sun, May 01, 2005 at 04:32:45AM +0200, Jesper Juhl wrote:
> > > > On Sat, 30 Apr 2005, Andrew Morton wrote:
> > > >
> > > > >
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm2/
> > > > >
> > > >
> > > > I see one small change in behaviour with this kernel.
> > > >
> > > > During boot when initializing udev I see
> > > >
> > > > Initializing udev dynamic device directory.
> > > > grep: /proc/ide/sr0/model: No such file or directory
> > > > grep: /proc/ide/sr1/model: No such file or directory
> > > >
> > > > With previous kernels I only see
> > > >
> > > > Initializing udev dynamic device directory.
> > >
> > > That is because you have a udev script that is expecting to see ide
> > > stuff in proc.  That has now been moved to sysfs, so you should not need
> > > to run external scripts to detect ide devices now.  I suggest you go bug
> > > your distro, or whoever set up those rules about it.
> >
> > err, we don't want to break existing userspace setups, please.
> 
> I agree.  Bart, want to put the /proc stuff back, mark it depreciated in
> the Documentation/feature-removal-schedule.txt as going away in 6 months
> or so, and then remove it after that time has gone by?

/proc/ide stuff was _not_ removed, please see original mail:
 
On 5/1/05, Jesper Juhl <juhl-lkml@dif.dk> wrote:

> This machine has no IDE device at all, only SCSI, and the kernel config
> has no IDE support either. The config I'm using has not changed in any

Thanks,
Bartlomiej

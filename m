Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTHaR4a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 13:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbTHaR4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 13:56:30 -0400
Received: from smtp03.web.de ([217.72.192.158]:60436 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261413AbTHaR4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 13:56:20 -0400
Subject: Re: 2.4/2.6 - ATAPI Zip problem in SCSI mode (DEVFS)
From: Ali Akcaagac <aliakc@web.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200308312117.42848.arvidjaar@mail.ru>
References: <200308312117.42848.arvidjaar@mail.ru>
Content-Type: text/plain
Message-Id: <1062352558.24793.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 31 Aug 2003 19:55:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-31 at 19:17, Andrey Borzenkov wrote:
> > For 2.5 this doesn't work anymore and whenever you want to mount a Zip
> > disk you need to boot Linux together with a Disk inside the Drive, so
> > during boot it detects the Zip drive + the Disk.
> 
> yes devfs was castrated in 2.6 and removable media revalidation has been 
> removed without providing any suitable replacement.

Ahh, thanks for letting me know this.

But this leads to the question why CD-ROM removable media revalidation
works. I mean let's see an SCSI CD-ROM, an ATAPI CD-ROM (in SCSI mode)
and ATAPI Zip (in SCSI mode) as *the same*.

They all have a host device (the mechanics itself), they all talk
through the same interface (straight SCSI or SCSI emulation). But CD-ROM
removable media revalidation works. E.g. I plug a CD in and it does the
trick, the Zip should be alike in my opinion. How does a Zip as
removable media differ from a CD for example.

By the way it would be pretty nice to improve devfs in this case. I also
heard a while back that it will be re-written anyways. Would be cool to
have a native support for that (Kernel related solution).

greetings,

A. A.


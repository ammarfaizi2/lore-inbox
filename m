Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTLIHBc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 02:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTLIHBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 02:01:32 -0500
Received: from quechua.inka.de ([193.197.184.2]:65192 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263258AbTLIHBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 02:01:31 -0500
Subject: Re: State of devfs in 2.6?
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031208233428.GA31370@kroah.com>
References: <200312081536.26022.andrew@walrond.org>
	 <20031208154256.GV19856@holomorphy.com>
	 <pan.2003.12.08.23.04.07.111640@dungeon.inka.de>
	 <20031208233428.GA31370@kroah.com>
Content-Type: text/plain
Organization: small linux home
Message-Id: <1070953338.7668.6.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 08:02:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-09 at 00:34, Greg KH wrote:
> You have 15 floppy devices connected to your box?  All floppy devices
> should show up in /sys/block.

No, 16 devices are normal, sysfs has only one:
aj@simulacron:~/torrent/j-tv/download$ ls /dev/floppy/
0       0u1120  0u1600  0u1722  0u1760  0u1920  0u720  0u820
0u1040  0u1440  0u1680  0u1743  0u1840  0u360   0u800  0u830
aj@simulacron:~/torrent/j-tv/download$ find /sys/block/fd* -name dev
/sys/block/fd0/dev

Are those floppy devices obsolete? fdformat was the only app to use
them anyway, I guess. (Not that I use my floppy, I simply noticed
the change.)

> > I wouldn't call udev deprecated, unless a newer kernel has the
> > essential devices, too.
> 
> You mean s/udev/devfs/ right?  :)

oops, sorry.

> > and
> > re-introducing makedev for devices not represented
> > in sysfs doesn't sound very nice either. So 2.8.* might be a nice time
> > frame for dropping devfs, or at least give sysfs and udev a few months
> > to catch up on the issues mentioned.
> 
> Regardless of the state of udev, devfs has insolvable problems and you
> should not use it.  End of story.

how many bug reports did you see in the last three months of people
having problems with devfs? I don't doubt the problems in theory, but
but I simply haven't seen them happening. Most users seem quite happy.

Andreas


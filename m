Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbSKCGAz>; Sun, 3 Nov 2002 01:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSKCGAy>; Sun, 3 Nov 2002 01:00:54 -0500
Received: from [207.88.206.43] ([207.88.206.43]:37251 "EHLO
	intruder-luxul.gurulabs.com") by vger.kernel.org with ESMTP
	id <S261683AbSKCGAx>; Sun, 3 Nov 2002 01:00:53 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Dax Kelson <dax@gurulabs.com>
To: andersen@codepoet.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021103054243.GA19481@codepoet.org>
References: <Pine.GSO.4.21.0211022114280.25010-100000@steklov.math.psu.edu>
	<Pine.LNX.4.44.0211022101090.20616-100000@mooru.gurulabs.com>
	<20021103053109.GA19281@codepoet.org> <1036301868.31698.160.camel@thud> 
	<20021103054243.GA19481@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Nov 2002 23:07:24 -0700
Message-Id: <1036303645.31699.180.camel@thud>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 22:42, Erik Andersen wrote:
> On Sat Nov 02, 2002 at 10:37:48PM -0700, Dax Kelson wrote:
> > On Sat, 2002-11-02 at 22:31, Erik Andersen wrote:
> > > On Sat Nov 02, 2002 at 09:04:07PM -0700, Dax Kelson wrote:
> > > >
> > > > 
> > > > Any thoughts on how /usr/bin/(rpm|dpkg) copes with setting up the binding
> > > > when installing a package?
> > > 
> > > postint script
> > 
> > Sure, but editing /etc/fstab from postint is messy, potentially
> > dangerous, and could possibly collide with someone doing a manual edit
> > of /etc/fstab.
> > 
> > Maybe we need a /etc/fstab.d/ directory and teach /bin/mount about it.
> 
> Or have an /etc/fstab.d/ directory plus have an update-fstab
> script that collates the entries in that directory and stuffs the
> result into /etc/fstab, and have update-fstab called from the postint
> script.

I would forget about the update-fstab script. Why merge?

There is lots of precedent for the .d/ directories in /etc. These
directories are mostly for the benefit of packages, and they have no
update-foo scripts.


/etc/crontab &  /etc/cron.(hourly|daily|weekly|monthly)/ & /etc/cron.d/
/etc/logrotate.conf & /etc/logrotate.d/
/etc/profile & /etc/profile.d/
/etc/httpd/conf/httpd.conf & /etc/httpd/conf.d/
/etc/xinetd.conf & /etc/xinetd.d/
/etc/lvmtab & /etc/lvmtab.d/
/etc/makedev.d/
/etc/pam.d/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264316AbTICUb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTICUb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:31:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:41148 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264316AbTICUaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:30:00 -0400
Date: Wed, 3 Sep 2003 13:30:00 -0700
From: Greg KH <greg@kroah.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Blake B." <shadoi@nanovoid.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test 4 and USB
Message-ID: <20030903202959.GA1618@kroah.com>
References: <bj4to7$i3p$1@sea.gmane.org> <Pine.LNX.3.96.1030903154731.9300A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030903154731.9300A-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 03:54:11PM -0400, Bill Davidsen wrote:
> On Wed, 3 Sep 2003, Blake B. wrote:
> 
> > watermodem wrote:
> > > I forgot to note on the USB and CUPs problem that I see the USB tree 
> > > under "/sys/bus/usb" where-as under /proc/bus/usb I see nothing.
> > > This may break a lot of existing code... Is is suppose to be this way?
> > > 
> > > 
> > > 
> > 
> > Read /linux-kernel-source/Documentation/usb/proc_usb_info.txt
> 
> I must be missing something, the mount command from that file doesn't
> seem to solve the original poster's problem, the /proc/bus/usb is still
> empty...
> 
> ================================================================
> 
> >From root@oddball.prodigy.com Wed Sep  3 15:47:22 2003
> Subject: USB proc stuff
> From: root <root@oddball.prodigy.com>
> Date: Wed, 3 Sep 2003 13:19:15 -0400
> To: davidsen@tmr.com
> 
> oddball:root> mount -t usbfs none /proc/bus/usb
> oddball:root> df
> Filesystem           1k-blocks      Used Available Use% Mounted on
> /dev/hda3              2522076   2338380     55580  98% /
> /dev/hda1                23302     20030      2069  91% /boot
> /dev/hda5              1510032    265388   1167936  19% /home
> /dev/hdb3              1474320    897712    501716  65% /usr/src
> none                     46776         0     46776   0% /dev/shm
> oddball:root> mount -t usbfs none /proc/bus/usb
> mount: none already mounted or /proc/bus/usb busy
> mount: according to mtab, none is already mounted on /proc/bus/usb

What does 'cat /proc/mounts' show?

> oddball:root> lc /proc/bus/usb
> oddball:root> l -aR /proc/bus/usb
> /proc/bus/usb:
> total 0
> drwxr-xr-x    2 root            0 Sep  3 13:17 .
> dr-xr-xr-x    6 root            0 Sep  3 13:17 ..

Do you have any USB host controller drivers loaded?  That is necessary
for anything to actually show up in here :)

thanks,

greg k-h

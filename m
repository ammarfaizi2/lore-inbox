Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUAHHqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 02:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbUAHHqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 02:46:00 -0500
Received: from ns.suse.de ([195.135.220.2]:48610 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263800AbUAHHp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 02:45:58 -0500
Date: Thu, 8 Jan 2004 08:45:56 +0100
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Message-ID: <20040108074556.GA23187@suse.de>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040107205237.GB16832@suse.de> <Pine.LNX.4.58.0401071801310.12602@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0401071801310.12602@home.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 07, Linus Torvalds wrote:

> This works. I do it all the time. You just stick in your card, and mount 
> it, and off it foes. No "fdisk" or "parted" _anywhere_.

This is the point. You do it, and I do it. We just know that device and
have it configured somehow.
Now what should a distro do for these 'unknown' devices? Add 15 fstab
entries and let KDE put 15 icons on the desktop (for that ZIP) and give
the user a choice?

Like you said in another mail:
If you insert a smartmedia card in your cardreader, you expect to be
able to access it pretty much immediately when you start typing.

Noone knows in advance what media will be inserted. So we have to poll
if the hardware doesnt inform us.
We can make an assumption and add just one icon with a smart application
behind it. This app does the 'blockdev --rereadpt /dev/hdd' on request,
and not every 2 seconds.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

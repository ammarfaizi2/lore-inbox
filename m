Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTKQPXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 10:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTKQPXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 10:23:17 -0500
Received: from f7.mail.ru ([194.67.57.37]:47110 "EHLO f7.mail.ru")
	by vger.kernel.org with ESMTP id S263460AbTKQPXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 10:23:15 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Chris Friesen=?koi8-r?Q?=22=20?= 
	<cfriesen@nortelnetworks.com>
Cc: =?koi8-r?Q?=22?=Jeff Garzik=?koi8-r?Q?=22=20?= 
	<jgarzik@pobox.com>,
       =?koi8-r?Q?=22?=linux-kernel=?koi8-r?Q?=22=20?= 
	<linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted=?koi8-r?Q?=3F?=
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Mon, 17 Nov 2003 18:36:54 +0300
In-Reply-To: <3FB8DDB9.8080709@nortelnetworks.com>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----

> 
> Jeff Garzik wrote:
> > Andrey Borzenkov wrote:
> > 
> >> Apparently not:
> >>
> >> {pts/1}% head -2 /proc/mounts
> >> rootfs / rootfs rw 0 0
> >> /dev/root / reiserfs rw 0 0
> >>
> >> at least it is still mounted. Is there any way to free it?
> 
> > rootfs is always present.  It's the root, as the name implies :)
> 
> He's got two root filesystems, one on top of the other.  It should be 
> possible to pivot root rather than mount the second one, thus freeing up 
> the memory from the initramfs.
> 

my example is after pivot_root. I still have two roots.

To clarify. I want to replace initrd with initramfs. Given all
the stuff may be put in it can easily be expanded to a couple of MBs.
initrd frees this. I do not want to waste RAM to leave them in initramfs.

thank you

-andrey

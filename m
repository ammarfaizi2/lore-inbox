Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264350AbTKMRDG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 12:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbTKMRDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 12:03:06 -0500
Received: from services3.virtu.nl ([217.114.97.6]:42394 "EHLO
	services3.virtu.nl") by vger.kernel.org with ESMTP id S264350AbTKMRDD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 12:03:03 -0500
Message-Id: <5.1.0.14.2.20031113175123.027970a8@services3.virtu.nl>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 13 Nov 2003 17:58:54 +0100
To: bert hubert <ahu@ds9a.nl>
From: Remco van Mook <remco@virtu.nl>
Subject: Re: buffer/page cache aliasing? Re: 2.4 odd behaviour of
  ramdisk + cramfs
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031113164544.GA24997@outpost.ds9a.nl>
References: <5.1.0.14.2.20031113171537.01ee82c8@services3.virtu.nl>
 <5.1.0.14.2.20031113171537.01ee82c8@services3.virtu.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Virtu-MailScanner-VirusCheck: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:45 13-11-2003 +0100, bert hubert wrote:
>On Thu, Nov 13, 2003 at 05:32:49PM +0100, Remco van Mook wrote:
>
> > #! /bin/sh
> > cat /flash/modules-2.4.21 > /dev/ram1
> > mount -t cramfs -o ro /dev/ram1 /lib/modules
> >
> > Running it once causes the mount to fail with 'cramfs: wrong magic' -
> > running it twice will make mount succeed on the second try.
>
>Sounds like buffer/page cache aliasing perhaps? Does it work with other
>filesystems?

I've just checked it with an ext2 filesystem - exactly the same thing happens.

Now, what's more interesting is that if I try again with a bigger filesystem
(3MB instead of 750KB) the problem only appears every now and again.

So it's probably got nothing to do with cramfs in particular, but more with the
size of the filesystem.

Remco


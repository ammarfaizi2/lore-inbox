Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287467AbSALUsW>; Sat, 12 Jan 2002 15:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287450AbSALUsN>; Sat, 12 Jan 2002 15:48:13 -0500
Received: from delta.Colorado.EDU ([128.138.139.9]:53767 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S287449AbSALUr7>;
	Sat, 12 Jan 2002 15:47:59 -0500
Message-Id: <200201122047.NAA50782@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Writeout in recent kernels/VMs poor compared to last -ac 
In-Reply-To: "Adam Kropelin"'s message of Sat, 12 Jan 2002 10:17:39 EST.
In-Reply-To: <009e01c19b7c$463457d0$02c8a8c0@kroptech.com> 
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 8063
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2002 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Sat, 12 Jan 2002 13:47:45 -0700
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
X-ECS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In your message of: Sat, 12 Jan 2002 10:17:39 EST, you write:
>I recently began regularly transferring large (600 MB+) files to my
>Linux-based fileserver and have noticed what I would characterize as poor
>writeout behavior under this load. I've done a bit of comparison testing
>which may help reveal the problem better.

I see the same behavior when writing to a USB attached harddisk/MP3
player, which also is formated VFAT.  Doing a cp *.mp3 /usbdrive/ will
read the mp3s into memory, until all free memory is filled, and then
start writing them to the usb drive.  Because it can only write at
800KB/s this behavior is very noticable.  Once the few hundred MB of
files in memory have been written out, the next batch of files will be
read into memory, and then written out.

This behavior occurs under 2.4.17, and has occured under all recent
2.4 kernels.  I haven't done any rigorous testing to see which, if
any, -ac or early 2.4 kernels do not show this behavior.

If VFAT is considered an issue, I can reformat the disk ext2 for
testing.

Not really any new information to add, just a "me too", though I would
be happy to try out any proposed fixes.

--
Jeff Lessem.

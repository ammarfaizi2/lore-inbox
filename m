Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270839AbTGPN4h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 09:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270835AbTGPN4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 09:56:37 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:20665 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S270839AbTGPN4e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 09:56:34 -0400
From: root@mauve.demon.co.uk
Message-Id: <200307161410.PAA04171@mauve.demon.co.uk>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
To: mark@alpha.dyndns.org (Mark McClelland)
Date: Wed, 16 Jul 2003 15:10:22 +0100 (BST)
Cc: greg@kroah.com (Greg KH), kraxel@bytesex.org (Gerd Knorr),
       linux-kernel@vger.kernel.org (Kernel List),
       video4linux-list@redhat.com (video4linux list)
In-Reply-To: <3F15540E.2040405@alpha.dyndns.org> from "Mark McClelland" at Jul 16, 2003 06:33:02 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Greg KH wrote:
> 
> >On Tue, Jul 15, 2003 at 04:31:19PM +0200, Gerd Knorr wrote:
> >  
> >
> >>Changes required/recommended in video4linux drivers:
> >>
> >>  * some usb webcam drivers (usbvideo.ko, stv680.ko, se401.ko 
> >>    and ov511.ko) use the video_proc_entry() to add additional
> >>    procfs files.  These drivers must be converted to sysfs too
> >>    because video_proc_entry() doesn't exist any more.
<snip>
> >Is there any need for these drivers to export anything through sysfs now
> >instead of /proc?
> >
> 
> Yes, at least with ov511. Some of the info that it puts in /proc is no 
> longer necessary. However, there are various bits of hardware info that 
> still need to get to userspace, for scripts that need to tell otherwise 
> identical (same VID/PID/revision) cameras apart when creating /dev nodes.

Also, there is some other information that scripts need.
Exposure gives information about light levels, which can be used to 
compute the absolute brightness of a scene captured.


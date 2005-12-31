Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVLaSOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVLaSOj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 13:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVLaSOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 13:14:39 -0500
Received: from bay103-f20.bay103.hotmail.com ([65.54.174.30]:51934 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932309AbVLaSOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 13:14:39 -0500
Message-ID: <BAY103-F20590E26A4BFFB40EC6D7BDF2B0@phx.gbl>
X-Originating-IP: [69.222.162.187]
X-Originating-Email: [dravet@hotmail.com]
In-Reply-To: <43B6C6F3.7080109@liberouter.org>
From: "Jason Dravet" <dravet@hotmail.com>
To: slaby@liberouter.org
Cc: linux-kernel@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: RFC: add udev support to parport_pc
Date: Sat, 31 Dec 2005 12:14:38 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 31 Dec 2005 18:14:38.0978 (UTC) FILETIME=[10383620:01C60E36]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Jiri Slaby <slaby@liberouter.org>
>To: Jason Dravet <dravet@hotmail.com>
>CC: linux-kernel@vger.kernel.org, linux-parport@lists.infradead.org
>Subject: Re: RFC: add udev support to parport_pc
>Date: Sat, 31 Dec 2005 18:59:15 +0100
>
>Jason Dravet napsal(a):
> > Here is a patch to parport_pc.c that adds udev support.  Without it
> > sysfs does not have enough information to give to udev so the lp and
> > parport nodes can be created.  The only problem I have is the
> > kernel_oops when I do the following: insmod parport, insmod parport_pc,
> > rmmod parport_pc, rmmod parport, insmod parport, insmod parport_pc,
> > rmmod parport_pc, kernel oops.
>[snip]
> > +    if (p->base == 888) /* 888 is dec for 378h */
> > +    {
> > +        class_device_create(parallel_class, NULL, MKDEV(6, 0), NULL,
> > "lp0");
> > +        class_device_create(parallel_class, NULL, MKDEV(99, 0), NULL,
> > "parport0");
> > +    }
>use please
>if () {
>}
>instead of
>if ()
>{
>}
>like the surrounding code
>
>thanks,
>--
>Jiri Slaby         www.fi.muni.cz/~xslaby

Will do.  Thanks,
Jason



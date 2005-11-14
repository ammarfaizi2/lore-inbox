Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVKNDqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVKNDqq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 22:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVKNDqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 22:46:46 -0500
Received: from bay103-f29.bay103.hotmail.com ([65.54.174.39]:16906 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750867AbVKNDqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 22:46:45 -0500
Message-ID: <BAY103-F2918D48FE561F67EE3790ADF5A0@phx.gbl>
X-Originating-IP: [68.252.187.134]
X-Originating-Email: [dravet@hotmail.com]
From: "Jason Dravet" <dravet@hotmail.com>
To: adaplas@gmail.com, samuel.thibault@ens-lyon.org
Cc: torvalds@osdl.org, akpm@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
Date: Sun, 13 Nov 2005 21:46:45 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 14 Nov 2005 03:46:46.0143 (UTC) FILETIME=[08F9E8F0:01C5E8CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: "Antonino A. Daplas" <adaplas@gmail.com>
>To: Samuel Thibault <samuel.thibault@ens-lyon.org>
>CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,  
>Dave Jones <davej@redhat.com>, Jason <dravet@hotmail.com>,  Linux Kernel 
>Development <linux-kernel@vger.kernel.org>
>Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
>Date: Mon, 14 Nov 2005 07:37:17 +0800
>
>Samuel Thibault wrote:
> > Antonino A. Daplas, le Sun 13 Nov 2005 22:33:18 +0800, a écrit :
> >> Samuel Thibault wrote:
> >>> Antonino A. Daplas, le Sun 13 Nov 2005 06:20:53 +0800, a écrit :
> >>>> "I updated to the development kernel and now during boot only the top 
>of the
> >>>> text is visable. For example the monitor screen the is the lines and 
>I can
> >>>> only  see text in the asterik area.
> >>>> ---------------------
> >>>> | ****************  |
> >>>> | *              *  |
> >>>> | *              *  |
> >>>> | ****************  |
> >>>> |                   |
> >>>> |                   |
> >>>> |                   |
> >>>> ---------------------
> >>> Are you missing some left and right part too? What are the dimensions 
>of
> >>> the text screen at bootup? What bootloader are you using? (It could be 
>a
> >>> bug in the boot up text screen dimension discovery).
> >> It was just the height.  All numbers (done with printk's) look okay 
>from
> >> bootup. He gets 80 and 25 for ORIG_VIDEO_NUM_COLS and 
>ORIG_VIDEO_NUM_LINES
> >> respectively.
> >
> > And you got less than 25 lines? How many exactly?
>
>If the original size was at 80x25, and vgacon_doresize() was called, the
>the resulting screen is only 80x12.5. The 13th line has its bottom half
>chopped off, and the rest of the lines (14-25) is invisible.
>
>If he sets it at < 25, he gets a window much smaller than 12.5, but he did
>not specify. So my guess is his chipset programs the screen height by 1/2
>of the value of the requested rows.
>
>Tony

When I run stty rows 20 I get a screen of 80x20.  I can see the top 10 rows 
and the bottom 10 rows are invisible.

Thanks,
Jason Dravet



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWJMQ36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWJMQ36 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWJMQ35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:29:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751341AbWJMQ34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:29:56 -0400
Date: Fri, 13 Oct 2006 09:29:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.19-rc1-mm1 - locks when using "dd bs=1M" from card reader
Message-Id: <20061013092941.30500a15.akpm@osdl.org>
In-Reply-To: <452F906F.8020302@aitel.hist.no>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<452E327C.9020707@aitel.hist.no>
	<20061012112938.97ef924c.akpm@osdl.org>
	<452F906F.8020302@aitel.hist.no>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006 15:11:11 +0200
Helge Hafting <helge.hafting@aitel.hist.no> wrote:

> Andrew Morton wrote:
> > On Thu, 12 Oct 2006 14:18:04 +0200
> > Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> >
> >   
> >> I found an easy way to hang the kernel when copying a SD-card:
> >>
> >> dd if=/dev/sdc of=file bs=1048576
> >>
> >> I.e. copy the entire 256MB card in 1MB chunks.  I got about
> >> 160MB before the kernel hung.  Not even sysrq+B worked, I needed
> >> the reset button.  The pc has a total of 512MB memory if that matters.
> >>
> >> Using bs=4096 instead let me copy the entire card with no problems,
> >> but that seems to progress slower.
> >>
> >> The above 'dd' command hangs my office pc every time. So I can repeat
> >> it for debugging purposes. 
> >>
> >>     
> >
> > What device driver is providing /dev/sdc?
> >   
> It is an usb card reader, so it is "usb mass storage"
> and "scsi disk".
> > Did any previous kernels work correctly?  If so, which?
> >   
> 
> I just got that card reader, so I haven't tested any earlier kernels.
> I have another machine with a card reader, which I have used for
> a long time. But I only ever copy files with "cp" on that one.
> 
> This time I used "dd" to get an image of the entire card, and got trouble
> when using 1M chunks. 
> 
> I can try with verbose scsi debug messages if that might help?
> 

Maybe.  The first step is to tell the developers. (adds cc).


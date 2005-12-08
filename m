Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbVLHDCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVLHDCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 22:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbVLHDCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 22:02:05 -0500
Received: from bay103-f5.bay103.hotmail.com ([65.54.174.15]:26699 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S965024AbVLHDCE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 22:02:04 -0500
Message-ID: <BAY103-F5E97636877B8723077572DF420@phx.gbl>
X-Originating-IP: [68.78.27.127]
X-Originating-Email: [dravet@hotmail.com]
From: "Jason Dravet" <dravet@hotmail.com>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Date: Wed, 07 Dec 2005 21:02:03 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 08 Dec 2005 03:02:03.0870 (UTC) FILETIME=[C42187E0:01C5FBA3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Russell King <rmk+lkml@arm.linux.org.uk>
>To: Jason Dravet <dravet@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: wrong number of serial port detected
>Date: Wed, 7 Dec 2005 21:15:51 +0000
>
>On Wed, Dec 07, 2005 at 01:59:43PM -0600, Jason Dravet wrote:
> > >From: Russell King <rmk+lkml@arm.linux.org.uk>
> > >To: Jason Dravet <dravet@hotmail.com>
> > >CC: linux-kernel@vger.kernel.org
> > >Subject: Re: wrong number of serial port detected
> > >Date: Wed, 7 Dec 2005 15:50:34 +0000
> > >
> > >On Wed, Dec 07, 2005 at 09:44:29AM -0600, Jason Dravet wrote:
> > >> So I ask this mailing list Can the kernel detect the proper number of
> > >> serial ports or not?
> > >
> > >It does detect serial ports found in the machine.
> > >
> > >However, it _always_ offers the configured number of serial devices.
> > >This is to allow folk whose ports are not autodetected to configure
> > >them appropriately via the setserial command.  If they were not
> > >available, they could not configure them.
> > >
> > Then may I ask how XP does it?  I have to dual boot between XP and 
>Fedora.
> > When I go into XP's device manager I see all of the appropriate hardware
> > listed, no extra serial ports.  When I boot into Fedora and go into 
>/dev, I
> > see the same hardware except I have 32 serial ports and 64 tty nodes 
>(tty
> > is for virtual terminals right?).  How can 1 OS show the correct number 
>and
> > another show the wrong number?  I ask so I can better understand what is
> > going on.
>
>It seems you are comparing apples (XP's device manager) with oranges
>(/dev directory).  They're two entirely different things.
>
>The former lists devices which _are_ present in your system.
>
>The latter provides the filesystem namespace for applications to access
>devices which may or may not be present in your system.
>
I thought the purpose of udev was to create device manager like 
functionality.  I posted my question here because udev is creating 32 nodes. 
  Udev gets that information from the kernel serial port driver.  Thanks to 
your explanation I now understand.  This is why I ask questions so I can 
learn.

>As for your 64 VT tty device nodes - these "devices" are created
>dynamically when the device node is opened.  The act of opening the
>device node is defined to be the creation event.  If the device node
>did not exist, there would be no way to create _any_ virtual terminals.
>
I thought there were only 7 tty devices (Ctrl-F1 to Ctrl-F7) for local 
system login?  Ctrl-F7 being for Xwindows.  Did I miss something?

Thank you for taking the time to answer my questions.  I really appreciate 
it.
Jason



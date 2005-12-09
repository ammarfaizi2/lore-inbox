Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVLIOhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVLIOhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 09:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVLIOhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 09:37:04 -0500
Received: from bay103-f33.bay103.hotmail.com ([65.54.174.43]:16619 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932091AbVLIOhB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 09:37:01 -0500
Message-ID: <BAY103-F33F72FF201DD9A0728D2EBDF450@phx.gbl>
X-Originating-IP: [69.217.141.85]
X-Originating-Email: [dravet@hotmail.com]
In-Reply-To: <20051208105425.GA28397@flint.arm.linux.org.uk>
From: "Jason Dravet" <dravet@hotmail.com>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: wrong number of serial port detected
Date: Fri, 09 Dec 2005 08:37:01 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 09 Dec 2005 14:37:01.0259 (UTC) FILETIME=[041FE9B0:01C5FCCE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Russell King <rmk+lkml@arm.linux.org.uk>
>To: Jason Dravet <dravet@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: wrong number of serial port detected
>Date: Thu, 8 Dec 2005 10:54:26 +0000
>
>On Wed, Dec 07, 2005 at 09:02:03PM -0600, Jason Dravet wrote:
> > >As for your 64 VT tty device nodes - these "devices" are created
> > >dynamically when the device node is opened.  The act of opening the
> > >device node is defined to be the creation event.  If the device node
> > >did not exist, there would be no way to create _any_ virtual terminals.
> >
> > I thought there were only 7 tty devices (Ctrl-F1 to Ctrl-F7) for local
> > system login?  Ctrl-F7 being for Xwindows.  Did I miss something?
>
>If you look in the "init" configuration file, /etc/inittab, you'll
>see lines similar to these:
>
The /etc/inittab file is where I got the number 7 from (6 tty plus 1 
Xwindows).  I have to change the inittab everytime I install FC since they 
switched to graphical boot (FC does not like my monitor).  Let me see if I 
got this right:  Is the reason 64 tty devices exist similiar to the reason 
you gave me about the 32 serial ports?  You create all the nodes so they can 
be used at anytime.  If there were only the 6 tty nodes created then if you 
want to direct your logger to tty12, you would first have to create that 
node and then tty12 could be used.  If this is true how are the other 52 tty 
devices accessed?  I don't have a F13 or F44 keys on my keyboard.

I like the idea of the patch that Dave Jones created.  The question I have 
is with all of this plug and play stuff in our PCs shouldn't it be possible 
to get the correct number of ports, ask the bios or the pci bus or 
something?

Thanks,
Jason



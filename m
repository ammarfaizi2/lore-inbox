Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTDFF13 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 00:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTDFF13 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 00:27:29 -0500
Received: from granite.he.net ([216.218.226.66]:53770 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262811AbTDFF12 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 00:27:28 -0500
Date: Sat, 5 Apr 2003 21:20:49 -0800
From: Greg KH <greg@kroah.com>
To: Antonio Hernandez <ahernandez@augenopticos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changing the device between usb printers
Message-ID: <20030406052049.GA2914@kroah.com>
References: <3E878F0A.8090709@augenopticos.com> <3E8DD413.80702@augenopticos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8DD413.80702@augenopticos.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 10:50:59AM -0800, Antonio Hernandez wrote:
> Changing the device between usb printers.
> 
> I have several usb printers, each have a device to work 
> /dev/usb/lp0.../dev/usb/lp1/...etc. an example for the problem. If I 
> turn off 2 printers, printer #1 (/dev/usb/lp0)and printer #2 
> (/dev/usb/lp1)  if i turn on first printer#2 and later printer #1 I got 
> for printer#2 to /dev/usb/lp0 and printer #1 (/dev/usb/lp1), if the 
> printers are the same is not a problem but if the printers aren't the 
> same then exist a problem  when I send to print. I put a dmesg in 
> console and I got messages from "hub.c" that it put the number of 
> bus3/3/1 for a printer and bus3/3/2 to another but "printer.c" put 
> always usblp0 for the first printer detected and usblp1 to another. I 
> think that "printer.c" must to follow the same idea that hub.c to use 
> like /dev/usb/bus/3/3/2/lp or something like that

Yes, this is a problem.  People are working on solutions to this issue
for 2.5, so it will hopefully be solved some day :)

greg k-h

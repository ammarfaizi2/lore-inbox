Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129109AbQKFPMO>; Mon, 6 Nov 2000 10:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129096AbQKFPME>; Mon, 6 Nov 2000 10:12:04 -0500
Received: from underdog.barkingdogstudios.com ([206.186.109.131]:4882 "EHLO
	underdog.barkingdogstudios.com") by vger.kernel.org with ESMTP
	id <S129109AbQKFPLs>; Mon, 6 Nov 2000 10:11:48 -0500
Date: Mon, 6 Nov 2000 10:11:11 -0500 (EST)
From: Michael Vines <mjvines@undergrad.math.uwaterloo.ca>
To: Catalin BOIE <util@deuroconsult.ro>
cc: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>, linux-kernel@vger.kernel.org
Subject: Re: Kernel hook for open
In-Reply-To: <20001106155702.F12348@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.10.10011061009490.9936-100000@barkingdogstudios.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Erik Mouw wrote:

> On Mon, Nov 06, 2000 at 03:55:41PM +0200, Catalin BOIE wrote:
> > I wish to know if there is something like a kernel hook for open function.
> > I want to monitor a file (someting like watchdog on Solaris) and to read
> > from my own process (module?) and from the file.
> 
> I don't know what watchdog is, but maybe strace is what you want (man
> strace for more info).
> 
> > I tried with LD_SO_PRELOAD but it haven't any effect on the so libraries.
> > For example:
> > If I use function getpwent (that is in a so library) and my home
> > made .so library that overwrite "open" function and is in
> > /etc/ld.so.preload file it doesn't work.
> > Of course, if I use open ("/etc/hosts") the so library execute my
> > function. 
> 
> Use LD_PRELOAD instead.

You could also write a simple kernel module that replaces the open system
call.  See the Linux Kernel Module Programming Guide for details. 
http://www.linuxdoc.org/guides.html

specifically http://www.linuxdoc.org/LDP/lkmpg/node20.html

        Michael
       

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

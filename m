Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276737AbRJKTSR>; Thu, 11 Oct 2001 15:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276734AbRJKTSH>; Thu, 11 Oct 2001 15:18:07 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:54981 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S276702AbRJKTRy>; Thu, 11 Oct 2001 15:17:54 -0400
Message-ID: <3BC5F0A0.56F644B7@nortelnetworks.com>
Date: Thu, 11 Oct 2001 15:18:56 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Sutherland <jas88@cam.ac.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: unkillable process in R state?
In-Reply-To: <Pine.SOL.4.33.0110111918330.24868-100000@orange.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:
> 
> On Thu, 11 Oct 2001, Ralf Baechle wrote:
> 
> > On Thu, Oct 11, 2001 at 12:48:22PM -0400, Christopher Friesen wrote:
> >
> > > I have a process (an instance of a find command) that seems to be
> > > unkillable (ie kill -9 <pid> as root doesn't work).
> > >
> > > Top shows it's status as R.
> > >
> > > Is there anything I can do to kill the thing? It's taking up all unused cpu
> > > cycles (currently at 97.4%).
> >
> > I assume that's kapm-idled.  That's normal, it's job is exactly burning
> > unused cycles.
> 
> No. He said it's an instance of find.
> 
> Stuck in R, though - some sort of loop? Christopher, can you attach gdb to
> it and see what's happening?


Okay, I just tried this, and the pertinant results were: 

$ gdb find
GNU gdb 4.18
Copyright 1998 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "ppc-yellowdog-linux"...(no debugging symbols
found)...
(gdb) attach 31075
Attaching to program: /usr/bin/find, Pid 31075



At this point it hangs and ctrl-C has no effect and I have to kill it from
another console.

Attaching to another program worked fine.

Any other ideas?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

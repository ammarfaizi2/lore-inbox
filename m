Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTDLXQM (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 19:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbTDLXQM (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 19:16:12 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15537 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262239AbTDLXQL (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 19:16:11 -0400
Date: Sat, 12 Apr 2003 19:27:40 -0400
From: Havoc Pennington <hp@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030412192740.B739@devserv.devel.redhat.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <20030411190717.GH1821@kroah.com> <20030411152920.C17638@devserv.devel.redhat.com> <20030412080721.GA2768@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030412080721.GA2768@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Apr 12, 2003 at 01:07:21AM -0700, Greg KH wrote: 
> Oh, and to compare sizes, with udev linked against klibc (static link)
> it comes out to a whopping big 6004 bytes:
> $ size udev
>    text    data     bss     dec     hex filename
>    5572       4     392    5968    1750 udev
> 

If it isn't obvious (I guess it is), that's an apples and oranges
comparison - though udev being smaller than /bin/true is either bad
for /bin/true or pretty good for udev. ;-)

I would want to compare D-BUS to a CORBA implementation, DCOP, M-BUS,
SOAP, or something like that (though it's reasonably different from
all of those). It's about the same size as DCOP, and about half the
size of ORBit2 which is a small CORBA. Then there's a large CORBA like
MICO that uses several megabytes. No clue how big an M-BUS
implementation is.

The important thing though in my mind isn't the raw size comparison
but what the size is "spent" on - for D-BUS the size is partially
spent on avoiding dependencies (DCOP and ORBit rely on GLib/Qt for
many things), and robustness (thread locks, OOM handling, robust API,
unit testability, and careful input validation). There's also size
cost to the abstractions made: system vs. per-session bus, bus daemon
vs. one-to-one, network transport (tcp vs. unix domain vs. whatever),
authentication mechanism (cookies, socket credentials, kerberos), and
so forth.

Other IPC sofware that's about the same size spends its code size on
different things, it's all about the tradeoffs.

Havoc





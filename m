Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRCPHWP>; Fri, 16 Mar 2001 02:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRCPHWG>; Fri, 16 Mar 2001 02:22:06 -0500
Received: from list.framfab.se ([195.54.96.202]:24848 "EHLO list.framfab.se")
	by vger.kernel.org with ESMTP id <S130038AbRCPHWC> convert rfc822-to-8bit;
	Fri, 16 Mar 2001 02:22:02 -0500
Message-ID: <E6D22E487D45D411931B00508BCF93E75C0329@storeg001.framfab.se>
From: Mårten Wikström <Marten.Wikstrom@framfab.se>
To: "'Martin Josefsson'" <gandalf@wlug.westbo.se>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Subject: RE: How to optimize routing performance
Date: Fri, 16 Mar 2001 08:21:08 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> You want to have CONFIG_NET_HW_FLOWCONTROL enabled. If you don't the
> kernel gets _alot_ of interrupts from the NIC and dosn't have 
> any cycles
> left to do anything. So you want to turn this on!
> 
> > At the NordU/USENIX conference in Stockholm (this february) I
> > saw a nice presentation on the flow control code in the Linux
> > networking code and how it improved networking performance.
> > I'm pretty convinced that flow control _should_ be saving your
> > system in this case.
> 
> That was probably Jamal Hadi and Robert Olsson. They have 
> been optimizing
> the tulip driver. These optimizations havn't been integrated with the
> "vanilla" driver yet, but I hope the can integrate it soon.
> 
> They have one version that is very optimized and then they have one
> version that have even more optimizations, ie. it uses polling at high
> interruptload.
> 
> you will find these drivers here:
> ftp://robur.slu.se/pub/Linux/net-development/
> The latest versions are:
> tulip-ss010111.tar.gz
> and
> tulip-ss010116-poll.tar.gz
> 
> > OTOH, if they _are_ enabled, the networking people seem to have
> > a new item for their TODO list. ;)
> 
> Yup.
> 
> You can take a look here too:
> 
> http://robur.slu.se/Linux/net-development/jamal/FF-html/
> 
> This is the presentation they gave at OLS (IIRC)
> 
> And this is the final result:
> 
> http://robur.slu.se/Linux/net-development/jamal/FF-html/img26.htm
> 
> As you can see the throughput is a _lot_ higher with this driver.
> 
> One final note: The makefile in at least 
> tulip-ss010111.tar.gz is in the
> old format (not the new as 2.4.0-testX introduced), but you 
> can copy the
> makefile from the "vanilla" driver and It'lll work like a charm.
> 
> Please redo your tests with this driver and report the 
> results to me and
> this list. I really want to know how it compares against FreeBSD.
> 
> /Martin

Thanks! I'll try that out. How can I tell if the driver supports
CONFIG_NET_HW_FLOWCONTROL? I'm not sure, but I think the cards are
tulip-based, can I then use Robert & Jamal's optimised drivers?
It'll probably take some time before I can do further testing. (My employer
thinks I've spent too much time on it already...).

FYI, Linux had _much_ better delay variation characteristics than FreeBSD.
Typically no packet was delayed more than 100usec, whereas FreeBSD had some
packets delayed about 2-3 msec.

/Mårten

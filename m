Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262269AbSJGAL4>; Sun, 6 Oct 2002 20:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbSJGAL4>; Sun, 6 Oct 2002 20:11:56 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:55314
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262269AbSJGALz>; Sun, 6 Oct 2002 20:11:55 -0400
Date: Sun, 6 Oct 2002 17:14:51 -0700 (PDT)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: jamal <hadi@cyberus.ca>
cc: Ben Greear <greearb@candelatech.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: Re: Update on e1000 troubles (over-heating!)
In-Reply-To: <Pine.GSO.4.30.0210061835350.1861-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.10.10210061700000.23945-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


However doing a data integrity test with a pattern buffer
write-verify-read on multi-lun, multi-session, and multiple connections
per session, while issuing load-balancing commands (ie thread tag) over
each session to roast the bandwidth of the line should be enough.

Now toss in injected errors to randomly fail data pdu's and calling a
sync-and-steering layer to scan the header and or data digests to execute
a within connection recovery, regardless if the reason, should be enough
to warm up the beast.

If that is not enough, I can toss in multi-initiators all with the
features above or invoke the interoperablity modes to add the cisco and
ibm initiator (both limited to error recovery level zero, while pyx's is
capable of error recovery level one and part of two).

Please let me know if I need to throttle it harder.

Cheers,

On Sun, 6 Oct 2002, jamal wrote:

> 
> 
> On Sat, 5 Oct 2002, Andre Hedrick wrote:
> 
> >
> > I have a pair of Compaq e1000's which have never overheated, and I use
> > them for heavy duty iSCSI testing and designing of drivers.  These are
> > massive 66/64 cards but still nothing like what you are reporting.
> >
> > I will look some more at the issue soon.
> >
> 
> It seems like the prerequisite to reproduce it is you beat the NIC heavily
> with a lot of packets/sec and then run it at that sustained rate for at
> least 30 minutes. isci would tend to use MTU sized packets which will
> not be that effective.
> 
> cheers,
> jamal
> 
> 
> 
> 

Andre Hedrick
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/


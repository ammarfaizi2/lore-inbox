Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbRFDTLK>; Mon, 4 Jun 2001 15:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261471AbRFDTLA>; Mon, 4 Jun 2001 15:11:00 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:34179 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S261837AbRFDTKo>;
	Mon, 4 Jun 2001 15:10:44 -0400
Date: Mon, 4 Jun 2001 15:08:51 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (forrealthis
In-Reply-To: <Pine.LNX.4.33.0106031401050.31050-100000@kenzo.iwr.uni-heidelberg.de>
Message-ID: <Pine.GSO.4.30.0106041502550.19655-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Jun 2001, Bogdan Costescu wrote:

> On Sat, 2 Jun 2001, jamal wrote:
>
> > Still, the tx watchdogs are a good source of fault detection in the case
> > of non-availabilty of MII detection and even with the presence of MII.
>
> Agreed. But my question was a bit different: is there any legit situation
> where Tx timeouts can happen in a row _without_ having a link loss ? In
> this situation, we'd have false positives...

Two places:
1) no MII indicators
2) shaky hardware and MII bounces. Is it on, is it off? What is going on?
You  could use them to "probe" to make sure that infact the MII indicators
are not false positives.

Your mileage may vary.

>
> > "Dynamic" in the above sense means trying to totaly avoid making it a
> > synchronous poll. The poll rate is a function of how many packets go out
> > that device per average measurement time. Basically, the period that the
> > user space app dumps "hello" netlink packets to the kernel is a variable.
>
> Sounds nice, but could this be implemented light enough ?
>

Not as simple as synchronous polls.
Note, however, simple/light does not imply the best.

cheers,
jamal



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135630AbRD1Uz1>; Sat, 28 Apr 2001 16:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135631AbRD1UzR>; Sat, 28 Apr 2001 16:55:17 -0400
Received: from dfw-smtpout3.email.verio.net ([129.250.36.43]:18311 "EHLO
	dfw-smtpout3.email.verio.net") by vger.kernel.org with ESMTP
	id <S135630AbRD1UzE>; Sat, 28 Apr 2001 16:55:04 -0400
Message-ID: <3AEB2E25.E7404FAF@bigfoot.com>
Date: Sat, 28 Apr 2001 13:55:01 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-intel-smp-ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: valery <valery.brasseur@atosorigin.com>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux and high volume web sites
In-Reply-To: <Pine.LNX.4.33.0104280109430.15628-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> 
> watch the resonate heartbeat and see if it is getting lost in the network
> traffic (the resonate logs will show missing heartbeat packets). think
> seriously of setting the resonate stuff to run at a higher priority so
> that it doesn't get behind.
> 
> depending on how high your network traffic is seriously look at putting in
> a second nic and switch to move the NFS traffic off the network that has
> the internet traffic and hearbeat.
> 
> I had the same problem with central dispatch a couple years ago when first
> implementing it. the exact details of the problem that I ran into should
> have been fixed by now (mostly having to do with large number of virtual
> IP addresses) but the symptoms were the same.

In addition to the above make sure there's enough bandwidth to the filer
(eg- good switches, multiple ethernets).

Consider moving to 2.2.19.  Significant VM changes after 2.2.19pre3 which
could account for the freezes.

rgds,
tim.

> > I have a high volume web site under linux :
> > kernel is 2.2.17
> > hardware is 5 bi-PIII 700Mhz / 512Mb, eepro100
> > all server are diskless (nfs on an netapp filer) except for tmp and swap
> >
> > dispatch is done by the Resonate product
> >
> > web server is apache+php (something like 400 processes), database
> > backend is a mysql on the same hardware
> >
> > in high volume from time to time machines are "freezing" then after a
> > few seconds they "reappear" and response timne is
> >
> >
> > how can I investigate all these problems ?

--

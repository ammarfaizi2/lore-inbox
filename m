Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSHMPFw>; Tue, 13 Aug 2002 11:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSHMPFw>; Tue, 13 Aug 2002 11:05:52 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:12295 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S315540AbSHMPFt> convert rfc822-to-8bit; Tue, 13 Aug 2002 11:05:49 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: 2.5.30 breaks cciss driver?
Date: Tue, 13 Aug 2002 10:09:32 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167D023@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: 2.5.30 breaks cciss driver?
Thread-Index: AcJC221wcLe1XRrsSoKSwKdMei2fcQ==
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <linux-kernel@vger.kernel.org>
Cc: <greg@kroah.com>
X-OriginalArrivalTime: 13 Aug 2002 15:09:35.0710 (UTC) FILETIME=[6F94F7E0:01C242DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Message 2 in thread 
Greg KH (greg@kroah.com) wrote:
> On Fri, Aug 02, 2002 at 03:47:51PM -0500, Stephen Cameron wrote:
> > 
> > I just saw this problem with 2.5.30.
> > 
> > I can't mount my 2nd volume on a cciss controller (SmartArray 5i)
> > 
> > < /dev/cciss/c0d1p1 
> > No such device or address
> > 
> > The first volume, /dev/cciss/c0d0p1, works fine
> > (I'm booted from it.)
> > 
> > Reboot 2.5.29, both volumes work fine.
> > 
> > I don't have time to look into this right now,
> > but I thought I'd mention it in case someone else
> > does have time.  Looks like there was some partition 
> > code and/or devfs changes...
>
> Are you running in "devfs=only" mode?  If so, the changes I made
> probably are the cause of this.
> 

No.  The changes that broke it are to do with the sizes[]
being gone, I think.  That yours?

/dev/cciss/c0d1 shows up in /proc/partitions, but not
/dev/cciss/c0d1p1 or /dev/cciss/c0d1p7

All the partitions of /dev/cciss/c0d0 show up.

(still broken in 2.5.31, of course)

I'm having some trouble with instability of 2.5.3[01],
don't know if it's just life with 2.5, or maybe my userland
is too old for my kernel...(redhat 7.1) Anyway, it's 
slowing me down, running fsck constantly after puking. :-(

-- steve



-

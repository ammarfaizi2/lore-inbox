Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUDISNM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 14:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUDISNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 14:13:12 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:13461 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S261551AbUDISNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 14:13:06 -0400
Date: Fri, 9 Apr 2004 11:12:57 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Martin Knoblauch <knobi@knobisoft.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <20040409175403.91924.qmail@web13904.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0404091100520.1074-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2004, Martin Knoblauch wrote:

> >I was wondering if for linux or better for a linux filesystem
> >there is something like dynamic swapping of files possible.
> >For explanation: I habeaccess to an Infinstor via NFS and
> >linux is runnig there. This server has a nice funtion I'd
> >like to have: if there are files that are not used for a
> >specified time (i.e. 30 days) they are moved to another storage
> >(disk and after that to an streamer tape) and are replaced
> >by some kind of 'link'. So if you look at your directory you
> >can see everything that was there, but if you try to open it,
> >you have to wait a moment (some seconds if the file was
> >swapped to another disk) oder just another moment (some
> >minutes if the file is on a tape) and then it restored at
> >it's old place.
> >
> 
>  Good description of a HSM (Hierarchical Storage Management)
> System.
> 
> >So is there anything which provides such a feature? By now
> >I have a little script that moves such files out of the way and
> >replaces them by links. But restoring is somewhat harder and
> >it's not automatic.
> >
> >Any ideas?
> >

part of the thing for us (my group at UO) right now, is tape robots aren't
cheaper than disk, so a lot of our offline/near-line backup is slowly
moving in that direction... 1TB lto jukeboxs cost order of $8-9K ea and
the driver for your commercial tabe-backup software can cost nearly that
much on top of it, but I can put 3.5TB of disk in a 5u enclosure and
locate in some other building for a similar price if not less. Even If buy
it in something like a netapp filer it's still only around $10,000 a TB so
HSM systems involving tape don't really have the same apeal as when we
were paying $1200ea for 4GB scsi disks. If I had sunk costs in something
like a storagetek powerhorn with 6000 tape capacity I might think a little
differently but I suspect your situation is closer to mine that it is to
the sorts of people who buy those.

>  Really depends. As far as I know thare are no "free" HSM Systems
> out there for Linux The only one that I am faintly familiar with
> that runs on Linux is StorNext from ADIC. Definitely not free.
> 
>  DMF/Irix may now be ported to Linux (Altix/IA64), but I doubt
> it will be free.
> 
>  Sun is most likely not (yet) interested in doing a Linux port
> of SAM-FS (there are still Sparc/Solaris Machines to sell).
> And it won't be free (my guess).
> 
>  Tivoli/IBM and UniTree are also sold for Linux. Again "sold" is
> the important word
> 
> Martin
> 
> 
> =====
> ------------------------------------------------------
> Martin Knoblauch
> email: k n o b i AT knobisoft DOT de
> www:   http://www.knobisoft.de
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu    
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUDWVbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUDWVbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 17:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUDWVbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 17:31:53 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:52876 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S261474AbUDWVbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 17:31:51 -0400
Date: Fri, 23 Apr 2004 14:31:26 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Paul Jackson <pj@sgi.com>, Timothy Miller <miller@techsource.com>,
       <tytso@mit.edu>, <miquels@cistron.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: File system compression, not at the block layer
In-Reply-To: <Pine.LNX.4.53.0404231624010.1352@chaos>
Message-ID: <Pine.LNX.4.44.0404231410130.27087-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004, Richard B. Johnson wrote:
> 
> If you want to have fast disks, then you should do what I
> suggested to Digital 20 years ago when they had ST-506
> interfaces and SCSI was available only from third-parties.
> It was called "striping" (I'm serious!). Not the so-called
> RAID crap that took the original idea and destroyed it.
> If you have 32-bits, you design an interface board for 32
> disks. The interface board strips each bit to the data that
> each disk gets. That makes the whole array 32 times faster
> than a single drive and, of course, 32 times larger.
> 
> There is no redundancy in such an array, just brute-force
> speed. One can add additional bits and CRC correction which
> would allow the failure (or removal) of one drive at a time.

except disks no longer encode one bit at a time (with prml), and you're
still serializing requests across all the spindles instead of dividing
requests between spindles... it's pretty clear that in the forseeable
future capacity grown will continue to far outstrip access speed in
spinning magnetic media. I would agree that any serious improvement is
likely to come for more creativly arranging the data at the block or
filesystem level, netapps log-structured raid4 being one direction to 
head... 
 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu    
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2



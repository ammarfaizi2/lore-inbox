Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132221AbRCVXEB>; Thu, 22 Mar 2001 18:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132234AbRCVXDt>; Thu, 22 Mar 2001 18:03:49 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:50436 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132231AbRCVXDh>;
	Thu, 22 Mar 2001 18:03:37 -0500
Date: Fri, 23 Mar 2001 00:02:54 +0100
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2-ac21
Message-ID: <20010323000254.A25375@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops...

Linux 2.4.2-ac21 does not like my box, or the other way around:

loading the agpgart module (MGA G400 AGP) -> system hangs
loading the SCSI module (53c875) -> system hangs

In both cases, the magic SysRq sequence does not work, but it is still possible
to ping the box from the outside. Connecting to it (ssh) does not work,
however. I backed out both the SCSI driver patches as well as the agpgart
patches, but this did not fix the symptoms. Looks more like a module-loading
related issue, but I have not found it yet.

All this on an SMP (Abit BP6) box by the way...

The changes which introduced these symptoms have occured somewhere between -ac7
and -ac21, since -ac7 DID run on the same hardware.

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267600AbRGNIqB>; Sat, 14 Jul 2001 04:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267599AbRGNIpw>; Sat, 14 Jul 2001 04:45:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22027 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267597AbRGNIpp>; Sat, 14 Jul 2001 04:45:45 -0400
Subject: Re: [PATCH] 64 bit scsi read/write
To: andrewm@uow.edu.au (Andrew Morton)
Date: Sat, 14 Jul 2001 09:45:44 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        adilger@turbolinux.com (Andreas Dilger),
        acahalan@cs.uml.edu (Albert D. Cahalan), bcrl@redhat.com (Ben LaHaise),
        kernel@ragnark.vestdata.no (Ragnar Kjxrstad),
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
In-Reply-To: <3B4FBB36.1F692780@uow.edu.au> from "Andrew Morton" at Jul 14, 2001 01:23:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LL3Y-0000yJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If, after a power outage, the IDE disk can keep going for long enough
> to write its write cache out to the reserved vendor area (which will
> only take 20-30 milliseconds) then the data may be considered *safe*
> as soon as it hits writecache.

Hohohoho.

> In which case it is perfectly legitimate and sensible for the drive
> to ignore flush commands, and to ack data as soon as it hits cache.

Since the flushing commands are 'optional' it can legitimately ignore them

> If I'm right then the only open question is: which disks do and
> do not do the right thing when the lights go out.

As far as I can tell none of them at least in the IDE world

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262240AbTCJWtp>; Mon, 10 Mar 2003 17:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262242AbTCJWtp>; Mon, 10 Mar 2003 17:49:45 -0500
Received: from jsl.com ([66.92.44.10]:23008 "EHLO jsl.com")
	by vger.kernel.org with ESMTP id <S262240AbTCJWto>;
	Mon, 10 Mar 2003 17:49:44 -0500
From: System Administrator <root@jsl.com>
Message-Id: <200303102300.h2AN0OO28470@jsl.com>
Subject: Re: 2.5.63 and 3ware 7810 IDE raid controller
To: linux-kernel@vger.kernel.org
Date: Mon, 10 Mar 2003 15:00:24 -0800 (PST)
Cc: Ray.OConnor@verizon.net (Ray O'Connor)
Reply-To: kernel1@jsl.com
In-Reply-To: <Pine.LNX.4.44.0303010007330.12711-100000@bertha> from "Ray O'Connor" at Mar 01, 2003 12:19:51 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> 
> I've using a 3ware 7810 IDE raid controller without problems thru 2.5.50.
> 
> Using 2.5.63, I'm now seeing %CPU > 90 for 3dmd, which is 3ware's
> monitoring daemon.  Other than CPU usage, things work normally.
> 
> Any clues as to why I'm seeing this?
> 
> Don't have the source for the 3dmd, which is released only as a binary.
> 
> Thanks,
> Ray
> 
> -- 
>   Ray O'Connor    <Ray.OConnor@verizon.net>

Maybe completely off here but since nobody else answered you, I thought I
would.  I've reported a problem to 3ware which they haven't yet solved.
3dmd seems to probe all SCSI disks on the system; not just the RAID array.
It caused problems for me whenever I had the usb-storage.o module loaded
because I have a USB CF reader in the same box.  3dmd seems to probe the
media, and errors are spewed to the logs because there is no media present.
The load average stays high while this is happening too.

I really wish 3ware would either fix 3dmd or release the source.

Jeff Laing
kernel1@jsl.com

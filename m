Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316250AbSGGRkI>; Sun, 7 Jul 2002 13:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSGGRkH>; Sun, 7 Jul 2002 13:40:07 -0400
Received: from ftp.realnet.co.sz ([196.28.7.3]:5074 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316250AbSGGRkG>; Sun, 7 Jul 2002 13:40:06 -0400
Date: Sun, 7 Jul 2002 20:00:41 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ata_special_intr, ide_do_drive_cmd deadlock
In-Reply-To: <Pine.SOL.4.30.0207071915310.1945-200000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0207071959150.1441-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jul 2002, Bartlomiej Zolnierkiewicz wrote:

> do_recalibrate is called under lock and it tries to acquire lock, so
> deadlock, you was the first to notice it and you have even added FIXME
> to the code... ;-)

I thought you had backed out most if not all those locking changes.

> Do you realise that 2.5.25 have IDE 93 and it should be fixed in IDE 96.

That i wasn't aware of, thanks i'm currently looking at 97

> BTW: know problem with 96 is broken ide_timer_expiry().
> Attached IDE 98 (or not) prepatch should fix it.

Thanks,
	Zwane Mwaikambo

-- 
function.linuxpower.ca


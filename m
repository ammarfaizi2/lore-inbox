Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSGGRiG>; Sun, 7 Jul 2002 13:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316250AbSGGRiF>; Sun, 7 Jul 2002 13:38:05 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64176 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316223AbSGGRiE>; Sun, 7 Jul 2002 13:38:04 -0400
Date: Sun, 7 Jul 2002 19:40:18 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ata_special_intr, ide_do_drive_cmd deadlock
In-Reply-To: <Pine.LNX.4.44.0207071922350.1441-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.SOL.4.30.0207071931240.9224-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While at it, please don't spent too much time on locking.
I reverted it to what 2.4.x (early 2.5?) kernels do and it should
work fine, remeber IDE_BUSY bit protects us from reentering
ide_do_request() (while it is set nothing will pass down this function
and REQ_STARTED request's flag protects from block layer.

Locking will be slightly changed/fixed but not now, but after fixing many
much more urgent issues...
I simply dont want to waste time on fixing locking n times.

Regards
--
Bartlomiej



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130520AbRCFMJB>; Tue, 6 Mar 2001 07:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130529AbRCFMIw>; Tue, 6 Mar 2001 07:08:52 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53512 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130520AbRCFMIo>; Tue, 6 Mar 2001 07:08:44 -0500
Subject: Re: scsi vs ide performance on fsync's
To: andre@linux-ide.org (Andre Hedrick)
Date: Tue, 6 Mar 2001 12:09:33 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        dougg@torque.net (Douglas Gilbert), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10103052310080.13719-100000@master.linux-ide.org> from "Andre Hedrick" at Mar 05, 2001 11:12:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14aGHY-0000Yc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't know if there is any way to turn of a write buffer on an IDE disk.
> You want a forced set of commands to kill caching at init?

Wrong model

You want a write barrier. Write buffering (at least for short intervals) in
the drive is very sensible. The kernel needs to able to send drivers a write
barrier which will not be completed with outstanding commands before the
barrier.


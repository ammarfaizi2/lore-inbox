Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318147AbSHDK5s>; Sun, 4 Aug 2002 06:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318148AbSHDK5s>; Sun, 4 Aug 2002 06:57:48 -0400
Received: from muck.dcs.ed.ac.uk ([129.215.216.15]:27132 "EHLO
	muck.dcs.ed.ac.uk") by vger.kernel.org with ESMTP
	id <S318147AbSHDK5r>; Sun, 4 Aug 2002 06:57:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15693.2431.358745.864511@toolo.dcs.ed.ac.uk>
Date: Sun, 4 Aug 2002 12:01:19 +0100
From: Julian Bradfield <jcb@dcs.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: latency while writing to pc-card disks/tapes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried searching, and asked on general lists, but so far without
result, so I'd like to ask here to find out what causes the issue:

I have a notebook (HP Omnibook 6000, but same happens with others)
running Linux 2.4.18 and pcmcia-cs 3.2.0.

When I make backups to PCMCIA devices, whether hard drives (standard
PC-card hard drive) or tapes (SCSI tape attached to Adaptec PC-card),
system response drops through the floor -- we're talking seconds to
respond to a mouse movement.

With the tape drive, this is constant; with the disk, the buffer cache
fills up, then the kernel starts writing to the disk and the rest of
the system crawls until the writes stop and the next batch of reads
happens.

Another thing that surprises me is that this runs the CPU at
full stretch, since the fan comes on. I find it hard to believe that
writing to a rather slow tape drive can fully exercise a 1GHz
processor continuously.
(It may be relevant for the tape that scsi dis/reconnect is disabled,
as it doesn't work for my card.)

Is there something I can do about this? I tried the kernel preemption
patch and the lock-breaking patch, with no result.
(With the disk, I have set the interrupt unmask via hdparm, but this
also makes no difference.)

I will follow the list, but would appreciate being cc'ed on any
replies.
Thanks for any advice!


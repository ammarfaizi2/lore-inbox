Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265210AbRF0QzT>; Wed, 27 Jun 2001 12:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265237AbRF0Qy7>; Wed, 27 Jun 2001 12:54:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38660 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265210AbRF0Qyv>; Wed, 27 Jun 2001 12:54:51 -0400
Subject: Re: 2.2.x series and mm
To: adam@eax.com (Adam)
Date: Wed, 27 Jun 2001 17:52:01 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106271134440.16671-100000@eax.student.umd.edu> from "Adam" at Jun 27, 2001 11:39:27 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FIXp-0005UE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > b)	Make the processes smaller (eg switch to thttpd from www.acme.com)
> > c)	Speed up the I/O throughput relative to CPU speed
> > 	- eg the 2.2 IDE UDMA patches
> 
> can you elaborate on the "c" point" perhaps I could try it together with
> 2.2.20pre6 until I can do a).
> 
> about b) would it really help? AFACT the issue here is the buffers in
> memory gets filled and cause other stuff to get swapped out., and that
> would happen no matter what kind of web server I use..

It depends if it takes the working set down (you dont care about the total
amount of data but the amount regularly being used) - thttpd uses a _lot_
less memory for the webserver itself so can help

As to c) - 2.4.x and with patches 2.2.x will do UDMA66/UDMA100 I/O on modern
disks and that takes the CPU usage down (so you do more work while the
disk is copying stuff) and might well be getting data on/off disk ten times
as fast


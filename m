Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQL1NnL>; Thu, 28 Dec 2000 08:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQL1NnA>; Thu, 28 Dec 2000 08:43:00 -0500
Received: from laxmls02.socal.rr.com ([24.30.163.11]:13724 "EHLO
	laxmls02.socal.rr.com") by vger.kernel.org with ESMTP
	id <S129226AbQL1Nms>; Thu, 28 Dec 2000 08:42:48 -0500
From: Shane Nay <shane@agendacomputing.com>
Reply-To: shane@agendacomputing.com
Organization: Agenda Computing
To: linux-kernel@vger.kernel.org
Subject: Booting from a non block device
Date: Thu, 28 Dec 2000 02:14:10 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <0012280214100G.32196@www.easysolutions.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to get rid of the abstraction that a block device brings because I 
need to run things in XIP (execute in place) mode from our cramfs partition.  
(We have uncompressed and aligned files inter mingled with our cramfs stuff 
so that the entire distro can be updated in a single flash)  The only thing 
that's keeping me from finishing at this point is I can't seem to figure out 
a smart way to accomplish file system direct booting.

The main.c file is hardwired to boot from a block device, and as such I can't 
think of a good way to get around it and put in a filesystem instead.  Should 
I just cheat and put in a fake block device?  Or am I going about this in an 
imbecilic fashion?

Any ideas, criticisms are welcome...
Thanks,
Shane Nay.
(BTW: XIP implementation is by another fellow..., I'm just trying to put 
together the linear addressing and his pieces into one nice unit, and get rid 
of the dev rom copying and unneeded buffering)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268980AbUJELKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268980AbUJELKh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 07:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268984AbUJELKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 07:10:37 -0400
Received: from 115.N1.EF.nwx-server.de ([217.114.219.115]:48310 "EHLO
	115.N1.EF.nwx-server.de") by vger.kernel.org with ESMTP
	id S268981AbUJELK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 07:10:27 -0400
Subject: kernel BUG at buffer.c:603
From: Axel Waggershauser <awagger@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 05 Oct 2004 13:10:03 +0200
Message-Id: <1096974603.1254.32.camel@sowas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a new machine with an  Adaptec AAC-RAID (rev 01) SATA raid
controller (aacraid module) running a

Linux version 2.4.27-1-686-smp (joshk@trollwife) (gcc version 3.3.4
(Debian 1:3.3.4-9)) #1 SMP Fri Sep 3 06:34:36 UTC 2004

kernel. It keeps crashing (oops) after several hours of running bonnie.
Most of the time I get a "kernel BUG at buffer.c:603" wich looks like
this

    if (bh->b_prev_free || bh->b_next_free) BUG();

in function

    static void __insert_into_lru_list(struct buffer_head * bh, int
blist)

There has been an other oops as well: "unable to handle kernel paging
request at virtual address 619139d0". This combined with several hints
on the net suggests that faulty hardware might be the cause. I checked
the 1G ram with memtest86+ - no problem...

Google revealed several other buffer.c:xxx bugs but none in line 603 so
I thouhgt, it might be worth to ask.


Thanks, for any help (if someone happens to know _the_ ultimate mem- or
harddisk-test, I'd be happy to stress this machine as long as it has
to...)


regards,
  Axel


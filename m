Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282321AbRKXBIe>; Fri, 23 Nov 2001 20:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282323AbRKXBIP>; Fri, 23 Nov 2001 20:08:15 -0500
Received: from [206.196.53.54] ([206.196.53.54]:43664 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S282318AbRKXBHz>;
	Fri, 23 Nov 2001 20:07:55 -0500
Date: Fri, 23 Nov 2001 19:10:04 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ext3: kjournald and spun-down disks
Message-ID: <Pine.LNX.4.40.0111231859510.4162-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My laptop drive seems to be waking up more often today and I suspect it's
somehow ext3/kjournald that's to blame. Does it obey the timings in
/proc/sys/vm/bdflush or does it have its own flush timer?

There's a more general problem with VM on laptops which is that the system
doesn't have any notion of spun-down disks. Flush intervals should be
short when the disk is running and long when it isn't and decisions about
which pages to discard or swap might be improvable. Pre-emptive swap when
the disk is spun down is a loss..

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


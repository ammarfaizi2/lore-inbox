Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264139AbSIQMcH>; Tue, 17 Sep 2002 08:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264145AbSIQMcG>; Tue, 17 Sep 2002 08:32:06 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:24072 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264139AbSIQMcF>; Tue, 17 Sep 2002 08:32:05 -0400
Message-ID: <3D8721FB.70B74C27@aitel.hist.no>
Date: Tue, 17 Sep 2002 14:37:15 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.35 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Thomas Molina <tmolina@cox.net>
CC: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: 2.5 Problem Report Status
References: <Pine.LNX.4.44.0209162050140.10084-100000@dad.molina>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:

> 14   RAID boot problem          open                  2.5.34
> 
This one got fixed in 2.5.34-bk6 and is ok in 2.5.35.

One may boot from a root RAID-1 now, if it don't
need to resync.

The kernel dies within a minute or two 
if it has to resync a sufficiently big
raid-1 though - by freezing solid.  Sometimes
with several 0-order allocation failures first.
this is a known problem.

This is made a bit worse by the way later
kernels also makes shutdown segfault so
the RAID's cannot be shutdown correctly.

My solution is to always boot 2.5.7 for
a correct 5-min sync after shutdown, before testing
a new kernel. :-/

Helge Hafting

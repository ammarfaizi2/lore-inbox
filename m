Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318086AbSGMD26>; Fri, 12 Jul 2002 23:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318089AbSGMD25>; Fri, 12 Jul 2002 23:28:57 -0400
Received: from pD952ACB5.dip.t-dialin.net ([217.82.172.181]:25225 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318086AbSGMD2z>; Fri, 12 Jul 2002 23:28:55 -0400
Date: Fri, 12 Jul 2002 21:31:34 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Further madness in fs/partitions/check.c?
Message-ID: <Pine.LNX.4.44.0207122128400.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

struct device contains a void * driver_data. It should certainly point to 
a couple of bytes where the driver data was saved.

In line 288, we have this:

current_driverfs_dev->driver_data = (void *)__mkdev(hd->major, minor+part);

What kind of pointer should we get here? ;-)

Can the author please explain what was intented here?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------


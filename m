Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129382AbRBWIWh>; Fri, 23 Feb 2001 03:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbRBWIWR>; Fri, 23 Feb 2001 03:22:17 -0500
Received: from ictmac01.ict.uni-karlsruhe.de ([129.13.127.116]:46089 "EHLO
	mail.ict.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S129416AbRBWIWO>; Fri, 23 Feb 2001 03:22:14 -0500
Message-ID: <3A961D3E.6E76067@ict.uni-karlsruhe.de>
Date: Fri, 23 Feb 2001 09:20:14 +0100
From: Jörg Ziuber <ziuber@ict.uni-karlsruhe.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bootp-Bug in 2.2.18 ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

to me it seems, there is a bug in 2.2.18 which does not allow remote
booting.

Situation:
A diskless client shall be booted via bootp (where 'diskless' is not the
problem). So a kernel is configured with the options:
* Networking options/IP: kernel-level configuration support/BOOTP
support  and
* File systems/Network file system/Root file system on NFS
The kernel is dd-dumped to a floppy and the client is booted.

Problem:
With kernel 2.2.16 and 2.4.x the client sends its bootp-request to the
network, gets an answer and boots without any problems.
The __same__ machine with 2.2.18 (configured the same way as
2.2.16/2.4.x) on its disk boots until the network adapter
initialisation, but the bootp-request to follow is _not_ send - it
cannot boot.
An extra test booting the 2.2.18 kernel from a disk with lilo on it
submitting the appended 'ip=bootp'-option causes the kernel to _tell_
that a bootp-reqest is send, but in fact it is _not_ (listening to the
network shows this result). So the machine can not get an answer and
cannot boot, respectively.

Because it works with 2.2.16/2.4.x it should be a kernel problem.
Any ideas ?

Bye,
-- 
Joerg Ziuber			Institut fuer Chemische Technik
				University of Karlsruhe
ziuber@ict.uni-karlsruhe.de	Kaiserstrasse 12
Tel. 0721 / 608-2399		D - 76128 Karlsruhe

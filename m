Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284569AbRLESxg>; Wed, 5 Dec 2001 13:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284567AbRLESx1>; Wed, 5 Dec 2001 13:53:27 -0500
Received: from pop.gmx.de ([213.165.64.20]:50564 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S284569AbRLESxP>;
	Wed, 5 Dec 2001 13:53:15 -0500
Date: Wed, 5 Dec 2001 19:53:08 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 freezes during IDE RAID5 resync
Message-Id: <20011205195308.53c6170c.rene.rebe@gmx.net>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Due to a f**ked power shortage (no UPS yet) our server had to reboot:
Hardware:

model name      : AMD-K6(tm) 3D processor
stepping        : 0
cpu MHz         : 350.814

RAM: 128 MB

Aladin5 based Asus board. IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE
(rev 193) and an additional:  Promise Technology, Inc. 20268 (rev 2).

There where 1 (for /) and 3 software RAID 5 IBM-DTLA-305040 each as master
on a single channel connected all using ReiserFS.

The system freezed (no oops - simply freeze) reproduceable during a ReiseFS
check of the / partiotion. (So it doens't even come to the /home md0 one).

I even booted a recsue disc mounted the / (so the transaction-log is clean),
and rebooted. Then it freezes at an ramdon point during the init.d scripts.

I fixed it by removing one IBM disc from the on-board IDE chip's
second channel and adding it to the promisse as slave. Now it works?

The server ran stable for 17 days using a 2.4.14 kernel and using the
2.4.16 since it got out ... I do not know what might be wrong, IDE code,
ALi M5229 IDE code, RAID code (or ReierFS)? - I do not expet it to be fixed
from this lousy bug-report - only that you heared that there might be a problem
somehere in this areas ...

(Oh. I do not like to try this again with our data - and we will have a
UPS in some days ;-) - AND I will never use IDE crapp again :-((( )

Much thanks!
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.

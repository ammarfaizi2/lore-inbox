Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbTKXKFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 05:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTKXKFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 05:05:49 -0500
Received: from web13902.mail.yahoo.com ([216.136.175.28]:65077 "HELO
	web13902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263715AbTKXKFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 05:05:37 -0500
Message-ID: <20031124100534.24941.qmail@web13902.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Mon, 24 Nov 2003 02:05:34 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: RAID-0 read perf. decrease after 2.4.20
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello All!
>
>Has anyone else experienced a drastic drop in read performance on
>software
>RAID-0 with post 2.4.20 kernels? We have a few Athlon XP's here at our
>lab with double IDE disks on different channels set up as RAID-0. Some
>bonnie++ benchmark results with various kernels, on the same machine
>(Athlon XP 2400+, 2 GHz, 1.5 GB RAM, VIA chipset, 2*Maxtor 120 GB
>6Y060L0):
>write read
>2.4.20-ac1: 88,000 135,000 K/sec
>2.4.21-pre7: 93,000 75,000
>2.4.22-ac4: 94,000 82,000

Hi,

 I can attest a similar drop in read performance on a IA64 box going
from a 2.4.19ish kernel to 2.4.22. In our setup the RAID0 is LVM, not
MD.The RAID is used a a scratch device for a out-of-core finite element
program (NASTRAN).

 The setup is some 20 disks on 4 controllers. "iozone" read/reread
Performance went from about 400MB/sec to 260 MB/sec, while write went
up a notch. Unfortunatelly the read performance is more important for
the application in question.

 Due to the fact that I have no controll over the use of the system I
cannot make any experiments to find out what killed performance. Sorry
:-(

Martin

=====
------------------------------------------------------
Martin Knoblauch
email: knobi@knobisoft.de or knobi@rocketmail.com
www:   http://www.knobisoft.de




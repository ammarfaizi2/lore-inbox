Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTDPSb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTDPSb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:31:29 -0400
Received: from mcomail02.maxtor.com ([134.6.76.16]:14860 "EHLO
	mcomail02.maxtor.com") by vger.kernel.org with ESMTP
	id S264531AbTDPSb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:31:28 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D134@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Anders Larsson'" <anders@dio.jll.se>, linux-kernel@vger.kernel.org
Subject: RE: bio too big device
Date: Wed, 16 Apr 2003 12:43:06 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Anders Larsson [mailto:anders@dio.jll.se]
> Sent: Wednesday, April 16, 2003 12:32 PM
>
> hdg: WDC WD1200JB-00DUA0, ATA DISK drive  
> hdg: host protected area => 1
> hdg: 234441648 sectors (120034 MB) w/8192KiB Cache, 
> CHS=14593/255/63,       
> UDMA(100)
> 
> hdh: WDC WD1200JB-75CRA0, ATA DISK drive
> hdh: host protected area => 1
> hdh: setmax LBA 234441648, native  234375000
> hdh: 234375000 sectors (120000 MB) w/8192KiB Cache, 
> CHS=232514/16/63,       
> UDMA(100)


On hdh, it appears you're setting the max lba > the native size.  Maybe this
is the problem.

For RAID on two drives, I would imagine your RAID size would need to be the
size of the smaller device, not the larger device.  (Note that they aren't
identical).

Not sure if the two different CHS translation modes on each drive is
important or not (probably not), that legacy bios stuff is something that
has always confused me...

--eric

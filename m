Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316024AbSEJPUA>; Fri, 10 May 2002 11:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316025AbSEJPT7>; Fri, 10 May 2002 11:19:59 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:12672 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S316024AbSEJPT5>; Fri, 10 May 2002 11:19:57 -0400
Message-ID: <3CDBE510.18FDA219@ukaea.org.uk>
Date: Fri, 10 May 2002 16:19:44 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: amiller@nada.kth.se
CC: linux-kernel@vger.kernel.org
Subject: Re: ide dma timeout error, linux 2.4.9, PIIX4 Ultra 100
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew...

Just came across your message.  Your problem looks more or less
identical to the one I had, which corrupted some of my partitions.

The following sequence in particular appears to be the signature of the
bug that I have sort-of "fixed":
kernel: hda: status error: status=0x58 { DriveReady SeekComplete
DataRequest }
kernel: hda: drive not ready for command
kernel: hdb: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)

The notable bit is that the 0x58 error + "drive not ready" error are
immediately followed by the ATAPI....UDMA message.  Is this always the
case?

My "fix" doesn't cure the root problem but does cure the corruption
issues for me at least.  Can you try it please and see if your 0x58
errors go away?

I posted it from my other email address (nconway_kernel@yahoo.co.uk) but
you should find it easily on any archive browser (this URL should work
http://marc.theaimsgroup.com/?l=linux-kernel&m=102098499900453&w=2 with
any luck).  You want the "updated" patch that I posted last night.  I
believe it should apply cleanly against the old 2.4.9 kernel.

cheers
Neil

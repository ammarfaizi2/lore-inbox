Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbREUFJq>; Mon, 21 May 2001 01:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbREUFJg>; Mon, 21 May 2001 01:09:36 -0400
Received: from marilyn.protocoloweb.com.br ([200.185.63.18]:7945 "EHLO
	smtp.ieg.com.br") by vger.kernel.org with ESMTP id <S262392AbREUFJY>;
	Mon, 21 May 2001 01:09:24 -0400
Message-ID: <3B08A339.CF0D86CC@linuxall.org>
Date: Mon, 21 May 2001 02:10:18 -0300
From: Slump <slump@linuxall.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 bug...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a bug in the patches for kernel 2.4.4.
When i use 2.4.4 clean, with no patches....

hde: IBM-DTLA-307020, ATA DISK drive
hde: 40188960 sectors (20577 MB) w/1916KiB Cache, CHS=39870/16/63,
UDMA(100)

then, using kernel 2.4.4 with ac11 patch...

hde: IBM-DTLA-307020, ATA DISK drive
hde: 40188960 sectors (20577 MB) w/1916KiB Cache, CHS=39870/16/63,
UDMA(44)

why the hard-disk is found at udma 3??

----------------------------------------------------------------------

-=[/home/slump]=- hdparm -t /dev/hde

/dev/hde:
 Timing buffered disk reads:  64 MB in  2.29 seconds = 27.95 MB/sec
----------------------------------------------------------------------

-=[/home/slump]=- hdparm -X69 /dev/hde

/dev/hde:
 setting xfermode to 69 (UltraDMA mode5)


-=[/home/slump]=- hdparm -t /dev/hde

/dev/hde:
 Timing buffered disk reads:  64 MB in  1.84 seconds = 34.78 MB/sec
------------------------------------------------------------------------

My machine is an athlon 950, with abit-kt7raid motherboard. My hard-disk
is an IBM DTLA 307020 20gb UDMA 5.

thank's to all ;)

Guilherme M. Schroeder
slump@linuxall.org


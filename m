Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263250AbREaWLl>; Thu, 31 May 2001 18:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263254AbREaWLb>; Thu, 31 May 2001 18:11:31 -0400
Received: from cs6625192-102.austin.rr.com ([66.25.192.102]:22534 "EHLO
	mail1.cirrus.com") by vger.kernel.org with ESMTP id <S263250AbREaWL1>;
	Thu, 31 May 2001 18:11:27 -0400
Message-ID: <973C11FE0E3ED41183B200508BC7774C0124F2DA@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <twoller@crystal.cirrus.com>
To: "'Rik van Riel'" <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: RE: no sound with CS4281 card
Date: Thu, 31 May 2001 17:12:10 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I Can not reproduce the problem with 2.4.5-ac5 driver or with latest rev of
the driver that I have been working on, or with any of the previous 4
internal releases back to early april.  although I do not have a Toshiba
laptop to test on and don't doubt that there might be a problem on your
system.  I have not tested a 1755 model.  Another user indicated that the
Toshiba 1620 CDS works with the latest driver.   
I'll wait for your input concerning the latest driver that I sent to you via
email.  Fyi, I have USB disabled, SMP enabled, and all *PM enabled.
If you can boot with max debugging
/sbin/insmod cs4281.o cs_debuglevel=9 cs_debugmask=0xffffffff
and then run mpg123 on a very small mp3 file or very small wave file (<16k).
It'll be a lot of output, but if you could send it all, especially the boot
info, that'd help me to debug the problem.
Thanks
tom

 -----Original Message-----
From: 	Rik van Riel [mailto:riel@conectiva.com.br] 
Sent:	Thursday, May 31, 2001 1:15 PM
To:	linux-kernel@vger.kernel.org
Cc:	twoller@crystal.cirrus.com
Subject:	no sound with CS4281 card

Hi,

my notebook (Toshiba 1755) comes with CS4281 built-in,
with all 2.4 kernels I tried this sound card doesn't
generate any sound, or interrupts for that matter.

The driver detects the card fine, but doesn't seem to
be able to do anything with it, on 2.4.5-ac2:

==== /proc/pci ====
  Bus  0, device   8, function  0:
    Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI Audio (rev
1).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=24.
      Non-prefetchable 32 bit memory at 0xfc010000 [0xfc010fff].
      Non-prefetchable 32 bit memory at 0xfc000000 [0xfc00ffff].

==== dmesg ====
cs4281: version v1.13.32 time 15:54:07 May 29 2001
PCI: Enabling device 00:08.0 (0000 -> 0002)
PCI: Found IRQ 5 for device 00:08.0

==== /proc/interrupts ====
  5:          0          XT-PIC  Crystal CS4281

(after trying to play music with mpg123 about 20 times)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

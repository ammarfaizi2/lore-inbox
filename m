Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284475AbRLCIve>; Mon, 3 Dec 2001 03:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284480AbRLCIul>; Mon, 3 Dec 2001 03:50:41 -0500
Received: from MAIL1.ANDREW.CMU.EDU ([128.2.10.131]:60864 "EHLO
	mail1.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S284809AbRLCGP0>; Mon, 3 Dec 2001 01:15:26 -0500
Message-ID: <3C0B1239.70808@andrew.cmu.edu>
Date: Mon, 03 Dec 2001 00:48:41 -0500
From: Jeff Maki <jmaki@andrew.cmu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011014
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SMP, MD and Promise IDE Controllers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone! Got an issue with the APIC, SMP and possible MD code - 
I've got this dual Athlon box with two Promise Ultra100TX2 cards. Each 
has two IBM disks on it, for a total of four.  I use the RH7.2 installer 
to install software raid 0, and everything works fine! No errors, 
nothing. Absolutely perfect. When I boot the *real* kernel, however, I 
get a number of things:

- I/O errors to hdi and hdk (the two disks on the second promise card - 
which isn't UDMA because the ports can't be probed. The two disks on the 
first are UDMA - never any errors on those)
- Spurious interrupt #7
- APIC error - AMD Errata #22, try noapic.

The thing works perfectly in single processor mode, by the way. I also 
tried noapic (although I still get the message to try noapic! Does this 
flag do anything!?) and also tried changing two bios options - the MP 
table to revision 1.1 or 1.4, and this strange option to "use IRQ table 
entries in MP" or some such thing. I tried both options, on and off, and 
I still get these errors. It seems to be apic related - anyone out there 
have any ideas on how I might get it working!? I also tried 2.4.14 to a 
limited fashion, but since he I/O errors corrupt the fs, so I can't try 
too many things before I have to re-install!

Thanks!!

-Jeff.


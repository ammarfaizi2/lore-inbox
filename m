Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268245AbTBNMDN>; Fri, 14 Feb 2003 07:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268366AbTBNMDN>; Fri, 14 Feb 2003 07:03:13 -0500
Received: from micropolis.microdata-pos.de ([212.8.203.34]:19468 "HELO
	imail.microdata-pos.de") by vger.kernel.org with SMTP
	id <S268245AbTBNMDL>; Fri, 14 Feb 2003 07:03:11 -0500
Date: Fri, 14 Feb 2003 13:12:28 +0100
From: Michael Westermann <mw@microdata-pos.de>
To: linux-kernel@vger.kernel.org
Subject: strangely serial Problem 
Message-ID: <20030214131227.A5002@microdata-pos.de>
Mail-Followup-To: Michael Westermann <mw@microdata-pos.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have a strangely serial Problem. 

I have a box with Kernel 2.2.23 and Suse and a box with
Debian with kernel 2.2.23. Old IDE-Disk's without DMA. 
Both boxes are connect with crossober Cable.

On the reading box run's a "find /[!p]* -type f -exec grep  "balffasel" {} \;
to the same time. 

I have tested with:

stty -F /dev/ttyS0 0:0:800008bf:0:3:1c:7f:15:4:0:1:0:0:0:1a:0:12:f:17:16:0:0:0:0
:0:0:0:0:0:0:0:0:0:0:0:0 

38400 baud

cat /dev/ttyS0 > testdat 

on the reading box

for i in `seq 1 500`; do \
printf "%04d 0123456789012345678901234567890123456789012345678901234567890\n" $i
 > /dev/ttyS0  ; done

on the writing box

When the debian-Box send the characters, to get lost characters.
When the Suse-Box send's it's ok. i

I have tested only with a runnig bash "lili: linux init=/bin/bash"
the same Problem. On both boxes are the same kernel, the same
serial parabeters, both boxes work with FIFO. 

I have tested the kernel 2.2.16...23 and 2.4.2 2.4.17 2.4.20, only
the 2.4.17 has the same problem on debian. 


I think that is a interrupt  Probelem,but what is the causale?
what the difference.

When I use the FIFO, the UART read 8 char's to put a Interrupt.  
The time for 8 char's is 2 ms. After this time we have a overrun,
but I thin that is a long time witout a Interrupt.

Thank's

Michael Westermann







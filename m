Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264942AbRGNUkI>; Sat, 14 Jul 2001 16:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbRGNUj7>; Sat, 14 Jul 2001 16:39:59 -0400
Received: from james.kalifornia.com ([208.179.59.2]:29224 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S264883AbRGNUjn>; Sat, 14 Jul 2001 16:39:43 -0400
Message-ID: <3B50AE0D.80002@blue-labs.org>
Date: Sat, 14 Jul 2001 16:39:41 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010713
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.5+ hangs on boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, aic7xxx hang solved on one machine with APIC solution
Ok, sched.c hang solved on another machine with patch.

However that patch doesn't solve everything and there are a few other 
places where things hang.

*) I20 hangs in the middle of I20 init on -every- system I have from 586 
to pIII in recent kernels
*) something hangs just after floppy init, last line is FDC0...

The FDC is immediately prior to where I2O inits so possibly the hang is 
actually just following FDC/I2O?  Normal boot messages should be like this:

Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Loading I2O Core - (c) Copyright 1999 Red Hat Software
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
I2O LAN OSM (C) 1999 University of Helsinki.
early initialization of device teql0 is deferred
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre3 (June 1, 2001)
PCI: Found IRQ 5 for device 00:10.0

Any comments or suggestions?  2.4.5-ac19 is the last kernel I have that 
works.

David




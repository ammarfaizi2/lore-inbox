Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUCLJTA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 04:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUCLJTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 04:19:00 -0500
Received: from mail.bmlv.gv.at ([193.171.152.37]:60870 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id S262044AbUCLJS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 04:18:57 -0500
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: linux-kernel@vger.kernel.org
Subject: Can't access ACPI memory through /dev/mem
Date: Fri, 12 Mar 2004 10:18:35 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403121018.35207.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody!

My machine gives me for
	$ cat /proc/iomem
	00000000-0009fbff : System RAM
	0009fc00-0009ffff : reserved
	000a0000-000bffff : Video RAM area
	000c0000-000c7fff : Video ROM
	000d0000-000d9fff : Extension ROM
	000f0000-000fffff : System ROM
	00100000-0f7dffff : System RAM
	  00100000-0022ca51 : Kernel code
	  0022ca52-0029d8e3 : Kernel data
	0f7e0000-0f7e7fff : ACPI Tables
	0f7e8000-0f7fffff : ACPI Non-volatile Storage
	80100000-801fffff : PCI Bus #01
	  80100000-8011ffff : Silicon Integrated Systems [SiS] SiS630 GUI
and so on.

Now I can access the whole area below the ACPI tables (I tried RAM, video and 
system ROM, and kernel code/data).
But on reaching the ACPI tables and above (PCI space and so on) I get no data 
(that is, vche blanks the screen).

I'd expect that for the PCI space - as this is really IO-memory and shouldn't 
be messed with.

But I'd like to access the ACPI tables; especially the NVRAM, as some machines 
store DMI data there.

This is on 
	Linux version 2.4.24-1-686 (herbert@gondolin) (gcc version 3.3.2 (Debian))
and an old 2.4.19 kernel.


Any tips? Help for accessing this memory space?


Regards,

Phil

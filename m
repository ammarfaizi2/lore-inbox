Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbUDXDRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUDXDRe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 23:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUDXDRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 23:17:34 -0400
Received: from [81.219.144.6] ([81.219.144.6]:11022 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261879AbUDXDRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 23:17:16 -0400
Message-ID: <4089DC36.5020806@pointblue.com.pl>
Date: Sat, 24 Apr 2004 04:17:10 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix error handling in "not enough swap space"
Content-Type: multipart/mixed;
 boundary="------------060205060509060701030706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060205060509060701030706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

I am unable to suspend to swap nowdays, getting message 'not enough 
swapspace'.
My swap space is 1172704k in size (1GB).

nalesnik:~# fdisk -l /dev/hda

Disk /dev/hda: 40.0 GB, 40007761920 bytes
255 heads, 63 sectors/track, 4864 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1               1         146     1172713+  82  Linux swap
/dev/hda2             147        1605    11719417+  83  Linux
/dev/hda3            1606        4864    26177917+  83  Linux


Here's the message I got after issuing 'echo "4" >/proc/acpi/sleep':

...

/critical section: counting pages to copy..[nosave pfn 
0x463].................................................................
  (pages needed: 10056+512=10568 free: 18599)
Alloc pagedir
..[nosave pfn 0x463]...............................critical section/: 
done (10056 pages copied)
blk: queue c6d40e00, I/O limit 4095Mb (mask 0xffffffff)
Writing data to swap (10056 pages):  .<0> Kernel panic:
Not enough swapspace when writing data
  _


this is PCG-C1VE sony vaio picture book, dmesg attached. Kernel version 
2.6.6-rc2-bk2.




--------------060205060509060701030706
Content-Type: application/octet-stream;
 name="dmesg.txt.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg.txt.bz2"

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
Yhdf270ZiO1cgBYP/xdyRThQkNhBlWY=
--------------060205060509060701030706--


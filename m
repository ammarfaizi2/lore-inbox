Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbTIYB2q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 21:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbTIYB2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 21:28:46 -0400
Received: from ns1.triode.net.au ([202.147.124.1]:3543 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP id S261646AbTIYB2n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 21:28:43 -0400
Message-ID: <3F72447C.4000909@torque.net>
Date: Thu, 25 Sep 2003 11:27:24 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, es-es, es
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: rfc: test whether a device has a partition table
References: <UTC200309242029.h8OKTo008219.aeb@smtp.cwi.nl> <3F723A04.2000609@torque.net> <20030925010052.GD7665@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030925010052.GD7665@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/mixed;
 boundary="------------030101040003060204060003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030101040003060204060003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Sep 25, 2003 at 10:42:44AM +1000, Douglas Gilbert wrote:
> 
>>I have a USB 500 MB USB key that confuses linux (both 2.4 and
>>2.6) since it has no partition table. It shows up on my laptop as:
> 
> 
> Confuses it in which sense?

Al,
Under lk 2.4 (rh9) this is in my log:

Sep 25 10:37:53 localhost kernel: SCSI device sda: 1024000 512-byte hdwr 
sectors (524 MB)
Sep 25 10:37:53 localhost kernel: sda: Write Protect is off
Sep 25 10:37:53 localhost kernel:  sda: sda1 sda2 sda3 sda4

Attached is sector 0 of the device and the output of
"fdisk -l".

lk 2.6.0-test5-bk10 also thinks the device has 4 malformed
partitions.

>>$ cat /proc/scsi/scsi
>>Attached devices:
>>Host: scsi0 Channel: 00 Id: 00 Lun: 00
>>  Vendor: Prolific Model: USBFlashDisk     Rev: 1.00
>>  Type:   Direct-Access                    ANSI SCSI revision: 02
>>
>>I can mount it with:
>>$ mount /dev/sda /mnt/extra
> 
> 
> So it works fine.  what's the problem?

It is non obvious. W2K and XP handled the USB key without
a problem. An organisation bought a bunch of these USB
"floppies" and expected them to work with linux (like
other USB mass storage devices they had experienced). I
was given one to find out what was wrong ...


BTW Another interesting aspect of this USB key is that
some sectors read before they are ever written can give
a "medium error, unrecoverable read". Once the sector
is written the problem goes away. This shouldn't be a
problem in normal use. [I guess at least sector 0 is
written in the factory :-) ]

Doug Gilbert


--------------030101040003060204060003
Content-Type: application/x-gzip;
 name="prolific_sect0.img.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="prolific_sect0.img.gz"

H4sICIJAcj8AA3Byb2xpZmljX3NlY3QwLmltZwB7bTchoCg/JzMtM5mBSYGRgSmAiYHhRy2D
PRCCwQJ+hgZGTQZU4OYYYmgGpD/W/jI+2Xdxz59qMfa9FQxHyxjkwsRC9yuxdtYxdPoxbeT+
83kJm/xehppjrv/4u90kOlx//rZIU6lhOStcZNPlJjDje5oYs5uMcJgcsxuf8MWAoE63P51h
/3YoMHSXCX5/1h3HzXzY4/tnRrc/gn7/oiJ2M7B3/97I+GIKQ5G7hW6J5EbusO4yu8/L4kq8
/Eq4mX82Hxe1/l309PV17ZM7btS2u9nZ3Cidua+hds0M5g9rWg6UiNv8L+HcwrebneGswOt3
+5prXz/d11j7+oHxgbNicfL9LP0uTGcl9zXVdtfyN/9nKjrRfdzDo8uP9/tDZrc/wmH/gNYH
b2R5IcYQXXSi0d43qnR5434GJiev0vmvGJgKGAKCAidOMr70vUxiIhA7tZ/6XibV9akrTKXr
xYUzF85wndnByHRWODIqoojToZTRiTmO+9GZw8wSjOq8XJ55ZYk5mSkKxZXFJam5CimZxdn/
eblcgJSCp76/QmpRUX4RUCAotSAnMTlVoSQjFaxGRyExLwXEy1MoKEotLgZyKxWyUyt5uRg8
/RXAIDgy2DfYxT8YwmxgZAj39HPy9w8B8RgYQlcBADBoxZ4AAgAA
--------------030101040003060204060003
Content-Type: text/plain;
 name="fdisk.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fdisk.txt"


Disk /dev/sda: 524 MB, 524288000 bytes
17 heads, 59 sectors/track, 1020 cylinders
Units = cylinders of 1003 * 512 = 513536 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1   ?   1914209   2457017 272218546+  20  Unknown
Partition 1 has different physical/logical beginnings (non-Linux?):
     phys=(356, 97, 46) logical=(1914208, 5, 40)
Partition 1 has different physical/logical endings:
     phys=(357, 116, 40) logical=(2457016, 16, 59)
Partition 1 does not end on cylinder boundary.
/dev/sda2   ?   1326206   1863570 269488144   6b  Unknown
Partition 2 has different physical/logical beginnings (non-Linux?):
     phys=(288, 110, 57) logical=(1326205, 9, 57)
Partition 2 has different physical/logical endings:
     phys=(269, 101, 57) logical=(1863569, 13, 16)
Partition 2 does not end on cylinder boundary.
/dev/sda3   ?    537378   1931558 699181456   53  OnTrack DM6 Aux3
Partition 3 has different physical/logical beginnings (non-Linux?):
     phys=(345, 32, 19) logical=(537377, 4, 25)
Partition 3 has different physical/logical endings:
     phys=(324, 77, 19) logical=(1931557, 10, 42)
Partition 3 does not end on cylinder boundary.
/dev/sda4   *   1390457   1390478     10668+  49  Unknown
Partition 4 has different physical/logical beginnings (non-Linux?):
     phys=(87, 1, 0) logical=(1390456, 5, 1)
Partition 4 has different physical/logical endings:
     phys=(335, 78, 2) logical=(1390477, 9, 38)
Partition 4 does not end on cylinder boundary.

Partition table entries are not in disk order

--------------030101040003060204060003--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbTDHQkZ (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTDHQkZ (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:40:25 -0400
Received: from ns2.ypf.com.ar ([200.32.103.4]:58250 "EHLO ns2.ypf.com.ar")
	by vger.kernel.org with ESMTP id S261488AbTDHQjo convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 12:39:44 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Uncompressing Linux... Ok, booting the kernel.
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Tue, 8 Apr 2003 13:51:16 -0300
Message-ID: <B93FC7A08A0B954C9590761383E59C9F4951A9@dti.ypf.com.ar>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Uncompressing Linux... Ok, booting the kernel.
Thread-Index: AcL97xI+1B9QtmSDQySM/Hvl5gnmOA==
From: <FRODRIGUEZC@REPSOLYPF.COM>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Apr 2003 16:51:04.0546 (UTC) FILETIME=[0B201C20:01C2FDEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please, if someone can help me... the problem is, that all I see is:

Uncompressing Linux... Ok, booting the kernel. 

The kernel type is OK, because the same kernel is happily running on another Pentium III Xeon.
Actually this kernel was compiled by the people at SAP and I am supposed to make it run without
making any changes. Actually I do not have the info on how this kernel was compiled
(or with what patches).

I read an Alan Cox message stating it could be that the kernel would be running, but not
showing it on a terminal. This is not the case though because I have pinged the machine
several minutes after the above message appears on screen an nothing, the machine is dead.

I also tried disabling the serial consoles with no results.

The machine is a Compaq Proliant DL580 with 4 Pentium Xeon 700mhz processors and
4 GBs of RAM. It has installed linux RedHat 7.1 (the release certified by SAP).

This is the ls of the non working kernel:

-rw-r--r--    1 root     root      1052022 Feb 26  2002 vmlinuz-2.4.9-31enterprise
-rw-r--r--    1 root     root       237352 Apr  8 12:55 initrd-2.4.9-31enterprise.reiserfs.img

I rebuilt the initrd file like this:
mkinitrd -f --with=reiserfs  --fstab=/etc/fstab /boot/initrd-2.4.9-31enterprise.reiserfs.img 2.4.9-31enterprise

The original SMP kernel included in RedHat boots fine on this hardware. It is somewhat smaller
though:

-rw-r--r--    1 root     root       840884 Apr  8  2001 vmlinuz-2.4.2-2smp

This same SAP kernel I have already running on an 8 PIII Xeon with 8 GBs RAM, without problems.
The server is a Hewlett Packard, instead of a Compaq.

I also tried to check the servers base memory settings, but there is no such thing in the
Compaq BIOS setup program. Only param shown is the memory size.

I did an md5sum on the kernel image and compared to the one running on the HP server. Both
images are identical.



Thanks in advance.

--------------------------------------------------
Fernán Rodríguez Céspedes
.--. .- ... - .. - --- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTKQCCX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 21:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTKQCCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 21:02:23 -0500
Received: from lns-th2-3f-81-56-201-35.adsl.proxad.net ([81.56.201.35]:58753
	"EHLO tethys.solarsys.org") by vger.kernel.org with ESMTP
	id S263260AbTKQCCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 21:02:21 -0500
Date: Mon, 17 Nov 2003 03:01:58 +0100
From: wwp <subscript@free.fr>
To: linux-kernel@vger.kernel.org
Subject: possible IDE/ext3 fs corruption while playing w/ ACPI and/or
 2.4.22?
Message-Id: <20031117030158.6f690676.subscript@free.fr>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


I wonder if playing w/ vanilla 2.4.22 or 2.4.22+ACPI patches can lead to
IDE/ext3 fs corruption..

I'm using SuSE 8.1 on my Dell Inspiron 8200, default SuSE 2.4.19-4GB
kernel (acpi 20020829). I've compiled 2.4.22 vanilla and 2.4.22 + latest
ACPI code + latest ieee1394 (gcc 3.2), and got IDE faults that lead to ext3
corruption when (re)booting to those 2.4.22 kernels, in different ACPI modes
(w/ or w/o batteries, power supply).

Here what /var/log/messages shows:
	kernel: hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
	kernel: hda: drive not ready for command
This error usually occurs right when booting the a 2.4.22 kernel (vanilla or
w/ ACPI patches), and I got broken files and directories sometimes.

I usually use SuSE's 2.4.19 kernel, and never have IDE/ext3 problems. Those past
3 months, I tried twice to compile and use 2.4.22 and each time I got fs corruption.

So I double-checked my drive for broken sectors, also did 4-hour long memory
check: nothing bad has been found. I've also upgraded to modutils 2.4.26.

That's why I'm trying to figure out what element (kernel, acpi, ieee1394,
SuSE stuff, Dell hardware/BIOS) is leading to such IDE errors and to fs
data loss.

Any thought about such problems or maybe how to investigate? Did anyone
experienced such problems w/ ACPI, Dell hardware or fresh 2.4.22 kernel?


Regards,

-- 
wwp

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265473AbTIDSec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265444AbTIDSec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:34:32 -0400
Received: from tweedy.ksc.nasa.gov ([128.217.76.165]:47789 "EHLO
	tweedy.ksc.nasa.gov") by vger.kernel.org with ESMTP id S265473AbTIDSeX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:34:23 -0400
Subject: Re: serial console on x86
From: Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0309040939230.18624-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0309040939230.18624-100000@dlang.diginsite.com>
Content-Type: text/plain
Message-Id: <1062700460.16972.9.camel@tweedy.ksc.nasa.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 04 Sep 2003 14:34:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 12:45, David Lang wrote:
> I am attempting to install linux (debian 3 based) on some dual athlon
> boxes with no video card. The BIOS does include serial console
> capabilities
> 
> once the system is installed I have no problem booting from the hard
> drive, but when I attempt to boot from a CD to install (ISOLINUX custom
> boot disk) I see the lilo prompt, the loading kernel message, the loading
> initrd.gz message and then it prints 'Ready.' and reboots the same
> bootdisk will work just fine if I install a video card in the machine (and
> the same kernel with lilo boots just fine without a video card after it
> gets installed)
> 
> any ideas why the kernel may crash before printing any messages in this
> situation? I've tried this with 2.4.17 and 2.4.22 with the exact same
> results.
> 
> David Lang
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

David,

Do you have a SERIAL directive in your syslinux.cfg (or ISOLINUX
equivalent) file on the boot CD?

Per the Syslinux readme.doc:


SERIAL port [[baudrate] flowcontrol]

I have been using:

serial 0 38400 0x003

on an embedded system, booting from either a CompactFlash or
DiskOnChip.  

My flowcontrol parm is:

0x001 - Assert DTR + 0x002 - Assert RTS for a NULL modem cable.

The port number corresponds to ports detected by the BIOS.

Bob...
---
Bob Chiodini
Senior Engineer
ASRC Aerospace
M/S ASRC-18
Kennedy Space Center, FL 32899
321-867-6313 (voice)
321-867-6300 (fax)
bob.chiodini@ksc.nasa.gov


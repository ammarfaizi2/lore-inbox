Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267140AbTGTNqV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 09:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267166AbTGTNpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 09:45:34 -0400
Received: from sc-outsmtp1.homechoice.co.uk ([81.1.65.35]:17674 "HELO
	sc-outsmtp1.homechoice.co.uk") by vger.kernel.org with SMTP
	id S267140AbTGTNpc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 09:45:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Fwd: [linuxdc-dev] Problem trying to build 2.6.0-test1
Date: Sun, 20 Jul 2003 15:00:46 +0100
User-Agent: KMail/1.4.3
To: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307201500.46604.adrian@mcmen.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a message I posted to the Dreamcast linux development list. It appears 
to be a problem with the cross assembler (target is SH4, host is ia32) I am 
using but before I put it down to that, I wonder if anybody else has seen 
this and can offer a comment?

It is certainly not a configuration problem as the SH4 maintainer has built 
this kernel for the Dreamcast (he's probably the only one apart from me to 
have even tried :() and when I used his .config it failed in just the same 
way.

Thanks

Adrian

----------  Forwarded Message  ----------

Subject: [linuxdc-dev] Problem trying to build 2.6.0-test1
Date: Sun, 20 Jul 2003 14:25:33 +0100
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: linuxdc-dev@lists.sourceforge.net

Getting this - is this a configuration problem? (Though it seems to occur
whether initrd support is on or off). I'm just using the gcc 3.0.4 I use to
build 2.4 series kernels with.

echo "  .section .init.ramfs,\"a\"" > usr/initramfs_data.S
echo ".incbin \"usr/initramfs_data.cpio.gz\"" >> usr/initramfs_data.S
  AS      usr/initramfs_data.o
usr/initramfs_data.S: Assembler messages:
usr/initramfs_data.S:2: Error: Unknown pseudo-op:  `.incbin'
make[2]: *** [usr/initramfs_data.o] Error 1
make[1]: *** [usr] Error 2
make: *** [vmlinux] Error 2



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Linuxdc-dev mailing list
Linuxdc-dev@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linuxdc-dev

-------------------------------------------------------


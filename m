Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbTB0XB1>; Thu, 27 Feb 2003 18:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267384AbTB0XB1>; Thu, 27 Feb 2003 18:01:27 -0500
Received: from server.strangeGizmo.com ([198.78.66.246]:45068 "HELO
	tre.bloodletting.com") by vger.kernel.org with SMTP
	id <S267383AbTB0XBW>; Thu, 27 Feb 2003 18:01:22 -0500
Message-ID: <118.42.1046387492508@tre.bloodletting.com>
Date: Thu, 27 Feb 2003 15:11:32 -0800
From: Nick Popoff <lkml@tre.bloodletting.com>
Subject: Problem with compact flash as slave device
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm unable to boot Linux if a compact flash disk is present as a slave
device on the same IDE chain as the Linux hard disk.  The kernel boots
from /dev/hda1 as normal, but (incorrectly) attempts to use the CF disk
on /dev/hdb as the root disk.  During the boot sequence both the primary
IDE hard drive and the secondary compact flash disk are detected. 
However, the kernel only displays partition information for the slave
flash disk.  The problem occurs whether the complact flash slave is
blank or DOS partitioned.

I've tried lilo and kernel boot options "root=/dev/hda1" and "hdb=flash"
without success.  The kernel insists on using the CF slave as root if it
is present.

I'm running stock Red Hat 8 with a 2.4.18-24.8.0 kernel on a P3 866Mhz
desktop.  Linux is installed on an IDE hard drive, and an adaptor is
used to connect the compact flash disk as a slave device on the same
chain.  The CF disk is from SilliconTech and uses a standard IDE
interface with no special drivers required.  

This is not as wierd as it sounds!  I'm developing for a PC/104 embedded
system where CF slave disks are useful as field upgradable removable
storage.  This problem is also occuring on our PC/104 SBC.

If I use a DOS, QNX 6, or WinNT hard disk as the primary device instead
of my Linux disk, these systems boot without a problem and are able to
format and access the compact flash slave disk with no errors.

I spent several hours today troubleshooting this and searching Google
for a solution with no luck.  I found several other people discussing
similar problems but no working solutions.  For example:

http://marc.theaimsgroup.com/?l=linux-kernel&m=100446144028502

Any advice would be much appreciated!  Thanks.

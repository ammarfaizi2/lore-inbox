Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbRAYR0e>; Thu, 25 Jan 2001 12:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130887AbRAYR00>; Thu, 25 Jan 2001 12:26:26 -0500
Received: from lochinvar.ece.neu.edu ([129.10.60.161]:45775 "EHLO
	lochinvar.ece.neu.edu") by vger.kernel.org with ESMTP
	id <S130188AbRAYR0U> convert rfc822-to-8bit; Thu, 25 Jan 2001 12:26:20 -0500
Date: Thu, 25 Jan 2001 12:26:12 -0500 (EST)
From: Mauricio Martinez <mmartine@ECE.NEU.EDU>
To: linux-kernel@vger.kernel.org
Subject: Can't umount floppies/zip in Kernel 2.4.0
Message-ID: <Pine.GSO.4.21.0101251212320.14420-100000@bach>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've just upgraded from 2.2.16 to 2.4.0 (after taking care of the upgrades
in the Documentation/Changes file)

I got the following behavior with fdutils (as a non-root user):

---
mixcoac:~> fdmount
fdmount (/dev/fd0): mounted msdos 1440K-disk (read/write) on /fd0

mixcoac:~> fdumount
fdumount (/dev/fd0): failed to unmount: Invalid argument
---

Disk can only be unmounted by root. The mountpoint has the right owner 
(the user) and permissions. Also I've checked /etc/mtab to be ok.

The same occurs to jaZip (an utility to mount/unmount ZIP disks as
non-root user).

If I boot with kernel 2.2.16 everything works ok.

What changed from 2.2 to 2.4? Am I missing something?

---------------------------------------------------------------------------
Mauricio Martínez      Northeastern University    mmartine@ece.neu.edu
                              CDSP Center

...con la espuma de los dias abriré un paréntesis de tiempo ifinitesimal
---------------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

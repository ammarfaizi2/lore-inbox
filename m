Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266696AbRGTHly>; Fri, 20 Jul 2001 03:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266706AbRGTHlo>; Fri, 20 Jul 2001 03:41:44 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:29900 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S266696AbRGTHl2>; Fri, 20 Jul 2001 03:41:28 -0400
Message-ID: <3B57E0AB.F5D6B2E2@idcomm.com>
Date: Fri, 20 Jul 2001 01:41:31 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel-list <linux-kernel@vger.kernel.org>
Subject: bzImage, root device Q
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

When booting to a bzImage kernel, bytes 508 and 509 can be used to name
the minor and major number of the intended root device (although it can
be overridden with a command line parameter). Other characteristics are
also available this way, through bytes in the kernel. rdev makes a
convenient way to hex edit those bytes.

What I'm more curious about is how does the kernel know what filesystem
_type_ the root is? Are there similar bytes in the bzImage, and can rdev
change this? And is there a command line syntax to allow specifying
filesystem type (e.g., something like "vmlinuz root=/dev/scd0,iso9660"
or "vmlinuz root=/dev/scd0,xfs")? Or is this limited in some way,
requiring mount on one or a few known filesystem types ("linux native"
subset comes to mind), followed by a chroot or pivot_root style command
(which in turn means no direct root mount of some filesystem types)?

D. Stimits, stimits@idcomm.com

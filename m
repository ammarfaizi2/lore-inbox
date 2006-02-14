Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbWBNHQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbWBNHQR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 02:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWBNHQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 02:16:17 -0500
Received: from adsl-71-140-189-62.dsl.pltn13.pacbell.net ([71.140.189.62]:1160
	"EHLO aexorsyst.com") by vger.kernel.org with ESMTP
	id S1030467AbWBNHQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 02:16:17 -0500
From: "John Z. Bohach" <jzb@aexorsyst.com>
Reply-To: jzb@aexorsyst.com
To: linux-kernel@vger.kernel.org
Subject: root=/dev/sda1 fails but root=0x0801 works...
Date: Mon, 13 Feb 2006 23:16:15 -0800
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602132316.15992.jzb@aexorsyst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is probably a question with an obvious answer, but I haven't found it
elsewhere, so I hope its okay if I ask here...

As the subject says, if I have my kernel command line with
'...root=/dev/sda1...' then I get

VFS: Cannot open root device "sda1" or unknown-block(0,0)

however, everything else being the same, if I have
'...root=0x0801...', then it works fine.  Note that 

SCSI device sda: 2001888 512-byte hdwr sectors (1025 MB)
sda: Write Protect is off
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0

preceeds this in the console both for the failed case and the succeeding case
(as I already have the rootdelay=10 param. on the command line as well).

I've narrowed this down to another CONFIG_* option, but I can't find which
one in tractable time...

Does anybody know which CONFIG_* option might contribute to text string
root=/dev/sda1 failing while its root=0x0801 cousin works?  I've already tried the
CONFIG_KALLSYMS one, but no luck.  Would this possibly have to do with
CONFIG_NLS=m (et al),  as I have those as modules, and if so, is this intentional?

Thanks,
John


-- 
     ###  Any similarity between my views and the truth is completely ###
     ###  coincidental, except that they are endorsed by NO ONE       ###


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUACLq4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 06:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUACLq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 06:46:56 -0500
Received: from margo.student.utwente.nl ([130.89.169.1]:18154 "EHLO
	margo.student.utwente.nl") by vger.kernel.org with ESMTP
	id S263062AbUACLqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 06:46:55 -0500
Date: Sat, 3 Jan 2004 12:46:49 +0100
To: linux-kernel@vger.kernel.org
Subject: switching to 2.6 on SATA system
Message-ID: <20040103114649.GA31181@margo.student.utwente.nl>
Mail-Followup-To: simon, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Simon Oosthoek <simon@margo.student.utwente.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I'm having a lot of trouble getting a 2.6 kernel up and running on my pc[1].
I have a working 2.4 based install (mandrake 9.2) and I installed a cooker
snapshot with the 2.6 kernel on it as well. the snapshot also uses a 2.4
kernel to boot from.

One problem is that I get a kernel panic ("Bad EIP Value"), but I can solve
that by giving the option "pnpbios=off" to the kernel, so that is not
critical anymore.

The biggest problem is that apparently 2.4 kernels don't see SATA drives as
SCSI and 2.6 kernels do. I believe that lilo on 2.4 puts a root-partition
address in a different format than 2.6 expects, causing it to fail when it
is looking for the init script.

The failure (from memory) comes down to "please specify init= option to the
kernel", but all I could find in the documentation was something about a
linuxrc, which I could not find anywhere on the disk.

I'm wondering if this could be solved by compiling libata in the 2.4 kernel
and thus have 2.4 use the same addressing of the disks? Wouldn't this give
the same bootstrap problem I have with 2.4 and 2.6?

Cheers

Simon  

[1] intel bonanza i875pbz (bios vP18) + P4 + 2xSATA maxtor disks

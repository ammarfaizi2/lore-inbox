Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751915AbWIXL3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbWIXL3o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 07:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbWIXL3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 07:29:44 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:49930 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S1751915AbWIXL3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 07:29:43 -0400
From: James Cloos <cloos@jhcloos.com>
To: linux-kernel@vger.kernel.org
Subject: bzImage too big to boot???
Copyright: Copyright 2006 James Cloos
X-Hashcash: 1:23:060924:linux-kernel@vger.kernel.org::44Q1rp3+U3Ou9IJp:000000000000000000000000000000000CjIb
Date: Sun, 24 Sep 2006 07:29:03 -0400
Message-ID: <m37iztv6y1.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know whether this is a build-time issue or a grub issue, but
I've found that on my (pent-3m) laptop I cannot boot any kernel that
is larger than about 2500 K.  (2504K boots, 2552K fails.)

Past that threshold grub complains:  ERR_BAD_FILETYPE.

A 2504 K bzImage translates to a 6128 K vmlinux, 2552 K to 6252 K.

Should bzImages that large be bootable on x86?

File(1) shows the same output for the larger files as for the smaller
ones, so if it is a bug in the vmlinux -> bzImage build process it is
corrupting the files only beyond the point that file(1) checks.

The laptop's optical drive failed¹, so I cannot test whether syslinux
can boot it.  (Unless there is a way to have grub boot a vfat file-
system image with syslinux and the kernel?)

Any thoughts on where I should look?  Or should I just bug-grub?

-JimC

¹ The old adage that software cannot kill hardware doesn't apply
  when the hardware expects the software to moderate the thermally
  inefficient laser and lacks safeguards for software which doesn't
  know how to keep the laser from overheating and letting all of the
  magic smoke out..... ;-/

-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 0xED7DAEA6

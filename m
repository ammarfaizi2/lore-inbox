Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263261AbTDIMEa (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 08:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263286AbTDIMEa (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 08:04:30 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:15490 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S263261AbTDIME3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 08:04:29 -0400
Date: Wed, 9 Apr 2003 14:16:08 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
To: linux-kernel@vger.kernel.org
Subject: O_DIRECT alignment requirements ?
Message-ID: <20030409141608.A12136@verdi.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I plan to use O_DIRECT in my application (on a partition, no fs).
It is hard to find info on the exact requirements on the mandatory
alignments of buffer, offset, transfer size: it's easy to find many
contradicting documents.  And checking the kernel source itself isn't
trivial.

lseek(int fildes, off_t offset, int whence);
read(int fd, void *buf, size_t count);

My current assumption is this:

	- offset must be block_aligned (multiple of 512)
	- buf must be page_aligned (4096 on IA32)
	- count must be "block_aligned" (multiple of 512)

Is this correct ?

	r.

sysinfo:
--------
- Linux 2.4 (recent versions)
- using raw partion, no files, no fs
- IA32

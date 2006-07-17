Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWGQLBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWGQLBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 07:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWGQLBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 07:01:44 -0400
Received: from neualius.turmzimmer.net ([217.160.169.58]:20669 "EHLO
	neualius.turmzimmer.net") by vger.kernel.org with ESMTP
	id S1750727AbWGQLBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 07:01:44 -0400
Date: Mon, 17 Jul 2006 13:00:56 +0200
From: Andreas Barth <aba@not.so.argh.org>
To: linux-kernel@vger.kernel.org
Subject: gdth SCSI driver(?) fails with more than 4GB of memory
Message-ID: <20060717110056.GG2818@mails.so.argh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please Cc me, I'm currently not subscribed.]

Hi,

I have noticed that one of my boxes stopped to boot correctly after
adding more memory (in total 6 GB) and loading an adjusted kernel for
that.  After some testing around, we noticed that it is enough for the
kernel to boot correctly if we limit the kernel to use 4GB of memory.

If the kernel has 6GB, I directly get error messages like:
SCSI device sda: 143299800 512-byte hdwr sectors (73369 MB)
sda: Write Protect is off
sda: got wrong page
sda: assuming drive cache: write through
SCSI device sda: 143299800 512-byte hdwr sectors (73369 MB)
sda: Write Protect is off
sda: got wrong page

The disk array controller is of type GDT8114RZ and has the most current
firmware version. The box has 4 Xeon CPUs, and physical 6 GB of memory.
The /-device is on the controller in question.

The full log (for 4 and for 6 GB) is put up on
http://neualius.turmzimmer.net/~aba/6GB


Any hints for me how I can use the full 6 GB of memory (and/or what I
should try out to find the bug)?


Cheers,
Andi
-- 
  http://home.arcor.de/andreas-barth/

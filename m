Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbTEFPca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTEFPca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:32:30 -0400
Received: from main.gmane.org ([80.91.224.249]:44483 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263845AbTEFPbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:31:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Peder Stray <peder@ifi.uio.no>
Subject: Files truncate on vfat filesystem
Date: 06 May 2003 17:29:12 +0200
Message-ID: <wa1ade0gkl3.fsf@tyrfing.ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a 250GB usb-storage disk i use to transport large files between
work and home, I uses vfat (since I haven't found any other good
filesystems that don't require me to either be root or have all files
worldreadable). Anyways...

Some files get its size truncated to 0 after a while (usually a few
minuts, or when i umount the disk). They seem to be the correct size
when I do ls -l immediately after i have transfered the files (with cp
or rsync, doesn't really matter). Moving files on the disk with mv also
seems to trigger the problem sometimes.

I see that blocks get allocated, but the filesizes are 0. Currently
there is a difference of 17GB in the output of df and du.

I have also noticed that the size of some directories get truncated too,
thus all files copied or moved into those directories dissappear. ls -l
in those directories doesn't even show . and ..

it seem very inconsistent which files are affected, both in size, length
of filename, unusual characters or depth in the filestructure. No
messages from the kernel logs.

A check of the filesystem from XP reports no errors in the
filestructure, and it work 100% there.

kernel versions used are are amongst 2.4.18 and 2.4.20, selfcompiled or
stock from RH.

More details can of course be supplied if anyone have any ideas what to
check and how.

any comments or help would be much appreciated as the loss of data i
experience is more than a little annyoing.

-- 
  Peder Stray


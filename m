Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVACSNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVACSNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVACSKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:10:03 -0500
Received: from ns.suse.de ([195.135.220.2]:40423 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261560AbVACSHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:07:19 -0500
Date: Mon, 3 Jan 2005 19:07:18 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: pin files in memory after read
Message-ID: <20050103180718.GA22138@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a way to always keep a file (once read from disk) in memory, no
matter how much memory pressure exists?
There are always complains that updatedb and similar tools wipe out all
caches. So I guess there is no such thing yet.

I simply want to avoid the spinup of my ibook harddisk when something
has been 'forgotten' and must be loaded again (like opening a new screen
window after a while).

The best I could do so far was a cramfs image. I copied it to tmpfs
during early boot, then mount -o bind every cramfs file over the real
binary on disk. Of course that will fail as soon as I want to update an
affected package because the binary is busy (readonly). So there must be
a better way to achieve this.

How can one tell the kernel to pin a file in memory once it was read?
Maybe with an xattr or something?
Unfortunately I dont know about the block layer and other things
involved, so I cant attach a patch that does what I want.


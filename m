Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVH3Tqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVH3Tqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVH3Tqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:46:34 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:18641 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932425AbVH3Tqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:46:33 -0400
Date: Tue, 30 Aug 2005 21:46:32 +0200
From: Juergen Quade <quade@hsnr.de>
To: linux-kernel@vger.kernel.org
Subject: inotify and IN_UNMOUNT-events
Message-ID: <20050830194632.GA13346@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:62881f34614f951289f18c8df869d6ac
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Playing around with inotify I have some problems
to generate/receive IN_UNMOUNT-events (using
a self written application and inotify_utils-0.25;
kernel 2.6.13).

Doing:
- mount /dev/hda1 /mnt
- add a watch to the path /mnt/ ("./inotify_test /mnt")
- umount /mnt

results in two events:
1. IN_DELETE_SELF (mask=0x0400)
2. IN_IGNORED     (mask=0x8000)

Any ideas?

         Juergen.

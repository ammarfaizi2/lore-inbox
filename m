Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268937AbUJEKOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268937AbUJEKOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 06:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268980AbUJEKOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 06:14:46 -0400
Received: from math.ut.ee ([193.40.5.125]:21676 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S268978AbUJEKLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 06:11:37 -0400
Date: Tue, 5 Oct 2004 13:11:33 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: lazy umount not working (udev & tmpfs on /dev)
Message-ID: <Pine.GSO.4.44.0410051306400.16512-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm running 2.6.9-rc3+BK (as of yesterday, 20041004) on a couple of
x86 Debian unstable machines with udev and I'm having problems.

In 2.6.3-rc2 all was OK. Don't know exactly about plain -rc3.

In current BK, lazy umount is not working sometimes. udev start script
mounts tmpfs on /dev and stop script does umount -l /dev. This doesn't
return failure but nothing happens, /dev remain mounted and I can't
start udev again. Doing umount -l /dev by hand again finally umounts it
and udev can be started again. Plain umount /dev of course doesn't work
because /dev is busy.

This behaviour is 100% reproducible.

Since 2.6.9-rc2 was OK, I guess this is a bug in current BK?

-- 
Meelis Roos (mroos@linux.ee)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBUO6b>; Wed, 21 Feb 2001 09:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbRBUO6V>; Wed, 21 Feb 2001 09:58:21 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:42780 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129104AbRBUO6N>; Wed, 21 Feb 2001 09:58:13 -0500
Date: Wed, 21 Feb 2001 16:09:07 +0100 (CET)
From: Francis Galiegue <fg@mandrakesoft.com>
To: linux-kernel@vger.kernel.org
cc: alan@redhat.com
Subject: [PATCHES] 3 of them, resubmit, over 2.4.1-ac20
Message-ID: <Pine.LNX.4.21.0102211558460.884-100000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All are as attachments, I've submitted them separately over 2.4.1-ac16, these
are remade over -ac20.

Descriptions:

* ac20-redundant-cpp-directive.patch: in
  arch/i386/kernel/irq.c:irq_affinity_write_proc, there was a redundant #if
  CONFIG_SMP .. #endif directive. This patch removes it.

* ac20-lockdoor-ioctl.patch: in drivers/ide/ide-floppy.c:idefloppy_ioctl,
  this patch adds the CDROM_LOCKDOOR ioctl. Based on drivers/cdrom/cdrom.c for
  policy about said ioctl for drive usage stuff.

* ac20-spurious-assignment.patch: in mm/vmalloc.c:vmalloc_area_pages, ret is
  set twice to -ENOMEM whereas once would be enough. What's more, the loop in
  which this spurious assignment appears runs with the kernel lock held. This
  patch fixes this.

Have fun,
-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVBPQzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVBPQzu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 11:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVBPQzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 11:55:50 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:8688 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262077AbVBPQzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 11:55:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XiFVlCZEW5e0GTmsdsIt564cgVP2qTQw/eR8oZntiwciFFQ6KuSZLW0lUHX6Ud3oOnmMue9PrQdEJ1Thdwji4I+Y61vkKO990nI7qxpPhXnDihCIQdn2uZ9h4o8SvuFZyJ+NSmthNGlGVsZyaYA9mbsC/Ng6mFrANRfs9OrcwFM=
Message-ID: <712fce105021608557a1f0b6e@mail.gmail.com>
Date: Wed, 16 Feb 2005 08:55:45 -0800
From: Martin Bogomolni <martinbogo@gmail.com>
Reply-To: Martin Bogomolni <martinbogo@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: NTFS - Kernel memory leak in driver for kernel 2.4.28 (update)
In-Reply-To: <712fce1050216082847bec092@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <712fce1050216082847bec092@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the inode_cache is quite high.   No matter what I do to
the tunable system parameters in /proc (below) I can't get the amount
of memory taken by the inode cache to reduce and become freed for
userspace programs.

/proc/sys/vm/vm_mapped_ratio   ( tried 20 - 100 )
/proc/sys/vm/vm_vfs_scan_ratio  ( tried 2 - 6 )

How often does the dcache/icache shrinking take place in 2.4?

On vfat/fat32, ext2/3 filesystems I don't see anywhere near the amount
of lost memory than when using the NTFS filesystem.  This is what led
me to think that the NTFS driver was leaking, rather than this being
an inode cache problem.

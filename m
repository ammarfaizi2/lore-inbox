Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbTBCN7A>; Mon, 3 Feb 2003 08:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbTBCN7A>; Mon, 3 Feb 2003 08:59:00 -0500
Received: from jaguar.mkp.net ([66.11.169.42]:56754 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id <S266323AbTBCN67>;
	Mon, 3 Feb 2003 08:58:59 -0500
To: Bryan Andersen <bryan@bogonomicon.net>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Compactflash cards dying?
From: "Martin K. Petersen" <mkp@mkp.net>
Organization: mkp.net
References: <20030202223009.GA344@elf.ucw.cz>
	<3E3E1643.2080807@bogonomicon.net>
Date: 03 Feb 2003 09:08:49 -0500
In-Reply-To: <3E3E1643.2080807@bogonomicon.net>
Message-ID: <yq1isw1qwwe.fsf@austin.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bryan" == Bryan Andersen <bryan@bogonomicon.net> writes:

Bryan> Use a file system that is designed for use on FLASH devices.
Bryan> In general FLASH devices are not very useable for systems that
Bryan> need to modify data on the disk often.

Just a heads up that flash (as in MTD) != Compact Flash.

For all practical purposes a Compact Flash is an IDE disk (Or a an IDE
controller with a disk behind it.  Depends how you wire it).

Internally, the Compact Flash does all the wear averaging that a flash
filesystem like jffs2 provides.  Transparently to the application.

All Linux sees is a linear stream of bytes.  Just like a disk.  And it
should be treated as such.


Bryan> You may wish to look at the virtual memory file system
Bryan> available in the kernel if you have enough RAM.  You would
Bryan> mount your CompactFlash device read only and have all updates
Bryan> go to the virtual memory filesystem. When you want to commit
Bryan> the changes, remount the CompactFlash read/write and save the
Bryan> changes then remount it read only.

tmpfs to the rescue!


Bryan> You would be surprised how fast a million writes can happen on
Bryan> a disk.

Yup.

You would also be surprised how long it takes to actually *perform* a
million writes on a slow piece of media like Compact Flash ;)

-- 
Martin K. Petersen	Wild Open Source, Inc.
mkp@wildopensource.com	http://www.wildopensource.com/

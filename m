Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVGFUTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVGFUTt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVGFUM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:12:28 -0400
Received: from ns1.suse.de ([195.135.220.2]:58004 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262216AbVGFTmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:42:04 -0400
Date: Wed, 6 Jul 2005 21:42:02 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: move KERNEL_VERSION define, changing CONFIG_LOCALVERSION rebuilds too many files
Message-ID: <20050706194202.GA12792@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing the CONFIG_LOCALVERSION string will trigger a rebuild of way
too many files, for no good reason. Looking over 2.6.13-rc2, almost no
#include <linux/version.h> is valid.

a few drivers need the KERNEL_VERSION macro to define their own version.
Unfortunately, this macro is in linux/version.h.
Where should I move/copy this simple macro? uts.h, utsname.h, kernel.h?

example users:

include/media/saa7146.h
drivers/media/video/bttvp.h
drivers/media/video/cx88/cx88.h
drivers/media/video/saa7134/saa7134.h
drivers/video/matrox/matroxfb_base.c



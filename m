Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVGJTfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVGJTfL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVGJTfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:35:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:22492 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261164AbVGJTfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:09 -0400
Date: Sun, 10 Jul 2005 19:35:08 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/82] changing CONFIG_LOCALVERSION rebuilds too much, for no good reason.
Message-ID: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following series of patches removes almost all inclusions
of linux/version.h. The 3 #defines are unused in most of the touched files.

A few drivers use the simple KERNEL_VERSION(a,b,c) macro, which is unfortunatly
in linux/version.h. This define moved to linux/utsname.h

There are also lots of #ifdef for long obsolete kernels, this will go as well.


quilt vi `find * -type f -name "*.[ch]"|xargs grep -El '(UTS_RELEASE|LINUX_VERSION_CODE|KERNEL_VERSION|linux/version.h)'|grep -Ev '(/(boot|coda|drm)/|~$)'`

search pattern:
/UTS_RELEASE|LINUX_VERSION_CODE|KERNEL_VERSION|linux/(utsname|version).h

PS: I hope my script is working ok.

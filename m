Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932793AbVJ3Cfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbVJ3Cfh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 22:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932803AbVJ3Cfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 22:35:36 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:9707 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932793AbVJ3Cfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 22:35:36 -0400
Date: Sun, 30 Oct 2005 03:35:57 +0100
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: BIND hangs with 2.6.14
Message-ID: <20051030023557.GA7798@uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux 2.6.14-rc5 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.8 (--)
X-Spam-Report: Status=No hits=-2.8 required=5.0 tests=ALL_TRUSTED version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please Cc me on any replies, I'm not subscribed]

Hi,

We upgraded one of our servers (single Opteron, running 64-bit kernel but
32-bit userland) from 2.6.11.9 to 2.6.14 (with the additional NFS patches,
but that shouldn't really matter) today, and now BIND seems to hang every few
hours. (Everything on the machine except for the kernel is Debian sarge, so
we're using BIND 9.2.4 and glibc 2.3.2, with NPTL.) I'm unsure what's really
happening, but it doesn't respond to any requests at all, a plain strace on
the process gives nothing, ltrace gives nothing, and it doesn't use any CPU.

gdb shows four threads, one of them in sigsuspend, another in select, a third
in __JCR_LIST__ and the fourth just showing garbage. I'm sorry I can't be
more specific here -- I can't find a reliable way to provoke it into this
hanging behaviour, but I've got an strace running now to at least have _some_
tracking information when it goes awry.

Does anybody have a clue as of what might break it in this way? I've skimmed
the changelogs, but couldn't find anything obvious.

/* Steinar */
-- 
Homepage: http://www.sesse.net/

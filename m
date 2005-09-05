Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVIEHS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVIEHS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 03:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVIEHS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 03:18:59 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:28397 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S932267AbVIEHS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 03:18:58 -0400
Message-ID: <431BF0FF.6050402@cs.aau.dk>
Date: Mon, 05 Sep 2005 09:17:19 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [2.6.13+swsusp2] iounmap Oops
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a Debian unstable (Xorg) and recently (since I installed the
2.6.13) I've noticed a new message in /var/log/kern/log:

Sep  5 08:39:21 hermes vmunix: iounmap: bad address d72f2000
Sep  5 08:39:21 hermes vmunix:  [<c010e245>] iounmap+0xc5/0xd0
Sep  5 08:39:21 hermes vmunix:  [<c015161b>] page_remove_rmap+0x3b/0x60
Sep  5 08:39:21 hermes vmunix:  [<c020c9e8>]
radeon_do_cleanup_cp+0x348/0x410
Sep  5 08:39:21 hermes vmunix:  [<c020cef5>] radeon_do_release+0xa5/0x120
Sep  5 08:39:21 hermes vmunix:  [<c020493a>] drm_takedown+0x2a/0x4f0
Sep  5 08:39:21 hermes vmunix:  [<c0205d38>] drm_fasync+0x48/0xa0
Sep  5 08:39:21 hermes vmunix:  [<c02059d2>] drm_release+0x3f2/0x4d0
Sep  5 08:39:21 hermes vmunix:  [<c015bec1>] __fput+0xa1/0x170
Sep  5 08:39:21 hermes vmunix:  [<c015a452>] filp_close+0x52/0x90
Sep  5 08:39:21 hermes vmunix:  [<c015a4e8>] sys_close+0x58/0x60
Sep  5 08:39:21 hermes vmunix:  [<c0102dc5>] syscall_call+0x7/0xb

Seems to be linked to the DRM of the Radeon driver, but I ain't no
expert. If wanted I can dig a bit more.

Regards
-- 
Emmanuel Fleury

Assistant Professor          | Office: B1-201
Computer Science Department, | Phone:  +45 96 35 72 23
Aalborg University,          | Mobile: +45 26 22 98 03
Fredriks Bajersvej 7E,       | E-mail: fleury@cs.aau.dk
9220 Aalborg East, Denmark   | URL: www.cs.aau.dk/~fleury

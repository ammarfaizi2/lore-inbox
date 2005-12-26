Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVLZWU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVLZWU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 17:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVLZWU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 17:20:29 -0500
Received: from 83-103-88-29.ip.fastwebnet.it ([83.103.88.29]:43954 "EHLO
	maruska.gotadns.org") by vger.kernel.org with ESMTP
	id S1750735AbVLZWU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 17:20:29 -0500
To: linux-kernel@vger.kernel.org
Cc: george@mvista.com
Subject: [PATCH 2.6.15-rc7] clocks: export symbol
 do_posix_clock_monotonic_gettime
X-Archive: encrypt
From: mmc@maruska.dyndns.org (Michal =?iso-8859-2?q?Maru=B9ka?=)
Date: Mon, 26 Dec 2005 23:20:22 +0100
Message-ID: <m264pbo5zt.fsf@linux11.maruska.tin.it>
User-Agent: Gnus/5.090024 (Oort Gnus v0.24) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Getting access to monotonic time from modules is indispensable, for instance,
for modular evdev to timestamp input events with a useful time information.

(I have already provided patch for evdev (also this one) in my previous,
unanswered, post http://lkml.org/lkml/2005/10/6/92 )


Signed-off-by: Michal Maruska <mmc@maruska.dyndns.org> 


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=posix-timers.c.patch

--- linux-2.6.15-rc7/kernel/posix-timers.c	2005-12-26 13:01:54.000000000 +0100
+++ linux-2.6.15-rc7.mmc/kernel/posix-timers.c	2005-12-26 22:59:11.883817855 +0100
@@ -1219,6 +1219,7 @@ int do_posix_clock_monotonic_gettime(str
 {
 	return do_posix_clock_monotonic_get(CLOCK_MONOTONIC, tp);
 }
+EXPORT_SYMBOL_GPL(do_posix_clock_monotonic_gettime);
 
 int do_posix_clock_nosettime(clockid_t clockid, struct timespec *tp)
 {

--=-=-=--

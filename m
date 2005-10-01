Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVJAPEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVJAPEA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 11:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVJAPEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 11:04:00 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:39552 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S1750720AbVJAPD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 11:03:59 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] missing ifdef in mod_devicetable.h for 2.6.14-rc3
Date: Sat, 01 Oct 2005 08:03:58 -0700
Message-ID: <873bnlb7oh.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this was introduced in rc1 and is still present in rc3. without the
patch below i can't compile alsa cvs.

--- a/include/linux/mod_devicetable.h	2005-09-13 13:49:17.000000000 -0700
+++ b/include/linux/mod_devicetable.h	2005-09-13 13:49:43.000000000 -0700
@@ -183,7 +183,7 @@
 	char	name[32];
 	char	type[32];
 	char	compatible[128];
-#if __KERNEL__
+#ifdef __KERNEL__
 	void	*data;
 #else
 	kernel_ulong_t data;

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |

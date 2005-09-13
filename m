Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVIMUWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVIMUWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVIMUWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:22:40 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:13968 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S932239AbVIMUWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:22:39 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: linux-kernel@vger.kernel.org
Subject: type in include/linux/mod_devicetable.h?
Date: Tue, 13 Sep 2005 13:22:37 -0700
Message-ID: <87irx4sooi.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there seems to be a small typo in the above mentioned file (or at
least by gcc (GCC) 4.0.2 20050821 (prerelease) (Debian 4.0.1-6)
doesn't like it). this patch fixes it for me:

--- mod_devicetable.h-orig      2005-09-13 13:15:41.000000000 -0700
+++ mod_devicetable.h   2005-09-13 13:15:54.000000000 -0700
@@ -183,7 +183,7 @@
        char    name[32];
        char    type[32];
        char    compatible[128];
-#if __KERNEL__
+#ifdef __KERNEL__
        void    *data;
 #else
        kernel_ulong_t data;

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |

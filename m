Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVIXS3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVIXS3V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 14:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVIXS3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 14:29:21 -0400
Received: from quark.didntduck.org ([69.55.226.66]:48364 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932224AbVIXS3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 14:29:20 -0400
Message-ID: <43359AEA.3070809@didntduck.org>
Date: Sat, 24 Sep 2005 14:28:58 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove redundant configs.o
Content-Type: multipart/mixed;
 boundary="------------020904030502040801070900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020904030502040801070900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Since CONFIG_IKCONFIG_PROC already depends on CONFIG_IKCONFIG, adding
configs.o again is redundant.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

--------------020904030502040801070900
Content-Type: text/plain;
 name="0001-Remove-redundant-configs.o.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Remove-redundant-configs.o.txt"

Subject: [PATCH] Remove redundant configs.o

Since CONFIG_IKCONFIG_PROC already depends on CONFIG_IKCONFIG, adding
configs.o again is redundant.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---

 kernel/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

1857d6be3556227c129b70b4a6a75b6122ca3149
diff --git a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -22,7 +22,6 @@ obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_IKCONFIG) += configs.o
-obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o

--------------020904030502040801070900--

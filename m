Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUHVAOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUHVAOL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 20:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUHVAOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 20:14:11 -0400
Received: from host-64-71-93-144.dhcp.milfordcable.net ([64.71.93.144]:38016
	"EHLO windeath.2y.net") by vger.kernel.org with ESMTP
	id S262279AbUHVAOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 20:14:09 -0400
Message-ID: <4127E570.7040501@windeath.2y.net>
Date: Sat, 21 Aug 2004 19:14:40 -0500
From: "James M." <dart@windeath.2y.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040803)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Obvious one-liner - Use 3DNOW on MK8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Title says it...my Athlon 64 definitely uses 3DNOW. Patch changes 
arch/i386/Kconfig and has a 3 line fudge factor(I created it a few 
kernels back). Might want to check other arches for the same bug.

Dart

--- current/arch/i386/Kconfig.orig      2004-03-12 22:44:10.000000000 -0600
+++ current/arch/i386/Kconfig   2004-03-12 22:44:53.000000000 -0600
@@ -413,7 +413,7 @@ config X86_USE_PPRO_CHECKSUM

  config X86_USE_3DNOW
         bool
-       depends on MCYRIXIII || MK7
+       depends on MCYRIXIII || MK7 || MK8
         default y

  config X86_OOSTORE

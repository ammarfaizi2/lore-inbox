Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUEFRjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUEFRjx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUEFRjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:39:53 -0400
Received: from math.ut.ee ([193.40.5.125]:14062 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261597AbUEFRjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:39:51 -0400
Date: Thu, 6 May 2004 20:38:52 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Clay Haapala <chaapala@cisco.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: CRC32c warning on sparc64
Message-ID: <Pine.GSO.4.44.0405061921290.21792-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.6-rc3+BK as of today on a sparc64 (gcc 3.3.3 on Debian):

  CC [M]  crypto/crc32c.o
crypto/crc32c.c:89: warning: initialization from incompatible pointer type

This is because chksum_update uses size_t (64-bit unsigned long on
sparc64) length argument but dia_update seems to want unsigned int as
the type of length.

What is the right fix - change the length in chksum_update() and
crc32c() to unsigned int?

-- 
Meelis Roos (mroos@linux.ee)





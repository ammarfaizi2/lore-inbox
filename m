Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263928AbUFQWYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUFQWYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 18:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbUFQWYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 18:24:10 -0400
Received: from pop.gmx.de ([213.165.64.20]:58853 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263928AbUFQWYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 18:24:07 -0400
X-Authenticated: #20450766
Date: Fri, 18 Jun 2004 00:23:25 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: space left on ext3 (2.6.6-bk3)
Message-ID: <Pine.LNX.4.60.0406180018530.9599@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a ext3 fs:

fast:/mnt/tmp# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda3               958488    521864    387936  58% /mnt

fast:/mnt/tmp# cat /dev/zero > zr
cat: write error: No space left on device

fast:/mnt/tmp# ls -l
total 436624
-rw-r--r--    1 root     root     446660608 Jun 18 00:23 zr

fast:/mnt/tmp# rm zr

fast:/mnt/tmp# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda3               958488    521864    387936  58% /mnt

Is this an expected behaviour?.. Yeah, it is nice to have more space than 
you think you have, but...

Thanks
Guennadi
---
Guennadi Liakhovetski


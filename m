Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266395AbUA3DXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 22:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266416AbUA3DXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 22:23:11 -0500
Received: from trantor.dso.org.sg ([192.190.204.1]:34240 "EHLO
	trantor.dso.org.sg") by vger.kernel.org with ESMTP id S266395AbUA3DXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 22:23:09 -0500
Message-ID: <4019CDBC.3060900@starhub.net.sg>
Date: Fri, 30 Jan 2004 11:21:32 +0800
From: R CHAN <rspchan@starhub.net.sg>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch pentium3,4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.2-rc2 sha256.c is miscompiled with gcc 3.2.3.
(User space is RedHat 3ES.)

Just an observation:

gcc 3.2.3 is miscompiling sha256.c when using
-O2 -march=pentium3
or pentium4.

gcc 3.3.x is ok, or the problem disappears
if I use arch=i686 or reduce the optimisation level to -O2.

Sympthoms are all the sha256 test vectors fail.
If I extract the guts of the file to compile in user space
the same problem occurs.

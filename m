Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVEYLO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVEYLO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 07:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVEYLO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 07:14:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:62916 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262150AbVEYLO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 07:14:56 -0400
X-Authenticated: #26515711
Message-ID: <429492A0.2040407@gmx.de>
Date: Wed, 25 May 2005 16:58:40 +0200
From: Oliver Korpilla <Oliver.Korpilla@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [x86-64][Patch]Build bug in 2.6.12-rc5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:

On x86_64 building of 2.6.12-rc5 stops with a missing definition in
arch/x86_64/kernel/signal.c

Solution:

Include necessary define (see patch below).

I'm not on the list, CC: me if necessary.

With kind regards,
Oliver Korpilla

--- linux-2.6.12-rc5_2/arch/x86_64/kernel/signal.c      2005-05-25
05:31:20.000000000 +0200
+++ linux-2.6.12-rc5/arch/x86_64/kernel/signal.c        2005-05-25
16:35:24.000000000 +0200
@@ -28,6 +28,7 @@
 #include <asm/uaccess.h>
 #include <asm/i387.h>
 #include <asm/proto.h>
+#include <asm/ia32_unistd.h>

 /* #define DEBUG_SIG 1 */


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130705AbRCMG5x>; Tue, 13 Mar 2001 01:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130949AbRCMG5m>; Tue, 13 Mar 2001 01:57:42 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:7184 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130705AbRCMG53>; Tue, 13 Mar 2001 01:57:29 -0500
Message-Id: <200103130656.HAA27068@fire.malware.de>
Date: Tue, 13 Mar 2001 07:56:34 +0100
From: malware@t-online.de (Michael Mueller)
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.4.0-ac1 i586)
X-Accept-Language: de, en
MIME-Version: 1.0
To: alan@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Using I2O modules with I2O core in kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan and folks,


I got asked why it gives unresolved symbols (and how to fix it) for the
I2O modules. During the session I noticed this is due to the fact the
I2O core is built into the kernel but the other I2O support built as
module. So the quick hack to resolv that problem was adding the missing
symbols into ksyms.c.

Later on I noticed its possible to avoid this hacking simple by doing
the EXPORT_SYMBOL within the original source module. This was only done
for the case it would have been compiled as kernel module. The patch is
appended.


Michael

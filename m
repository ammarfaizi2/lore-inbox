Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130440AbQLaXJL>; Sun, 31 Dec 2000 18:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130508AbQLaXJB>; Sun, 31 Dec 2000 18:09:01 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:2944 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S130468AbQLaXIr>;
	Sun, 31 Dec 2000 18:08:47 -0500
Message-ID: <3A4FB558.688EFE01@pobox.com>
Date: Sun, 31 Dec 2000 14:38:16 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.0-prerelease
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good here in most respects, but still needs makefile fixes -

# modprobe tdfx
/lib/modules/2.4.0-prerelease/kernel/drivers/char/drm/tdfx.o: unresolved
symbol remap_page_range
/lib/modules/2.4.0-prerelease/kernel/drivers/char/drm/tdfx.o: unresolved
symbol __wake_up
/lib/modules/2.4.0-prerelease/kernel/drivers/char/drm/tdfx.o: unresolved
symbol mtrr_add
.... etc, etc

Of course, adding

#include <linux/modversions.h>

to drivers/char/drm/drmP.h makes it all work....

jjs



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

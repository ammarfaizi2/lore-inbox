Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbUL3UIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbUL3UIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 15:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUL3UIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 15:08:01 -0500
Received: from taelon.ucomm.wayne.edu ([141.217.10.108]:60892 "EHLO
	taelon.ucomm.wayne.edu") by vger.kernel.org with ESMTP
	id S261708AbUL3UHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 15:07:52 -0500
From: Richard McCreedy <rick@mccreedy.us>
Reply-To: rick@mccreedy.us
To: linux-kernel@vger.kernel.org
Subject: Compile error in 2.6.10-bk3 in floppy.c
Date: Thu, 30 Dec 2004 15:07:50 -0500
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412301507.50980.rick@mccreedy.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following error building 2.6.10-bk3:

drivers/block/floppy.c: In function `init_module':
drivers/block/floppy.c:4598: error: syntax error before "UTS_RELEASE"
make[2]: *** [drivers/block/floppy.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2

-bk3 (and -bk2) have a patch that removes 
#include <linux/version.h>
from floppy.c, which apparently makes UTS_RELEASE undefined.

Putting the #include back in fixes the error.

I can provide config/machine info if needed.

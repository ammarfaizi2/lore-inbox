Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbUL2RPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbUL2RPn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 12:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUL2RPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 12:15:42 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:62251 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261371AbUL2RPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 12:15:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=jc2KKohBf6ysTPtmaHlPa7p/wYFjcGzB30fozv/VbKZI2e016ND0Rk+75gar1PR3bTgjOw5xfmBiFJqD/yqrSKrWQtXOig60wvEnBAoDAMatgQG5UPBg4LVujdMgku/mw8jrr3GAncfnOQDimf3PrErSzNh5O5zVoF4oSCuNYqg=
Message-ID: <41D2E631.9000004@gmail.com>
Date: Wed, 29 Dec 2004 18:15:29 +0100
From: Mateusz Berezecki <mateuszb@gmail.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: drivers/block/floppy.c parse error and proposed patch
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

I just did bk pull and encountered following error during compilation time

  CC [M]  drivers/block/floppy.o
drivers/block/floppy.c: In function `init_module':
drivers/block/floppy.c:4598: error: parse error before "UTS_RELEASE"
make[2]: *** [drivers/block/floppy.o] Error 1

and here is the proposed patch just in case it hasn't been already fixed

--- linux-2.5/drivers/block/floppy.c    2004-12-29 18:10:40.000000000 +0100
+++ linux-2.5/drivers/block/floppy.c    2004-12-29 18:08:25.000000000 +0100
@@ -158,6 +158,7 @@
 #define FDPATCHES
 #include <linux/fdreg.h>

+#include <linux/version.h>
 /*
  * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
  */


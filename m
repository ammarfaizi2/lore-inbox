Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWDJKRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWDJKRD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWDJKRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:17:03 -0400
Received: from nproxy.gmail.com ([64.233.182.189]:54371 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751113AbWDJKRC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:17:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nPMPiLWRCwrXXMUb3IUbNjm8k/4GBfII+gEYoU82enKeT3E1maQ4aeLGifM6+YSuivIXDiw39QhmD/lxuo+UMEeK6kM23hSqWX3EV8Ya+CtRtxx0rc1n6Tguvu2YpP+PD+sPR5nKDfCZUc4x6GFWz+R6JBAQVOi0r/SlaCk5EKU=
Message-ID: <6d6a94c50604100316j43bcc32p6fa781c0ce47182d@mail.gmail.com>
Date: Mon, 10 Apr 2006 18:16:56 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: The assemble file under the driver folder can not be recognized when the driver is built as module
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've written a framebuffer driver and put it under the folder
"./drivers/video", it consists of two files" mydriver.c and myfun.S".
When I build it into the kernel image, everything is ok.
But when I build it as module, I got the following error message:
===========================================
aubrey@linux:~/cvs/kernel/uClinux-dist> make V=1
--------snip---------
make -f scripts/Makefile.build obj=drivers/video
make -f scripts/Makefile.build obj=drivers/video/backlight
make[3]: *** No rule to make target `drivers/video/rgb2ycbcr.c',
needed by `drivers/video/rgb2ycbcr.o'.  Stop.
make[2]: *** [drivers/video] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/home/aubrey/cvs/kernel/uClinux-dist/linux-2.6.x'
make: *** [linux] Error 1
===========================================

Make ask me for ".c" file. But it's an assemble file indeed.
Is it a bug of kernel script? (I'm using 2.6.16)

Regards,
-Aubrey

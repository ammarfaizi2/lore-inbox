Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291388AbSBHDRz>; Thu, 7 Feb 2002 22:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291387AbSBHDRp>; Thu, 7 Feb 2002 22:17:45 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:61154 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S291386AbSBHDR2>; Thu, 7 Feb 2002 22:17:28 -0500
Message-ID: <3C634346.1010405@nyc.rr.com>
Date: Thu, 07 Feb 2002 22:17:26 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux 2.5.4-pre3 and IDE changes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The address member of struct scatterlist appears to have been changed to 
dma_address.

A simple s/\.address/\.dma_address/ should fix this compile error.

ide-dma.c: In function `ide_raw_build_sglist':
ide-dma.c:269: structure has no member named `address'
ide-dma.c:276: structure has no member named `address'
make[3]: *** [ide-dma.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.4/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.4/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.4/drivers'
make: *** [_dir_drivers] Error 2


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSDBLqy>; Tue, 2 Apr 2002 06:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311424AbSDBLqo>; Tue, 2 Apr 2002 06:46:44 -0500
Received: from lego.zianet.com ([204.134.124.54]:50696 "EHLO lego.zianet.com")
	by vger.kernel.org with ESMTP id <S293203AbSDBLq2>;
	Tue, 2 Apr 2002 06:46:28 -0500
Message-ID: <3CA995A8.1080604@zianet.com>
Date: Tue, 02 Apr 2002 04:27:36 -0700
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020329
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo@conectiva.com.br
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Small cosmetic fix for agpgart
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I didn't see any maintainer listed for agpgart, should this be
jhartmann@precisioninsight.com?

Anyway, just a cosmetic fix that always bugged me.  
The AMD 760 MP chipset was identified twice as AMD
like so:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected AMD AMD 760MP chipset
                              ^^^^^^^^^^

This tiny patch will fix it so it appears as:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected AMD 760MP chipset

Patch is against 2.4.18.

Thanks,
Steven Spence


--- agpgart_be_original.c       Tue Apr  2 03:38:39 2002
+++ agpgart_be.c        Tue Apr  2 03:39:08 2002
@@ -3597,7 +3597,7 @@
                PCI_VENDOR_ID_AMD,
                AMD_IRONGATE,
                "AMD",
-               "AMD 760MP",
+               "760MP",
                amd_irongate_setup },
        { PCI_DEVICE_ID_AMD_761_0,
                PCI_VENDOR_ID_AMD,
@@ -3609,7 +3609,7 @@
                PCI_VENDOR_ID_AMD,
                AMD_762,
                "AMD",
-               "AMD 760MP",
+               "760MP",
                amd_irongate_setup },
        { 0,
                PCI_VENDOR_ID_AMD,





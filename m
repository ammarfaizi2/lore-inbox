Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288557AbSBZXhL>; Tue, 26 Feb 2002 18:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289046AbSBZXhB>; Tue, 26 Feb 2002 18:37:01 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:42237 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S289026AbSBZXgy>; Tue, 26 Feb 2002 18:36:54 -0500
Message-ID: <3C7C1AF0.3000103@drugphish.ch>
Date: Wed, 27 Feb 2002 00:32:00 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj2
In-Reply-To: <20020226223406.A26905@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Patch against 2.5.5 vanilla is available from:
> ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/
> 
> By popular request, the curious can now find most of what
> was merged in each release at http://www.codemonkey.org.uk/patches/merged/

Thanks for your excellent work.

There is a slight problem with your -dj2 patch with following chunk:

diff -urN --exclude-from=/home/davej/.exclude 
linux-2.5.5/include/linux/version.h linux-2.5/include/linux/version.h
--- linux-2.5.5/include/linux/version.h	Thu Feb 21 17:42:30 2002
+++ linux-2.5/include/linux/version.h	Thu Jan  1 00:00:00 1970
@@ -1,3 +0,0 @@
-#define UTS_RELEASE "2.5.5"
-#define LINUX_VERSION_CODE 132357
-#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))

make distclean removes ../include/linux/version.h and thus your patch 
doesn't apply cleanly on a fresh 2.5.5 tree.

Best regards,
Roberto Nibali, ratz


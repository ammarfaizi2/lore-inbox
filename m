Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269641AbUJGOK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269641AbUJGOK5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbUJGOK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:10:57 -0400
Received: from mail6.hitachi.co.jp ([133.145.228.41]:19172 "EHLO
	mail6.hitachi.co.jp") by vger.kernel.org with ESMTP id S269641AbUJGOK0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:10:26 -0400
Message-ID: <41654E60.40603@sdl.hitachi.co.jp>
Date: Thu, 07 Oct 2004 23:10:40 +0900
From: Hideo AOKI <aoki@sdl.hitachi.co.jp>
Organization: Systems Development Lab., Hitachi, Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ak@muc.de, linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: [PATCH 2.6]  Documentation/filesystems/proc.txt
References: <2LXI2-3a5-21@gated-at.bofh.it>	<m3ekkd46a8.fsf@averell.firstfloor.org>	<4163E2C0.5050109@sdl.hitachi.co.jp> <20041006155000.46c9acdc.akpm@osdl.org> <416549CE.2070202@sdl.hitachi.co.jp>
In-Reply-To: <416549CE.2070202@sdl.hitachi.co.jp>
Content-Type: multipart/mixed;
 boundary="------------020602070309090800020200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020602070309090800020200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hideo AOKI wrote:

> Andrew Morton wrote:
> 
>> Please send an additional patch to update 
>> Documentation/filesystems/proc.txt
>> and Documentation/sysctl/vm.txt
> 
> Certainly.
> 
> Attached patch is a short description for /proc/sys/vm/swap_token_timeout.

By the way, in Documentation/filesystems/proc.txt, explanation of
/proc/meminfo is described in section 1.3 (IDE devices in /proc/ide).
I think that it should be described in section 1.2 (Kernel data).

Attached patch fixes it. This patch has to be applied after my previous patch is applied.

Kind regards,

Hideo AOKI

Systems Development Laboratory, Hitachi, Ltd.

--------------020602070309090800020200
Content-Type: text/plain;
 name="doc-fs-proc-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="doc-fs-proc-fix.patch"

 proc.txt |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

Signed-off-by: Hideo Aoki <aoki@sdl.hitachi.co.jp>

diff -uprN linux-2.6.9-rc3-vm-tuning-doc/Documentation/filesystems/proc.txt linux-2.6.9-rc3-doc-fs-proc-fix/Documentation/filesystems/proc.txt
--- linux-2.6.9-rc3-vm-tuning-doc/Documentation/filesystems/proc.txt	2004-10-07 21:31:37.000000000 +0900
+++ linux-2.6.9-rc3-doc-fs-proc-fix/Documentation/filesystems/proc.txt	2004-10-07 22:05:46.847650632 +0900
@@ -350,22 +350,6 @@ available.  In this case, there are 0 ch
 ZONE_DMA, 4 chunks of 2^1*PAGE_SIZE in ZONE_DMA, 101 chunks of 2^4*PAGE_SIZE 
 available in ZONE_NORMAL, etc... 
 
-
-1.3 IDE devices in /proc/ide
-----------------------------
-
-The subdirectory /proc/ide contains information about all IDE devices of which
-the kernel  is  aware.  There is one subdirectory for each IDE controller, the
-file drivers  and a link for each IDE device, pointing to the device directory
-in the controller specific subtree.
-
-The file  drivers  contains general information about the drivers used for the
-IDE devices:
-
-  > cat /proc/ide/drivers 
-  ide-cdrom version 4.53 
-  ide-disk version 1.08 
-
 ..............................................................................
 
 meminfo:
@@ -454,6 +438,22 @@ VmallocTotal: total size of vmalloc memo
  VmallocUsed: amount of vmalloc area which is used
 VmallocChunk: largest contigious block of vmalloc area which is free
 
+
+1.3 IDE devices in /proc/ide
+----------------------------
+
+The subdirectory /proc/ide contains information about all IDE devices of which
+the kernel  is  aware.  There is one subdirectory for each IDE controller, the
+file drivers  and a link for each IDE device, pointing to the device directory
+in the controller specific subtree.
+
+The file  drivers  contains general information about the drivers used for the
+IDE devices:
+
+  > cat /proc/ide/drivers 
+  ide-cdrom version 4.53 
+  ide-disk version 1.08 
+
 More detailed  information  can  be  found  in  the  controller  specific
 subdirectories. These  are  named  ide0,  ide1  and  so  on.  Each  of  these
 directories contains the files shown in table 1-4.

--------------020602070309090800020200--


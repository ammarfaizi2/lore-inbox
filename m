Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269508AbUJGNux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269508AbUJGNux (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269629AbUJGNuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 09:50:52 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:52142 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S269508AbUJGNus
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 09:50:48 -0400
Message-ID: <416549CE.2070202@sdl.hitachi.co.jp>
Date: Thu, 07 Oct 2004 22:51:10 +0900
From: Hideo AOKI <aoki@sdl.hitachi.co.jp>
Organization: Systems Development Lab., Hitachi, Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: [PATCH 2.6]  vm-thrashing-control-tuning
References: <2LXI2-3a5-21@gated-at.bofh.it>	<m3ekkd46a8.fsf@averell.firstfloor.org>	<4163E2C0.5050109@sdl.hitachi.co.jp> <20041006155000.46c9acdc.akpm@osdl.org>
In-Reply-To: <20041006155000.46c9acdc.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------070701080400050500090600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070701080400050500090600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>>[vm-thrashing-control-tuning.patch  text/plain (3256 bytes)]
> 
> Please send an additional patch to update Documentation/filesystems/proc.txt
> and Documentation/sysctl/vm.txt

Certainly.

Attached patch is a short description for /proc/sys/vm/swap_token_timeout.


Best regards,

Hideo AOKI

Systems Development Laboratory, Hitachi, Ltd.

--------------070701080400050500090600
Content-Type: text/plain;
 name="vm-doc-swap-token-timeout.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-doc-swap-token-timeout.patch"

 filesystems/proc.txt |    8 ++++++++
 sysctl/vm.txt        |    2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

Signed-off-by: Hideo Aoki <aoki@sdl.hitachi.co.jp>

diff -uprN linux-2.6.9-rc3-vm-thrashing-control-tuning/Documentation/filesystems/proc.txt linux-2.6.9-rc3-vm-tuning-doc/Documentation/filesystems/proc.txt
--- linux-2.6.9-rc3-vm-thrashing-control-tuning/Documentation/filesystems/proc.txt	2004-10-07 10:47:23.000000000 +0900
+++ linux-2.6.9-rc3-vm-tuning-doc/Documentation/filesystems/proc.txt	2004-10-07 21:31:37.316226768 +0900
@@ -1269,6 +1269,14 @@ block_dump
 block_dump enables block I/O debugging when set to a nonzero value. More
 information on block I/O debugging is in Documentation/laptop-mode.txt.
 
+swap_token_timeout
+------------------
+
+This file contains valid hold time of swap out protection token. The Linux
+VM has token based thrashing control mechanism and uses the token to prevent
+unnecessary page faults in thrashing situation. The unit of the value is
+second. The value would be useful to tune thrashing behavior.
+
 2.5 /proc/sys/dev - Device specific parameters
 ----------------------------------------------
 
diff -uprN linux-2.6.9-rc3-vm-thrashing-control-tuning/Documentation/sysctl/vm.txt linux-2.6.9-rc3-vm-tuning-doc/Documentation/sysctl/vm.txt
--- linux-2.6.9-rc3-vm-thrashing-control-tuning/Documentation/sysctl/vm.txt	2004-10-07 10:47:53.000000000 +0900
+++ linux-2.6.9-rc3-vm-tuning-doc/Documentation/sysctl/vm.txt	2004-10-07 16:48:56.969591368 +0900
@@ -31,7 +31,7 @@ Currently, these files are in /proc/sys/
 
 dirty_ratio, dirty_background_ratio, dirty_expire_centisecs,
 dirty_writeback_centisecs, vfs_cache_pressure, laptop_mode,
-block_dump:
+block_dump, swap_token_timeout:
 
 See Documentation/filesystems/proc.txt
 

--------------070701080400050500090600--


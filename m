Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932782AbWJGT1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbWJGT1E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 15:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932783AbWJGT1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 15:27:03 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:24254 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932782AbWJGT1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 15:27:01 -0400
Message-ID: <4527FF78.4050309@linuxtv.org>
Date: Sat, 07 Oct 2006 15:26:48 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Mauro Carvalho Chehab <mchehab@infradead.org>
CC: Mike Isely at pobox <isely@pobox.com>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: pvrusb2 and 2.6.19-rc1
References: <Pine.LNX.4.64.0610071138100.27957@cnc.isely.net>
In-Reply-To: <Pine.LNX.4.64.0610071138100.27957@cnc.isely.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------090807050102090405050106"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090807050102090405050106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Mike Isely wrote:
> Mauro:
>
> Why are the pvrusb2 configuration switches nowhere to be found in 
> 2.6.19-rc1?  I'm running xconfig here and searching reverse-deps to try 
> and locate it.  Best I can tell is that it's gone.  The driver sources are 
> still present.  What's going on?
>   
Mauro, please pull from:

|git://git.kernel.org/pub/scm/linux/kernel/git/mkrufky/v4l-dvb.git

to fix the issue described by Mike Isely, above... ||or just apply the
attached patch to your git tree and send to Linus.|
|
This problem is only present in your git tree -- the hg tree is in good
shape.  How did this happen, Mauro?

Regards,

Michael Krufky


|

--------------090807050102090405050106
Content-Type: text/plain;
 name="0001-Kconfig-restore-pvrusb2-menu-items.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Kconfig-restore-pvrusb2-menu-items.txt"

>From 9ce12c8763cc244725dec99085efd293483c6bf8 Mon Sep 17 00:00:00 2001
From: Michael Krufky <mkrufky@linuxtv.org>
Date: Sat, 7 Oct 2006 15:10:53 -0400
Subject: [PATCH] Kconfig: restore pvrusb2 menu items

Looks like the pvrusb2 menu items were accidentally removed in
git commit 1450e6bedc58c731617d99b4670070ed3ccc91b4

This patch restores the menu items so that the pvrusb2 driver can be built.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
---
 drivers/media/video/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index afb734d..fbe5b61 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -677,6 +677,8 @@ #
 menu "V4L USB devices"
 	depends on USB && VIDEO_DEV
 
+source "drivers/media/video/pvrusb2/Kconfig"
+
 source "drivers/media/video/em28xx/Kconfig"
 
 source "drivers/media/video/usbvideo/Kconfig"
-- 
1.4.2.1


--------------090807050102090405050106--

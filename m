Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVCVC0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVCVC0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVCVCZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:25:16 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:64907 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262358AbVCVBgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:36:53 -0500
Message-Id: <20050322013455.924123000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:45 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-fwscript-newunshield.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 12/48] get_dvb_firmware: new unshield version
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch by Mattias Holmlund: support new version of unshield for
sp887x firmware extraction (changed cmdline parameters)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 get_dvb_firmware |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.12-rc1-mm1/Documentation/dvb/get_dvb_firmware
===================================================================
--- linux-2.6.12-rc1-mm1.orig/Documentation/dvb/get_dvb_firmware	2005-03-21 23:27:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1/Documentation/dvb/get_dvb_firmware	2005-03-22 00:15:20.000000000 +0100
@@ -79,8 +79,8 @@ sub sp887x {
     wgetfile($sourcefile, $url);
     unzip($sourcefile, $tmpdir);
     unshield("$tmpdir/$cabfile", $tmpdir);
-    verify("$tmpdir/sc_main.mc", $hash);
-    copy("$tmpdir/sc_main.mc", $outfile);
+    verify("$tmpdir/ZEnglish/sc_main.mc", $hash);
+    copy("$tmpdir/ZEnglish/sc_main.mc", $outfile);
 
     $outfile;
 }
@@ -292,7 +292,7 @@ sub unzip {
 sub unshield {
     my ($sourcefile, $todir) = @_;
 
-    system("unshield -d \"$todir\" \"$sourcefile\" > /dev/null" ) and die ("unshield failed - unable to extract firmware");
+    system("unshield x -d \"$todir\" \"$sourcefile\" > /dev/null" ) and die ("unshield failed - unable to extract firmware");
 }
 
 sub verify {

--


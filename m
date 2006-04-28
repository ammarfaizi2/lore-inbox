Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbWD1AUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbWD1AUi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWD1AUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:20:06 -0400
Received: from mx1.suse.de ([195.135.220.2]:29401 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751735AbWD1AUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:20:00 -0400
Date: Thu, 27 Apr 2006 17:18:27 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Michael Krufky <mkrufky@linuxtv.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 08/24] get_dvb_firmware: download nxt2002 firmware from new driver location
Message-ID: <20060428001827.GI18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="get_dvb_firmware-download-nxt2002-firmware-from-new-driver-location.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Michael Krufky <mkrufky@linuxtv.org>

BBTI has updated their driver, and removed the old one from their website.
This patch updates the get_dvb_firmware script to download the firmware
from the new driver location.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 Documentation/dvb/get_dvb_firmware |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.16.11.orig/Documentation/dvb/get_dvb_firmware
+++ linux-2.6.16.11/Documentation/dvb/get_dvb_firmware
@@ -240,9 +240,9 @@ sub dibusb {
 }
 
 sub nxt2002 {
-    my $sourcefile = "Broadband4PC_4_2_11.zip";
+    my $sourcefile = "Technisat_DVB-PC_4_4_COMPACT.zip";
     my $url = "http://www.bbti.us/download/windows/$sourcefile";
-    my $hash = "c6d2ea47a8f456d887ada0cfb718ff2a";
+    my $hash = "476befae8c7c1bb9648954060b1eec1f";
     my $outfile = "dvb-fe-nxt2002.fw";
     my $tmpdir = tempdir(DIR => "/tmp", CLEANUP => 1);
 
@@ -250,8 +250,8 @@ sub nxt2002 {
 
     wgetfile($sourcefile, $url);
     unzip($sourcefile, $tmpdir);
-    verify("$tmpdir/SkyNETU.sys", $hash);
-    extract("$tmpdir/SkyNETU.sys", 375832, 5908, $outfile);
+    verify("$tmpdir/SkyNET.sys", $hash);
+    extract("$tmpdir/SkyNET.sys", 331624, 5908, $outfile);
 
     $outfile;
 }

--

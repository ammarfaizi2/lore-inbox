Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbSK0Bgk>; Tue, 26 Nov 2002 20:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSK0Bgk>; Tue, 26 Nov 2002 20:36:40 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:16401 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S263760AbSK0Bgj>; Tue, 26 Nov 2002 20:36:39 -0500
Subject: 2.4.19+ initrd/floppy oddity, Slackware 8.1 bootdisks
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 26 Nov 2002 20:43:57 -0500
Message-Id: <1038361438.591.146.camel@pinhead>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found an odd problem with loading initrd from multiple uncompressed
floppies using kernel 2.4.19...2.4.20-rc4-ac1.  Floppy #1 of a 5-floppy
Slackware 8.1 install set loads correctly, then prompts for #2.  Floppy
#2 first executes a seek-track-zero and then immediately prompts to
enter floppy #3 without transferring any data.  I thought it was a data
read error, so spent much time making new floppies; no change.

Kernel 2.4.18 does not have this problem.  2.4.19 and up exhibit it.  I
did not try 2.4.19-pre.  Interestingly, booting off of a single
(compressed) floppy works fine in all cases.

Platform is a Dell desktop GXP260, P4, I82801 chipset.

Kris



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbUBVDtd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 22:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbUBVDtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 22:49:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:18312 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261665AbUBVDta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 22:49:30 -0500
Date: Sat, 21 Feb 2004 19:46:23 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Schulman.Andrew@epamail.epa.gov
Subject: [PATCH] Re: hw_random and the missing Intel RNGs
Message-Id: <20040221194623.1b4cc9e7.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(in reply to:  http://marc.theaimsgroup.com/?l=linux-kernel&m=106816271502140&w=2)

<quoting:>

hw_random has two problems with Intel chipsets:

(1) It fails to detect when no RNG is present.
(2) Intel has stopped putting RNGs into their chipsets.

I've written a description of this problem at
http://home.comcast.net/~andrex/hardware-RNG/index.html.  Here's a summary:
[snipped]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Andrew, I think you should have supplied a patch with your
detailed email.  How's this look?

Does anyone read docs nowadays?

--
~Randy



// Linux linux-263-work
// Document Intel hardware RNG changes.

diffstat:=
 Documentation/hw_random.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+)


diff -Naurp ./Documentation/hw_random.txt~intelrng ./Documentation/hw_random.txt
--- ./Documentation/hw_random.txt~intelrng	2004-02-17 19:58:40.000000000 -0800
+++ ./Documentation/hw_random.txt	2004-02-21 19:38:32.000000000 -0800
@@ -25,6 +25,18 @@ About the Intel RNG hardware, from the f
 	access to our RNG for use as a security feature. At this time,
 	the RNG is only to be used with a system in an OS-present state.
 
+Intel hardware RNG update:
+
+	hw_random has two problems with Intel chipsets:
+
+	(1) It fails to detect when no RNG is present.
+	(2) These products and tools are no longer being manufactured by Intel.
+
+	See <URL:http://home.comcast.net/~andrex/hardware-RNG/index.html>
+	for detailed information.
+	See <URL:http://www.intel.com/design/security/rng/rng.htm>
+	for related product information.
+
 Theory of operation:
 
 	Character driver.  Using the standard open()

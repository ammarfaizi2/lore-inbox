Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932656AbWAFHkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbWAFHkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbWAFHkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:40:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8590 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932656AbWAFHkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:40:20 -0500
Date: Fri, 6 Jan 2006 02:40:19 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: reference_discarded addition
Message-ID: <20060106074019.GA1226@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Error: ./fs/quota_v2.o .opd refers to 0000000000000020 R_PPC64_ADDR64    .exit.text

Been carrying this for some time in Red Hat trees.

Signed-off-by: Dave Jones <davej@redhat.com>

diff -urNp --exclude-from=/home/davej/.exclude linux-3022/scripts/reference_discarded.pl linux-10000/scripts/reference_discarded.pl
--- linux-3022/scripts/reference_discarded.pl
+++ linux-10000/scripts/reference_discarded.pl
@@ -88,6 +88,7 @@ foreach $object (keys(%object)) {
 		    ($from !~ /\.text\.exit$/ &&
 		     $from !~ /\.exit\.text$/ &&
 		     $from !~ /\.data\.exit$/ &&
+		     $from !~ /\.opd$/ &&
 		     $from !~ /\.exit\.data$/ &&
 		     $from !~ /\.altinstructions$/ &&
 		     $from !~ /\.pdr$/ &&

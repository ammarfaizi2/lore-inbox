Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262855AbUKTA6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbUKTA6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbUKTA4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:56:12 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:11948 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262743AbUKTAxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:53:55 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: LKML <linux-kernel@vger.kernel.org>
Subject: make oldconfig all does not work
Date: Sat, 20 Nov 2004 01:55:58 +0100
User-Agent: KMail/1.7.1
Cc: Sam Ravnborg <sam@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411200155.58942.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When doing

make oldconfig all

make oldconfig is executed, while make all is not. Simply using
make oldconfig and make all separately works.

There is also mention of attention given to this problem in the Makefile:

# To make sure we do not include .config for any of the *config targets
# catch them early, and hand them over to scripts/kconfig/Makefile
# It is allowed to specify more targets when calling make, including
# mixing *config targets and build targets.
# For example 'make oldconfig all'.

But, probably, when adding KBUILD_EXTMOD and _all targets, this broke.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

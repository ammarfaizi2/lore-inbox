Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTLIXfa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 18:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTLIXfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 18:35:30 -0500
Received: from holomorphy.com ([199.26.172.102]:35296 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262352AbTLIXfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 18:35:25 -0500
Date: Tue, 9 Dec 2003 15:35:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-wli-1
Message-ID: <20031209233523.GS8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031204200120.GL19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204200120.GL19856@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 12:01:20PM -0800, William Lee Irwin III wrote:
> Successfully tested on a Thinkpad T21. Any feedback regarding
> performance would be very helpful. Desktop users should notice top(1)
> is faster, kernel hackers that kernel compiles are faster, and highmem
> users should see much less per-process lowmem overhead.

Bill Davidsen reported an issue where compiled kernel images aren't
properly distinguished from mainline kernels' by installation scripts.

The following patch should resolve this:


-- wli



diff -prauN wli-2.6.0-test11-37/Makefile wli-2.6.0-test11-38/Makefile
--- wli-2.6.0-test11-37/Makefile	2003-11-26 12:44:43.000000000 -0800
+++ wli-2.6.0-test11-38/Makefile	2003-12-09 15:32:53.000000000 -0800
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 0
-EXTRAVERSION = -test11
+EXTRAVERSION = -test11-wli-1
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUITX4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUITX4G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 19:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266790AbUITX4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 19:56:06 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:62342 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261234AbUITX4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 19:56:02 -0400
Date: Mon, 20 Sep 2004 16:56:00 -0700
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] scripts: Support output of new ld
Message-ID: <20040920235600.GG5220@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040918065733.GA4549@darjeeling.triplehelix.org> <20040920161913.GC4501@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040920161913.GC4501@logos.cnet>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040722i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 01:19:13PM -0300, Marcelo Tosatti wrote:
> (We met at Palo Alto in a Debian dinner on a chinese restaurant, remember? :))

Oh! At the time I wasn't aware it was /this/ particular Marcelo... well,
hello then ;)

> Unfortunately this patch doenst apply cleanly

Huh, strange, my mailer must have munged it, or maybe things have
changed in BK. Here's a diff from a fresh checkout of linux-2.4.
Just in case my mail client munges it again I've also put it at 

http://people.debian.org/~joshk/gnu_ld.diff

-- 
Joshua Kwan

===== scripts/ver_linux 1.8 vs edited =====
--- 1.8/scripts/ver_linux	Wed Dec 17 23:34:53 2003
+++ edited/scripts/ver_linux	Mon Sep 20 16:54:07 2004
@@ -22,7 +22,8 @@
       '/GNU Make/{print "Gnu make              ",$NF}'
 
 ld -v 2>&1 | awk -F\) '{print $1}' | awk \
-      '/BFD/{print "binutils              ",$NF}'
+      '/BFD/{print "binutils              ",$NF}
+       /^GNU/{print "binutils              ",$4}'
 
 fdformat --version | awk -F\- '{print "util-linux            ", $NF}'
 

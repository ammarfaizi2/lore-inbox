Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264725AbUGGBGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbUGGBGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 21:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUGGBGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 21:06:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:30353 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264725AbUGGBGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 21:06:07 -0400
Date: Tue, 6 Jul 2004 18:05:54 -0700 (PDT)
From: Bryce Harrington <bryce@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>
cc: <ltp-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [LTP] Re: Recent changes in LTP test results
In-Reply-To: <20040630073419.GH21066@holomorphy.com>
Message-ID: <Pine.LNX.4.33.0407061756170.25528-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004, William Lee Irwin III wrote:
> On Mon, Jun 28, 2004 at 06:46:15PM -0700, Bryce Harrington wrote:
> > We usually always see 6-7 fails on the 2.6.x kernels, so the increase is
> > unusual.
> > I've generated some detailed LTP test result reports on a few of the
> > above runs, with specifics about the test runs and failures.  These are
> > available here:
> >     http://developer.osdl.org/bryce/ltp/
>
> This looks related to some widely-propagated change in errno return
> value (probably originating from some centralized source and cascading
> up the call chains).

The results listing has been updated.

    http://developer.osdl.org/bryce/ltp/

Briefly:

Patch Name           TestReq#    CPU  PASS  FAIL  WARN  BROK
patch-2.4.27-rc2       294321  2-way  7226     6     3     6
patch-2.4.27-rc3       294624  2-way  7226     6     3     6
patch-2.6.7-bk8        294304  2-way  7223    10     3     7
patch-2.6.7-bk9        294333  2-way  7224     7     3     6
patch-2.6.7-bk10       294403  2-way  7223    10     3     7
patch-2.6.7-bk11       294423  2-way  7178    46     3     6
patch-2.6.7-bk12       294442  2-way  7178    46     3     6
patch-2.6.7-bk13       294511  2-way  7178    46     3     6
patch-2.6.7-bk14       294573  2-way  7178    46     3     6
patch-2.6.7-bk15       294601  2-way  7178    46     3     6
patch-2.6.7-bk16       294614  2-way  7178    46     3     6
patch-2.6.7-bk17       294636  2-way  7178    46     3     6
patch-2.6.7-bk18       294648  2-way  7178    46     3     6
patch-2.6.7-bk19       294733  2-way  7178    46     3     6
2.6.7-mm2              294271  2-way  7181    47     3     6
2.6.7-mm3              294383  2-way  7185    46     3     6
2.6.7-mm4              294485  2-way  7177    46     3     3
2.6.7-mm5              294554  2-way  7178    46     3     6
2.6.7-mm6              294691  2-way  7178    46     3     6



No significant difference between the results for bk11 and bk19.
Namely:


--- failrpt_294423_2.6.7-bk11.txt       2004-06-28 17:35:18.000000000 -0700
+++ failrpt_294733_2.6.7-bk19.txt       2004-07-06 18:00:23.000000000 -0700
@@ -392,7 +392,7 @@
 Details:

 nanosleep02    1   FAIL : Remaining sleep time 3999392 usec doesn't
-                         match with the expected 3998364 usec time
+                         match with the expected 3997243 usec time
 nanosleep02    1   FAIL : child process exited abnormally



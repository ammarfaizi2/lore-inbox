Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUA2Thk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266326AbUA2Thj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:37:39 -0500
Received: from waste.org ([209.173.204.2]:22943 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266324AbUA2Thc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:37:32 -0500
Date: Thu, 29 Jan 2004 13:37:28 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Lindent fixed to match reality
Message-ID: <20040129193727.GJ21888@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been fiddling with cleaning up some old code here and suggest the
following to make Lindent match actual practice more closely. This does:

a) (no -psl)

void *foo(void) {

 instead of

void *
foo(void) {

b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"
c) (-ncs) "(void *)foo" rather than "(void *) foo"

 tiny-mpm/scripts/Lindent |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN scripts/Lindent~lindent-reality scripts/Lindent
--- tiny/scripts/Lindent~lindent-reality	2004-01-29 13:19:04.000000000 -0600
+++ tiny-mpm/scripts/Lindent	2004-01-29 13:28:23.000000000 -0600
@@ -1,2 +1,2 @@
 #!/bin/sh
-indent -kr -i8 -ts8 -sob -l80 -ss -bs -psl "$@"
+indent -kr -i8 -ts8 -sob -l80 -ss -ncs "$@"

_


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting

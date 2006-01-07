Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752573AbWAGSVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbWAGSVR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752577AbWAGSVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:21:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39941 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752573AbWAGSVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:21:17 -0500
Date: Sat, 7 Jan 2006 19:21:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] kernel/synchro-test.c: make 5 functions static
Message-ID: <20060107182115.GR3774@stusta.de>
References: <20060107052221.61d0b600.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107052221.61d0b600.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 05:22:21AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm1:
>...
> +mutex-subsystem-synchro-test-module.patch
>...
>  mutex stuff
>...

This patch makes fives needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 kernel/synchro-test.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.15-mm2-full/kernel/synchro-test.c.old	2006-01-07 17:26:30.000000000 +0100
+++ linux-2.6.15-mm2-full/kernel/synchro-test.c	2006-01-07 17:27:11.000000000 +0100
@@ -221,7 +221,7 @@
 		schedule();
 }
 
-int mutexer(void *arg)
+static int mutexer(void *arg)
 {
 	unsigned int N = (unsigned long) arg;
 
@@ -243,7 +243,7 @@
 	complete_and_exit(&mx_comp[N], 0);
 }
 
-int semaphorer(void *arg)
+static int semaphorer(void *arg)
 {
 	unsigned int N = (unsigned long) arg;
 
@@ -265,7 +265,7 @@
 	complete_and_exit(&sm_comp[N], 0);
 }
 
-int reader(void *arg)
+static int reader(void *arg)
 {
 	unsigned int N = (unsigned long) arg;
 
@@ -289,7 +289,7 @@
 	complete_and_exit(&rd_comp[N], 0);
 }
 
-int writer(void *arg)
+static int writer(void *arg)
 {
 	unsigned int N = (unsigned long) arg;
 
@@ -313,7 +313,7 @@
 	complete_and_exit(&wr_comp[N], 0);
 }
 
-int downgrader(void *arg)
+static int downgrader(void *arg)
 {
 	unsigned int N = (unsigned long) arg;
 


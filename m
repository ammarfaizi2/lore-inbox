Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWAFPRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWAFPRt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWAFPRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:17:15 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:5786 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751508AbWAFPQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:16:56 -0500
Date: Fri, 6 Jan 2006 13:11:08 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: robert.olsson@its.uu.se, netdev@oss.sgi.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] pktgen: Adds missing __init.
Message-Id: <20060106131108.53411909.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 pktgen_find_thread() and pktgen_create_thread() are only called at
initialization time.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 net/core/pktgen.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 06cad2d..5eeae0d 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2883,7 +2883,7 @@ static int pktgen_add_device(struct pktg
 	return add_dev_to_thread(t, pkt_dev);
 }
 
-static struct pktgen_thread *pktgen_find_thread(const char* name) 
+static struct pktgen_thread __init *pktgen_find_thread(const char* name) 
 {
         struct pktgen_thread *t = NULL;
 
@@ -2900,7 +2900,7 @@ static struct pktgen_thread *pktgen_find
         return t;
 }
 
-static int pktgen_create_thread(const char* name, int cpu) 
+static int __init pktgen_create_thread(const char* name, int cpu) 
 {
         struct pktgen_thread *t = NULL;
 	struct proc_dir_entry *pe;


-- 
Luiz Fernando N. Capitulino

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293656AbSBRESI>; Sun, 17 Feb 2002 23:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293657AbSBRER6>; Sun, 17 Feb 2002 23:17:58 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:64775 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293656AbSBRERn>; Sun, 17 Feb 2002 23:17:43 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.2 Trivial patches
Date: Mon, 18 Feb 2002 15:17:31 +1100
Message-Id: <E16cfF5-0001rX-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

	Just one trivial patch this week for 2.2.

Cheers!
Rusty.

Trivial patch update against 2.2.21-pre2:
René Scharfe <l.s.r@web.de>: [PATCH] compiler warnings in scripts_tkgen.c:
  this patch fixes two compiler warnings during make xconfig which
  turn up if one uses -Wshadow

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal /home/rusty/devel/kernel/linux-2.2.21-pre2/scripts/tkgen.c /home/rusty/devel/kernel/trivial-2.2.21-pre2/scripts/tkgen.c
--- /home/rusty/devel/kernel/linux-2.2.21-pre2/scripts/tkgen.c	Mon May 28 13:57:45 2001
+++ /home/rusty/devel/kernel/trivial-2.2.21-pre2/scripts/tkgen.c	Mon Feb 18 15:15:43 2002
@@ -587,11 +587,11 @@
 	case token_int:
 	    if ( cfg->value && *cfg->value == '$' )
 	    {
-		int index = get_varnum( cfg->value+1 );
+		int i = get_varnum( cfg->value+1 );
 		printf( "\n" );
-		if ( ! vartable[index].global_written )
+		if ( ! vartable[i].global_written )
 		{
-		    global( vartable[index].name );
+		    global( vartable[i].name );
 		}
 		printf( "\t" );
 	    }
@@ -956,7 +956,6 @@
 static void end_proc( struct kconfig * scfg, int menu_num )
 {
     struct kconfig * cfg;
-    int i;
 
     printf( "\n\n\n" );
     printf( "\tfocus $w\n" );
@@ -1051,6 +1050,7 @@
 	    {
 		if ( cfg->token == token_tristate )
 		{
+		    int i;
 		    if ( ! vartable[cfg->nameindex].global_written )
 		    {
 			vartable[cfg->nameindex].global_written = 1;

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

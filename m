Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSEaARl>; Thu, 30 May 2002 20:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSEaARk>; Thu, 30 May 2002 20:17:40 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:3720 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S312619AbSEaARi>;
	Thu, 30 May 2002 20:17:38 -0400
Date: Fri, 31 May 2002 10:16:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Linus <torvalds@transmeta.com>
Cc: Trivial Kernel Patches <trivial@rustcorp.com.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Latil <laurent@latil.nom.fr>
Subject: [PATCH] APM patch for idle_period handling
Message-Id: <20020531101652.246d7fcc.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Linus,

This patch from Laurent Latil <laurent@latil.nom.fr> fixes a copy
and paste error.  The patch applies to 2.4.19-pre9 and 2.5.19 (with
some offsets).

Please apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--- linux-2.4.18/arch/i386/kernel/apm.c	Mon Apr  1 12:12:48 2002
+++ linux/arch/i386/kernel/apm.c	Wed May 22 20:51:35 2002
@@ -1788,7 +1788,7 @@
 			idle_threshold = simple_strtol(str + 15, NULL, 0);
 		if ((strncmp(str, "idle-period=", 12) == 0) ||
 		    (strncmp(str, "idle_period=", 12) == 0))
-			idle_threshold = simple_strtol(str + 15, NULL, 0);
+			idle_period = simple_strtol(str + 12, NULL, 0);
 		invert = (strncmp(str, "no-", 3) == 0) ||
 			(strncmp(str, "no_", 3) == 0);
 		if (invert)

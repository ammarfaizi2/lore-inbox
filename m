Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280863AbRKZNHO>; Mon, 26 Nov 2001 08:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280889AbRKZNGy>; Mon, 26 Nov 2001 08:06:54 -0500
Received: from ns.suse.de ([213.95.15.193]:63505 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280863AbRKZNGx>;
	Mon, 26 Nov 2001 08:06:53 -0500
Date: Mon, 26 Nov 2001 14:06:45 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] net/802/Makefile
Message-ID: <20011126140645.B3014@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the build stops when cl2llc.c has no write permissions.

diff -urN linuxppc_2_4/net/802/Makefile.broken linuxppc_2_4/net/802/Makefile
--- linuxppc_2_4/net/802/Makefile.broken        Mon Nov 26 13:28:56 2001
+++ linuxppc_2_4/net/802/Makefile       Mon Nov 26 13:51:10 2001
@@ -57,4 +57,5 @@
 include $(TOPDIR)/Rules.make
 
 cl2llc.c: cl2llc.pre
+       chmod u+w cl2llc.c
        sed -f ./pseudo/opcd2num.sed cl2llc.pre >cl2llc.c



Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...

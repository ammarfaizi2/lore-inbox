Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287401AbSBCQ4R>; Sun, 3 Feb 2002 11:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287421AbSBCQ4I>; Sun, 3 Feb 2002 11:56:08 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:19978 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287401AbSBCQzu>;
	Sun, 3 Feb 2002 11:55:50 -0500
Date: Sat, 2 Feb 2002 21:37:06 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Marcelo Roberto Jimenez <mroberto@cetuc.puc-rio.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3: Unresolved Symbols in ppp_deflate.o and ufs.o
Message-ID: <20020202233706.GF8013@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Marcelo Roberto Jimenez <mroberto@cetuc.puc-rio.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C5C4E00.2080400@cetuc.puc-rio.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C5C4E00.2080400@cetuc.puc-rio.br>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Feb 02, 2002 at 06:37:20PM -0200, Marcelo Roberto Jimenez escreveu:
> I'm having the same problem:
> 
> depmod: *** Unresolved symbols in 
> /lib/modules/2.5.3/kernel/drivers/net/ppp_deflate.o
> depmod:         zlib_inflateIncomp

Try this:


Index: lib/zlib_inflate/inflate_syms.c
===================================================================
RCS file: /home/cvs/kernel-acme/lib/zlib_inflate/inflate_syms.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 inflate_syms.c
--- lib/zlib_inflate/inflate_syms.c	2002/01/31 22:30:27	1.1.1.1
+++ lib/zlib_inflate/inflate_syms.c	2002/02/02 23:36:05
@@ -18,4 +18,5 @@
 EXPORT_SYMBOL(zlib_inflateSync);
 EXPORT_SYMBOL(zlib_inflateReset);
 EXPORT_SYMBOL(zlib_inflateSyncPoint);
+EXPORT_SYMBOL(zlib_inflateIncomp);
 MODULE_LICENSE("GPL");

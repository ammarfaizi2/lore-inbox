Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSE2VW1>; Wed, 29 May 2002 17:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSE2VW0>; Wed, 29 May 2002 17:22:26 -0400
Received: from adsl.hlfl.org ([62.212.107.116]:18694 "HELO adsl.hlfl.org")
	by vger.kernel.org with SMTP id <S315525AbSE2VW0>;
	Wed, 29 May 2002 17:22:26 -0400
Date: Wed, 29 May 2002 23:22:25 +0200
From: Arnaud Launay <asl@launay.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 : 'make dep' error
Message-ID: <20020529212225.GA10412@launay.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0205291611040.8639-100000@localhost.localdomain> <Pine.LNX.4.44.0205291528160.9971-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-PGP-Key: http://launay.org/pgpkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 29, 2002 at 03:37:15PM -0500, Kai Germaschewski a écrit:
> So fix your setup to not use symlinks, or, at least, put an older kernel 
> back into /usr/src/linux and compile the new kernels elsewhere.

Or use the following:

--- linux-2.5.19-old/scripts/Makefile	Wed May 29 20:42:56 2002
+++ linux/scripts/Makefile	Wed May 29 21:46:58 2002
@@ -8,7 +8,7 @@
 	$(HOSTCC) $(HOSTCFLAGS) -o $@ $<
 
 split-include: split-include.c
-	$(HOSTCC) $(HOSTCFLAGS) -o $@ $<
+	$(HOSTCC) $(HOSTCFLAGS) -I $(HPATH) -o $@ $<
 
 # xconfig
 # ---------------------------------------------------------------------------




I find it perfectly idiotic to tell people to use older kernel
include. Better to tell them to use stable versions if they do
not know what they do.

I want applications to be build with the new kernel headers,
including new API, especially when some aren't backward
compatible, and I think I'm not alone. And the only way to find
these is to symlink those headers to the utilised kernel release.

	Arnaud.

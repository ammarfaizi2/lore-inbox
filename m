Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbUBNMKX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 07:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUBNMKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 07:10:23 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54466 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261877AbUBNMKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 07:10:18 -0500
Date: Sat, 14 Feb 2004 13:10:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Peter Cordes <peter@cordes.ca>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: typo: HOSTCCFLAGS instead of HOSTCFLAGS in lib/Makefile
Message-ID: <20040214121013.GI1308@fs.tum.de>
References: <20040210233102.GH5388@llama.nslug.ns.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210233102.GH5388@llama.nslug.ns.ca>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 07:31:02PM -0400, Peter Cordes wrote:
> 
>  In lib/Makefile in Linux 2.4.24, near the end there is:
> gen_crc32table: gen_crc32table.c
>          $(HOSTCC) $(HOSTCCFLAGS) -o $@ $<
>                          ^^
>  It should be HOSTCFLAGS, not HOSTCCFLAGS.
> 
>  There aren't any other instances of HOSTCCFLAGS in 2.4.24, or any in 2.6.1.

Nice spotting!

@Marcelo:
Please apply the patch below.

>  please CC on replies, since I'm not subscribed.

cu
Adrian

--- linux-2.4.25-rc2-full/lib/Makefile.old	2004-02-14 13:02:36.000000000 +0100
+++ linux-2.4.25-rc2-full/lib/Makefile	2004-02-14 13:02:47.000000000 +0100
@@ -42,7 +42,7 @@
 crc32.o: crc32table.h
 
 gen_crc32table: gen_crc32table.c
-	$(HOSTCC) $(HOSTCCFLAGS) -o $@ $<
+	$(HOSTCC) $(HOSTCFLAGS) -o $@ $<
 
 crc32table.h: gen_crc32table
 	./$< > $@

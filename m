Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTKLGuf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 01:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTKLGuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 01:50:35 -0500
Received: from [202.181.197.10] ([202.181.197.10]:64005 "EHLO
	gandalf.gnupilgrims.org") by vger.kernel.org with ESMTP
	id S261797AbTKLGu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 01:50:29 -0500
Date: Wed, 12 Nov 2003 14:49:42 +0800
To: Willy Tarreau <willy@w.ods.org>
Cc: Kaj-Michael Lang <milang@tal.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-rc1
Message-ID: <20031112064942.GA7073@gandalf.chinesecodefoo.org>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet> <009001c3a89a$af611130$54dc10c3@amos> <20031112061909.GB9634@alpha.home.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20031112061909.GB9634@alpha.home.local>
User-Agent: Mutt/1.3.28i
From: glee@gnupilgrims.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2003 at 07:19:09AM +0100, Willy Tarreau wrote:
> Hi,
> 
> for me, -rc1 compiles correctly on Alpha, but I don't use agpgart. So I
> guess it's about your only problem here.
> 


I think that we should wrap the msr.h include around a CONFIG_X86_MSR.

	- g.
	


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="agpgart.diff"

--- linux-2.4.22/drivers/char/agp/agpgart_be.c.orig	2003-11-12 14:16:40.000000000 +0800
+++ linux-2.4.22/drivers/char/agp/agpgart_be.c	2003-11-12 14:17:54.000000000 +0800
@@ -49,7 +49,10 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/page.h>
+
+#ifdef CONFIG_X86_MSR
 #include <asm/msr.h>
+#endif
 
 #include <linux/agp_backend.h>
 #include "agp.h"

--45Z9DzgjV8m4Oswq--

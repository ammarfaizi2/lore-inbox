Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTKLJK2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 04:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTKLJK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 04:10:28 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:24592 "EHLO w.ods.org")
	by vger.kernel.org with ESMTP id S261903AbTKLJK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 04:10:27 -0500
Date: Wed, 12 Nov 2003 10:10:01 +0100
From: Willy Tarreau <willy@w.ods.org>
To: glee@gnupilgrims.org
Cc: Kaj-Michael Lang <milang@tal.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-rc1
Message-ID: <20031112091001.GA23762@alpha.home.local>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet> <009001c3a89a$af611130$54dc10c3@amos> <20031112061909.GB9634@alpha.home.local> <20031112064942.GA7073@gandalf.chinesecodefoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112064942.GA7073@gandalf.chinesecodefoo.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 02:49:42PM +0800, glee@gnupilgrims.org wrote:
> On Wed, Nov 12, 2003 at 07:19:09AM +0100, Willy Tarreau wrote:
> > Hi,
> > 
> > for me, -rc1 compiles correctly on Alpha, but I don't use agpgart. So I
> > guess it's about your only problem here.
> > 
> 
> 
> I think that we should wrap the msr.h include around a CONFIG_X86_MSR.

Or simply remove it ? it doesn't seem to me that it's used anywhere in this
file. Could anybody try this patch ?

Regards,
Willy

diff -urN linux-2.4.23-rc1/drivers/char/agp/agpgart_be.c linux-2.4.23-rc1-nomsr/drivers/char/agp/agpgart_be.c
--- linux-2.4.23-rc1/drivers/char/agp/agpgart_be.c	Mon Nov 10 22:24:58 2003
+++ linux-2.4.23-rc1-nomsr/drivers/char/agp/agpgart_be.c	Wed Nov 12 10:08:34 2003
@@ -49,7 +49,6 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/page.h>
-#include <asm/msr.h>
 
 #include <linux/agp_backend.h>
 #include "agp.h"



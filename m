Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUEAFW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUEAFW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 01:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUEAFW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 01:22:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:1943 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261991AbUEAFWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 01:22:25 -0400
Date: Fri, 30 Apr 2004 22:21:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: CaT <cat@zip.com.au>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: libata + siI3112 + 2.6.5-rc3 hang
Message-Id: <20040430222157.17f5db82.akpm@osdl.org>
In-Reply-To: <20040501030828.GE2109@zip.com.au>
References: <20040429234258.GA6145@zip.com.au>
	<200404300208.32830.bzolnier@elka.pw.edu.pl>
	<20040430093919.GA2109@zip.com.au>
	<200404301800.08763.bzolnier@elka.pw.edu.pl>
	<20040501030828.GE2109@zip.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT <cat@zip.com.au> wrote:
>
> Here's the patch that Joe sent me. It doesn't apply cleanly mainly due
>  to formatting errors in the patch but a bit of manual fixerupping made
>  it all apply.
> 
>  --- 8< ---
>  --- linux-2.6.4-orig/arch/i386/pci/fixup.c      2004-03-11 
>  03:55:36.000000000 +0100
>  +++ linux-2.6.4/arch/i386/pci/fixup.c   2004-03-16 13:12:25.706569480 +0100
>  @@ -187,6 +187,22 @@
>                 dev->transparent = 1;
>  }
> 
>  +/*
>  + * Halt Disconnect and Stop Grant Disconnect (bit 4 at offset 0x6F)
>  + * must be disabled when APIC is used (or lockups will happen).
>  + */

I had this in -mm for a while.  Ended up dropping it because it made some
people's CPUs run warmer and because it "wasn't the right fix".

Does anyone know what the right fix is?  If not, it seems that a warm CPU
is better than a non-functional box.  Maybe enable it via a boot option?


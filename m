Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbUEAPOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUEAPOq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 11:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUEAPOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 11:14:46 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13697 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261735AbUEAPOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 11:14:45 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew Morton <akpm@osdl.org>, CaT <cat@zip.com.au>
Subject: Re: libata + siI3112 + 2.6.5-rc3 hang
Date: Sat, 1 May 2004 17:15:53 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <20040429234258.GA6145@zip.com.au> <20040501030828.GE2109@zip.com.au> <20040430222157.17f5db82.akpm@osdl.org>
In-Reply-To: <20040430222157.17f5db82.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405011715.53580.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 of May 2004 07:21, Andrew Morton wrote:
> CaT <cat@zip.com.au> wrote:
> > Here's the patch that Joe sent me. It doesn't apply cleanly mainly due
> >  to formatting errors in the patch but a bit of manual fixerupping made
> >  it all apply.
> >
> >  --- 8< ---
> >  --- linux-2.6.4-orig/arch/i386/pci/fixup.c      2004-03-11
> >  03:55:36.000000000 +0100
> >  +++ linux-2.6.4/arch/i386/pci/fixup.c   2004-03-16 13:12:25.706569480
> > +0100 @@ -187,6 +187,22 @@
> >                 dev->transparent = 1;
> >  }
> >
> >  +/*
> >  + * Halt Disconnect and Stop Grant Disconnect (bit 4 at offset 0x6F)
> >  + * must be disabled when APIC is used (or lockups will happen).
> >  + */

LOL, CaT this is my old patch. :)

> I had this in -mm for a while.  Ended up dropping it because it made some
> people's CPUs run warmer and because it "wasn't the right fix".
>
> Does anyone know what the right fix is?  If not, it seems that a warm CPU
> is better than a non-functional box.  Maybe enable it via a boot option?

Ross' recent patch is a good workaround.


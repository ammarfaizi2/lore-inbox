Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbTILOQc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 10:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTILOQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 10:16:31 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:20698 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S261637AbTILOQa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 10:16:30 -0400
Date: Fri, 12 Sep 2003 16:16:20 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NCR53c406a.c warning
In-Reply-To: <1063374111.1767.2.camel@mulgrave>
Message-ID: <Pine.GSO.3.96.1030912161154.17936I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Sep 2003, James Bottomley wrote:

> > NCR53c406a: Apparently wait_intr() is unused, so remove it.
> 
> It is currently unused.  However, the reason is that we removed the scsi
> command method that allows polled operation in a driver (this routine is
> actually polling the interrupt port on the chip).
> 
> I'd like to wait a while to see if anyone still needs this mode when 2.6
> gets a wider test audience.  If you wish, you can surround the routine
> with #if 0 and a comment saying we can junk it later if it really is
> unnecessary.

 I've encountered an ISA adapter using this chip in polled mode (no ISA
IRQ line routed to the chip) quite recently.  But I can't say if the guy
using it won't throw it away before final 2.6. ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


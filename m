Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262370AbSJPLwx>; Wed, 16 Oct 2002 07:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262371AbSJPLwx>; Wed, 16 Oct 2002 07:52:53 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:53718 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262370AbSJPLww>; Wed, 16 Oct 2002 07:52:52 -0400
Date: Wed, 16 Oct 2002 13:59:17 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: jw schultz <jw@pegasys.ws>
cc: linux-kernel@vger.kernel.org
Subject: Re: mapping 36 bit physical addresses into 32 bit virtual
In-Reply-To: <20021016100439.GF7844@pegasys.ws>
Message-ID: <Pine.GSO.3.96.1021016135305.14774H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, jw schultz wrote:

> OK. I guess i'm wrong.  It may be that the hardware was
> locked into 32bit mode.  The development period was a couple
> of years so we were running on essentially 89-90 tech with a
> faster clock.

 I'm not sure if you can lock a MIPS system into the 32-bit mode at all,
certainly not the processor -- it always runs with 64-bit operations
enabled when in the kernel mode (for the user and supervisor modes it's
selectable), though you may disable 64-bit addressing.  A system may be
incapable of 64-bit operation if its system controller doesn't support
doubleword transfers on the host bus, but I'm not sure if it's possible to
force an R4k CPU to only use 32-bit transfers for cache fills and
writebacks.  Probably not.  So that's really the matter of software only. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


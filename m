Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290758AbSAYSIB>; Fri, 25 Jan 2002 13:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290760AbSAYSHv>; Fri, 25 Jan 2002 13:07:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48651 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290758AbSAYSHb>; Fri, 25 Jan 2002 13:07:31 -0500
Subject: Re: [PATCH]: Fix MTRR handling on HT CPUs (improved)
To: Martin.Wilck@fujitsu-siemens.com (Martin Wilck)
Date: Fri, 25 Jan 2002 18:20:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel mailing list),
        rgooch@atnf.csiro.au (Richard Gooch),
        Martin.Wilck@fujitsu-siemens.com (Martin Wilck),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.33.0201242145400.1046-100000@biker.pdb.fsc.net> from "Martin Wilck" at Jan 24, 2002 09:57:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16UAxL-0003B6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I strongly suspected somebody else must have hit this problem before, but
> intensive research did show up nothing. Also my first post on LK
> received no "hey, that's old stuff" answer. So here I go.

A tiny patch was posted about 4-6 months ago

The patch is total overkill. Just remove the error reporting if the right
firmware was already loaded. You've written a fixup wrapper around a 
rather nonsensical erorr check for an existing non-error.

The same will occur with CPU hot plugging in the future as well as ACPI
power saving sometimes and in those cases the patch you posted doesn't
help anyway.

Alan

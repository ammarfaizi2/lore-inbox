Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbTBXUjC>; Mon, 24 Feb 2003 15:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267476AbTBXUjC>; Mon, 24 Feb 2003 15:39:02 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:128 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S267472AbTBXUjB>; Mon, 24 Feb 2003 15:39:01 -0500
Date: Mon, 24 Feb 2003 21:48:35 +0100 (CET)
From: Folkert van Heusden <appel@vanheusden.com>
X-X-Sender: <appel@muur.intranet.vanheusden.com>
To: Pavel Machek <pavel@ucw.cz>
cc: "Moore, Robert" <robert.moore@intel.com>,
       "'Bjorn Helgaas'" <bjorn_helgaas@hp.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Walz, Michael" <michael.walz@intel.com>, <t-kochi@bq.jp.nec.com>,
       <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] [PATCH] 1/3 ACPI resource handling
In-Reply-To: <20030223225439.GC120@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0302242146420.16778-100000@muur.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 1) This seems like a good idea to simplify the parsing of the resource lists
> > 2) I'm not convinced that this buys a whole lot -- it just hides the code
> > behind a macro (something that's not generally liked in the Linux world.)
> > Would this procedure be called from more than one place?
> Well, reducing code duplication *is* liked in Linux world. Use inline
> function instead of macro if possible, through.

Isn't it better to use functions instead of macro's? Reduces the code
size--> less dirty cache-lines.

I saw, by the way, several functions duplicated in the networking-code.
For example a lot of them have a net_random-alike function. Imho they
should use the net_random in utils.c. Sadly my patches were ignored by the
maintainers.


Folkert



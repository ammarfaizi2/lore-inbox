Return-Path: <linux-kernel-owner+w=401wt.eu-S1752067AbXARRHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbXARRHh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 12:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbXARRHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 12:07:37 -0500
Received: from [139.30.44.16] ([139.30.44.16]:11205 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752067AbXARRHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 12:07:37 -0500
Date: Thu, 18 Jan 2007 18:07:35 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH]  Centralize the macro definition of "__packed".
In-Reply-To: <Pine.LNX.4.64.0701181147250.24824@CPE00045a9c397f-CM001225dbafb6>
Message-ID: <Pine.LNX.4.63.0701181803320.2210@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.64.0701180959470.19826@CPE00045a9c397f-CM001225dbafb6>
 <Pine.LNX.4.63.0701181745550.2068@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.64.0701181147250.24824@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007, Robert P. J. Day wrote:

> actually, it *appears* that the standard works this way.  the macro
> "__deprecated" is defined in compiler-gcc.h with:
> 
>     #define __deprecated __attribute__((deprecated))
> 
> while the more generic compiler.h handles whether or not it was
> defined:
> 
>     #ifndef __deprecated
>     # define __deprecated           /* unimplemented */
>     #endif
> 
> so i'm guessing that's how any new attribute shortcut macros should be
> handled, yes?

Well, since the definitions lived well in compiler-generic land for quite 
some time, I'd guess it should be ok not to #ifndef - guard them. 
likely() and unlikely() are currently handled like that.
If the need ever arises to make them compiler specific, whoever does that 
can still add the #ifndef then.

Tim

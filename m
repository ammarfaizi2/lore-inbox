Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTELRTC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbTELRTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:19:02 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:9170 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262358AbTELRTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:19:00 -0400
Date: Mon, 12 May 2003 10:31:44 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.net
Subject: Re: [PATCH] better ali1563 integrated ethernet support
In-Reply-To: <20030512113038.GA31870@suse.de>
Message-ID: <Pine.LNX.4.53.0305121029330.21172@twinlark.arctic.org>
References: <200305111914.h4BJES3g007061@hera.kernel.org> <20030512113038.GA31870@suse.de>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003, Dave Jones wrote:

>  >  #if defined(__sparc__)
>  >          /* DM9102A needs 32-dword alignment/burst length on sparc - chip bug? */
>  > -        if (pdev->vendor == 0x1282 && pdev->device == 0x9102)
>  > +	if ((pdev->vendor == 0x1282 && pdev->device == 0x9102)
>  > +		|| (pdev->vendor == 0x10b9 && pdev->device == 0x5261))
>  >                  csr0 = (csr0 & ~0xff00) | 0xe000;
>  >  #endif
>
> Integrated ALi 1563 on a sparc ?

oh duh i didn't even look hard at that... i just went and made sure any
9102 bug tests were copied, in case the ali1563 was a bug-for-bug clone :)
1563 is a hypertransport device... so i doubt it'll show up on a sparc.
oops.

-dean

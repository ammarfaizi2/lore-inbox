Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTENS1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTENS1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:27:23 -0400
Received: from [217.157.19.70] ([217.157.19.70]:27398 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S263467AbTENS1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:27:20 -0400
From: Thomas Horsten <thomas@horsten.com>
To: Dave Jones <davej@suse.de>
Subject: Re: [PATCH] 2.5.69 Changes to Kconfig and i386 Makefile to include support for various K7 optimizations
Date: Wed, 14 May 2003 19:40:10 +0100
User-Agent: KMail/1.5.1
Cc: LKML <linux-kernel@vger.kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
       Michael Elizabeth Chastain <mec@shout.net>
References: <200305071834.26789.thomas@horsten.com> <20030514160449.B28115@suse.de>
In-Reply-To: <20030514160449.B28115@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305141940.10999.thomas@horsten.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 May 2003 15:04, Dave Jones wrote:

>  > I made this patch to support the various K7 model-specific
>  > optimizations that the later GCC compilers can use.
>  >
>  > Please have a look, and pass me any comments.
>
> I don't think this is worth the extra complication. The potential wins
> (if any) outweigh the confusion to users who might have no clue as to
> what core they have.  Additionally, some gcc's got these options wrong.
> The athlon4 option was completely wrong for a while for eg.

I think when GCC supports the different cores, it should be supported by the 
kernel scripts, the differences between the cores are real enough to have 
potential optimizations at least in theory (as far as I could see the only 
difference in GCC 3.2 is whether to use SSE, but that could change in the 
future).

Maybe it should be renamed "Advanced CPU model selection", or something like 
that, instead of "K7 Model Selection", but the help IMHO makes it clear 
enough that you should go with the default if you are not sure and that it 
will work on any core.

I think it's a fairly simple patch that doesn't break anything, and there are 
certainly options lurking around in Kconfig that are much more obscure than 
this :)

>  > I also have the same patch for 2.4, if you are interested it's
>  > available on my Linux page on http://www.infowares.com/linux
>
> For 2.4, it's an even worse idea IMO.

I completely agree that this shouldn't go into the stock 2.4 kernel, that's 
also why I didn't post it here. It's just on my site as a convenience for 
those who might want to use the XP specific options etc. in an easy way (like 
I use it myself).

// Thomas

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315606AbSFTVio>; Thu, 20 Jun 2002 17:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315616AbSFTVh6>; Thu, 20 Jun 2002 17:37:58 -0400
Received: from zok.sgi.com ([204.94.215.101]:63657 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315606AbSFTVhq>;
	Thu, 20 Jun 2002 17:37:46 -0400
Date: Thu, 20 Jun 2002 14:37:43 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org, pazke@orbita1.ru
Subject: Re: [PATCH][RFC] SGI VISWS support for 2.5
Message-ID: <20020620213743.GA67049@sgi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, pazke@orbita1.ru
References: <20020620112608.GA303@pazke.ipt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020620112608.GA303@pazke.ipt>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I gave it a go on a 320 that I have here and it gets into start_kernel
somewhere, but I don't get any output on the serial console.  If you'd
like to get it into 2.5, maybe we should clean it up a little first
(as well as get it working)?

When I ported the last patch forward to 2.4.17, I noticed that there
were quite a few parts that could use some work.  Looking through the
patch, it seems like the head.S stuff could be done in a better way,
maybe a seperate head.S for machines that start in protected mode?
Then again, maybe the boot loader should just be changed?  The
interrupt handler code also needs to be fixed up.

I haven't looked at the patch to seperate out i386 subarches yet, but
maybe that would be a good first step to abstracting away some of the
visws setup code?

Jesse

On Thu, Jun 20, 2002 at 03:26:08PM +0400, Andrey Panin wrote:
> Hi all,
> 
> attached patch is a forward port of latest (2.4.17) visws patch from 
> sourceforge. It's mostly trivial textual merge. Builds, unteseted.
> 
> Please take a look at it.
> 
> -- 
> Andrey Panin            | Embedded systems software engineer
> pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net




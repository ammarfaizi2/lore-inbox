Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWBJPWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWBJPWB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWBJPWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:22:01 -0500
Received: from cantor2.suse.de ([195.135.220.15]:23446 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932133AbWBJPWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:22:00 -0500
From: Andi Kleen <ak@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Cleanup possibility in asm-i386/string.h
Date: Fri, 10 Feb 2006 16:02:18 +0100
User-Agent: KMail/1.8.2
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <200602071215.46885.ak@suse.de> <200602101449.07491.ak@suse.de> <Pine.LNX.4.61.0602101523040.30994@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0602101523040.30994@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101602.19154.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 15:46, Roman Zippel wrote:
> Hi,
> 
> On Fri, 10 Feb 2006, Andi Kleen wrote:
> 
> > > #define strcpy __builtin_strcpy
> > > 
> > > which also renames the version in lib/string.c, so x86-64 never had a 
> > > fallback copy for __builtin_sprintf.
> > > Can we please get rid of -freestanding and fix x86-64 instead?
> > 
> > Ok I can fix that. Just removing the defines should be ok i guess 
> > (afaik gcc detects them automatically as the builtin) 
> 
> Not with -freestanding.

True.

> 
> > I don't know if the freestanding in the main Makefile isn't needed 
> > for other architectures so I won't touch it right now.
> 
> Well, it was added for x86-64...
> It shouldn't break anything, that isn't already broken. 

Ok i will remove it then.


Thanks,
-Andi

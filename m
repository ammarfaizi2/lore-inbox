Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWBJOrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWBJOrA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWBJOrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:47:00 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:11461 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751261AbWBJOq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:46:59 -0500
Date: Fri, 10 Feb 2006 15:46:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andi Kleen <ak@suse.de>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Cleanup possibility in asm-i386/string.h
In-Reply-To: <200602101449.07491.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0602101523040.30994@scrub.home>
References: <200602071215.46885.ak@suse.de> <200602100123.36077.ak@suse.de>
 <Pine.LNX.4.61.0602101355490.30994@scrub.home> <200602101449.07491.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 10 Feb 2006, Andi Kleen wrote:

> > #define strcpy __builtin_strcpy
> > 
> > which also renames the version in lib/string.c, so x86-64 never had a 
> > fallback copy for __builtin_sprintf.
> > Can we please get rid of -freestanding and fix x86-64 instead?
> 
> Ok I can fix that. Just removing the defines should be ok i guess 
> (afaik gcc detects them automatically as the builtin) 

Not with -freestanding.

> I don't know if the freestanding in the main Makefile isn't needed 
> for other architectures so I won't touch it right now.

Well, it was added for x86-64...
It shouldn't break anything, that isn't already broken. 

bye, Roman

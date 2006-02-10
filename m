Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWBJA5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWBJA5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWBJA5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:57:12 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:36030 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750919AbWBJA5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:57:10 -0500
Date: Fri, 10 Feb 2006 01:53:41 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Cleanup possibility in asm-i386/string.h
In-Reply-To: <20060210000523.GE3524@stusta.de>
Message-ID: <Pine.LNX.4.61.0602100143460.30994@scrub.home>
References: <200602071215.46885.ak@suse.de> <Pine.LNX.4.61.0602071230520.9696@scrub.home>
 <200602071308.59827.ak@suse.de> <Pine.LNX.4.61.0602071336060.30994@scrub.home>
 <20060210000523.GE3524@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 10 Feb 2006, Adrian Bunk wrote:

> I remember playing with using more gcc builtins in the kernel some time 
> ago, and some gcc builtin used a different library function, which was a 
> function the kernel did not supply.
> 
> I don't remember the exact details, but this was the reason why I 
> preferred using builtins only when explicitely enabled.

gcc can turn a sprintf() into strcpy(), which is a valid thing to do even 
in a kernel environment. It can be turned off selectively, if it should 
be a problem, so using -free-standing is IMO complete overkill.

bye, Roman

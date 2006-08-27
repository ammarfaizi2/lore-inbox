Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWH0TQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWH0TQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 15:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWH0TQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 15:16:29 -0400
Received: from mail.suse.de ([195.135.220.2]:60894 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750928AbWH0TQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 15:16:29 -0400
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
Date: Sun, 27 Aug 2006 21:16:23 +0200
User-Agent: KMail/1.9.3
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <445B5524.2090001@gmail.com> <p73irkedod2.fsf@verdi.suse.de> <44F1E970.1050709@zytor.com>
In-Reply-To: <44F1E970.1050709@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608272116.23498.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 August 2006 20:50, H. Peter Anvin wrote:
> Andi Kleen wrote:
> > 
> > The last time I tried this on x86-64 lilo on systems that used EDD broke.
> > EDD uses part of the bootup page too. So most likely it's not that simple.
> > 
> > And please don't shout your subjects.
> > 
> 
> On i386, the command line is never stored in the bootup page; only a 
> pointer to it is.  The copying is done straight into the 
> saved_command_line buffer in the kernel BSS (head.S lines 79-104).
> 
> x86-64 does the same thing, but in C code (head64.c lines 45-56.)  Thus, 
> if you had a problem with LILO, I suspect the problem was inside LILO 
> itself, and not a kernel issue.

Just increasing that constant caused various lilo setups to not boot
anymore. I don't know who is actually to blame, just wanting to
point out that this "obvious" patch isn't actually that obvious.

-Andi

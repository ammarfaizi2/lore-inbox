Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266121AbUFRQ2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266121AbUFRQ2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUFRQ2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:28:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:23763 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266121AbUFRQ2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:28:05 -0400
Date: Fri, 18 Jun 2004 09:27:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cross-sparse
In-Reply-To: <Pine.GSO.4.58.0406172304170.1495@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.58.0406180925210.4669@ppc970.osdl.org>
References: <Pine.GSO.4.58.0406172304170.1495@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 Jun 2004, Geert Uytterhoeven wrote:
> 
> I wanted to give sparse a try on m68k, and noticed the current infrastructure
> doesn't handle cross-compilation (no sane m68k people compile kernels natively
> anymore, unless they run a Debian autobuilder ;-).
> 
> After hacking the include paths in the sparse sources, installing the resulting
> binary as m68k-linux-sparse, and applying the following patch, it seems to work
> fine!

Hmm.. It does make sense, but at the same time, sparse isn't even really 
supposed to _care_ about the architecture. Especially not for a kernel 
build.

Which part breaks when not just using the native sparse? As far as I know, 
a kernel build should use all-kernel header files, with the exception of 
"stdarg.h" which I thought was also architecture-independent (but hey, 
maybe I'm just a retard, and am wrong).

		Linus

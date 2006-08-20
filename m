Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWHTSis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWHTSis (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWHTSis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:38:48 -0400
Received: from ns2.suse.de ([195.135.220.15]:31671 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750901AbWHTSis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:38:48 -0400
From: Andi Kleen <ak@suse.de>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: Re: [PATCH] x86_64: fix linking on 32-bit system
Date: Sun, 20 Aug 2006 20:30:48 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060820143117.6622.22777.stgit@memento.home.lan>
In-Reply-To: <20060820143117.6622.22777.stgit@memento.home.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608202030.48791.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 16:31, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> When compiling a 64-bit kernel on an Ubuntu 6.06 32bit system (whose GCC is also
> a cross-compiler for x86_64) I've seen that head.o is compiled as a 64-bit file
> (while it should not) and ld complaining about this during linking:
> 
> ld: warning: i386:x86-64 architecture of input file
> `arch/x86_64/boot/compressed/head.o' is incompatible with i386 output
> 
> I've verified that removing -m64 from compilation flags to turn
> "-m64 -traditional -m32" into "-traditional -m32" fixes the issue.

Applied thanks, but I removed the comment because it's on more
than just Ubuntu 32bit.

AFAIK the warning is harmless, but you're the first to submit a real
patch to fix it.
-Andi

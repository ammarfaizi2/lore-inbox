Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVGXV3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVGXV3N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 17:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVGXV3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 17:29:13 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:14350 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261361AbVGXV3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 17:29:09 -0400
To: VASM <vasm85@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, gbakos@cfa.harvard.edu,
       linux-kernel@vger.kernel.org
Subject: Re: kernel page size explanation
References: <Pine.SOL.4.58.0507211925170.28852@titan.cfa.harvard.edu>
	<9a87484905072118207a85970e@mail.gmail.com>
	<87d5p8aw4h.fsf@amaterasu.srvr.nix>
	<4536bb7305072412011fbeaf59@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: Lovecraft was an optimist.
Date: Sun, 24 Jul 2005 22:28:59 +0100
In-Reply-To: <4536bb7305072412011fbeaf59@mail.gmail.com> (VASM's message of
 "Mon, 25 Jul 2005 00:31:07 +0530")
Message-ID: <878xzvc2qs.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2005, VASM wrote:
> i had one question 
> does the linux kernel support only one default page size even if the
> processor on which it is working supports multiple ?

No. Some architectures have compile-time support for multiple different
page sizes (e.g. Itanium, SPARC64); many have support for a
(non-swappable) `large pages) system, and a filesystem backed by huge
pages. (Often, the kernel is stored in huge pages, to keep the number
of page table entries wasted by the nonswappable kernel to a minimum.)

What is *not* presently supported is using multiple page sizes to
back userspace processes; that size is currently fixed at compile-time,
even on architectures supporting multiple variably-sized pages.

-- 
`But of course, GR is the very best relativity for the masses.'
 --- Wayne Throop

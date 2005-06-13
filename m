Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVFML11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVFML11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 07:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVFML11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 07:27:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21164 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261444AbVFML1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 07:27:24 -0400
Subject: Re: Add pselect, ppoll system calls.
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       drepper@redhat.com
In-Reply-To: <1118661326.9949.127.camel@localhost.localdomain>
References: <1118444314.4823.81.camel@localhost.localdomain>
	 <1118616499.9949.103.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
	 <1118661326.9949.127.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 12:27:17 +0100
Message-Id: <1118662037.2840.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 12:15 +0100, Alan Cox wrote:
> Right but why can't glibc be fixed to use the longjmp trick
> internally.

Unless I misunderstand what is suggested, for glibc to do that
internally would be vile. It'd have to override the signal handler for
every signal which is unmasked by the new signal mask, right?

That kind of trick makes some sense to use in an _application_ if the
author isn't expecting to run on a POSIX system and just use pselect(),
but for glibc to hack it up internally would be horrid.

-- 
dwmw2


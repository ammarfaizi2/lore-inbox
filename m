Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVFMHaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVFMHaB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 03:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVFMHaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 03:30:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40103 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261338AbVFMH37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 03:29:59 -0400
Subject: Re: Add pselect, ppoll system calls.
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, jnf <jnf@innocence-lost.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       drepper@redhat.com
In-Reply-To: <1118647401.5986.91.camel@gaston>
References: <1118444314.4823.81.camel@localhost.localdomain>
	 <1118616499.9949.103.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
	 <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>
	 <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>
	 <1118647401.5986.91.camel@gaston>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 08:29:49 +0100
Message-Id: <1118647789.2840.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 17:23 +1000, Benjamin Herrenschmidt wrote:
> That is still racy ... if the signal hits between loading that global to
> to pass it to select and the actual syscall entry ... pretty narrow but
> still there.

We don't load it; we pass a pointer to select. It works, but it's hardly
elegant.

-- 
dwmw2


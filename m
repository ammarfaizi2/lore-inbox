Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbVLSU7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVLSU7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVLSU7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:59:15 -0500
Received: from canuck.infradead.org ([205.233.218.70]:52612 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964971AbVLSU7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:59:14 -0500
Subject: Re: [patch 04/15] Generic Mutex Subsystem,
	add-atomic-call-func-x86_64.patch
From: David Woodhouse <dwmw2@infradead.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
References: <20051219013507.GE27658@elte.hu>
	 <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 20:58:52 +0000
Message-Id: <1135025932.4760.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 09:49 -0800, Zwane Mwaikambo wrote:
> Hi Ingo,
>         Doesn't this corrupt caller saved registers?

Looks like it. I _really_ don't like calling functions from inline asm.
It's not nice. Can't we use atomic_dec_return() for this?

-- 
dwmw2


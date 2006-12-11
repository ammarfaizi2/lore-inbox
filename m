Return-Path: <linux-kernel-owner+w=401wt.eu-S934424AbWLKOWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934424AbWLKOWn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934487AbWLKOWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:22:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55479 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934424AbWLKOWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:22:42 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061211132540.GA4629@APFDCB5C> 
References: <20061211132540.GA4629@APFDCB5C>  <29447.1165840536@redhat.com> 
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Mark bitrevX() functions as const 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 11 Dec 2006 14:22:30 +0000
Message-ID: <17788.1165846950@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <akinobu.mita@gmail.com> wrote:

> __attribute_pure__ ?

I'm not sure "pure" is better than const in this case.  Although it *does* look
at a global variable (byte_rev_table), that variable is constant.  In effect,
the functions output does only depend on its input.  The R/O data it requires
is no different to its out of line code.  You'd have to consult a compiler
wrangler to be sure, though.

David

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270587AbTGTEQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 00:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270585AbTGTEQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 00:16:31 -0400
Received: from rth.ninka.net ([216.101.162.244]:25283 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S270587AbTGTEPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 00:15:43 -0400
Date: Sat, 19 Jul 2003 21:30:38 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: joshk@triplehelix.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm2
Message-Id: <20030719213038.5c719bbe.davem@redhat.com>
In-Reply-To: <20030719212715.42be9277.akpm@osdl.org>
References: <20030719174350.7dd8ad59.akpm@osdl.org>
	<20030720024102.GA18576@triplehelix.org>
	<20030719212715.42be9277.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jul 2003 21:27:15 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Joshua Kwan <joshk@triplehelix.org> wrote:
> >   /* References to section boundaries */
> >  -extern char _text, _etext, _edata, __bss_start, _end;
> >  +extern char _text[], _etext[], _edata[], __bss_start[], _end[];
> 
> No, the declaration simply needs to be deleted; it is already provided by
> asm/sections.h.
> 
> Incorrectly, I believe.  Those symbols are conventionally "extern int".

True, from some perspective.

But you have to admit the pointer math gets real ugly if we declare
them in that way. :-)


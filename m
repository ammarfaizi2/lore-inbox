Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTGTELM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 00:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTGTELM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 00:11:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:62615 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261180AbTGTELL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 00:11:11 -0400
Date: Sat, 19 Jul 2003 21:27:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm2
Message-Id: <20030719212715.42be9277.akpm@osdl.org>
In-Reply-To: <20030720024102.GA18576@triplehelix.org>
References: <20030719174350.7dd8ad59.akpm@osdl.org>
	<20030720024102.GA18576@triplehelix.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan <joshk@triplehelix.org> wrote:
>
>  2.6.0-test1-mm2 requires attached patch to build with software suspend.
> ...
>   
>   /* References to section boundaries */
>  -extern char _text, _etext, _edata, __bss_start, _end;
>  +extern char _text[], _etext[], _edata[], __bss_start[], _end[];

No, the declaration simply needs to be deleted; it is already provided by
asm/sections.h.

Incorrectly, I believe.  Those symbols are conventionally "extern int".


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265028AbTIDO0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbTIDOZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:25:23 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:48902 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265019AbTIDOZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:25:11 -0400
Subject: Re: [parisc-linux] [PATCH] add MODULE_ALIAS_LDISC to
	asm-parisc/termios.h
From: James Bottomley <James.Bottomley@steeleye.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <willy@debian.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030904135315.GB2411@conectiva.com.br>
References: <20030904135315.GB2411@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 04 Sep 2003 10:24:41 -0400
Message-Id: <1062685483.1829.6.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 09:53, Arnaldo Carvalho de Melo wrote:
> +#define MODULE_ALIAS_LDISC(ldisc) \
> +        MODULE_ALIAS("tty-ldisc-" __stringify(ldisc))

These are the strings used to identify the required line discipline
module to kmod, aren't they?

Since modprobe.conf seems to be generated without much regard for
architectures, is there any reason why this definition should differ
amongst architectures?  I think the answer's "no", so I think this fix
should be in linux/termios.h (or somewhere architecture independent).

James



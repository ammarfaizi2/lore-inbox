Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUD0Xmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUD0Xmw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUD0Xmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:42:52 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:30388 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264430AbUD0Xmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:42:42 -0400
Date: Wed, 28 Apr 2004 01:42:39 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jamagallon@able.es, Matthias Andree <matthias.andree@gmx.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] incomplete dependencies with BK tree (was: Anyone got aic7xxx working with 2.4.26?)
Message-ID: <20040427234239.GA12753@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	jamagallon@able.es, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <200404261532.37860.dj@david-web.co.uk> <20040426161004.GE5430@merlin.emma.line.org> <20040427131941.GC10264@logos.cnet> <20040427142643.GA10553@merlin.emma.line.org> <6A88E87D-985B-11D8-AA97-000A9585C204@able.es> <20040427161314.GA18682@merlin.emma.line.org> <20040427180924.GA22366@merlin.emma.line.org> <1911B825-989D-11D8-A81A-000A9585C204@able.es> <Pine.LNX.4.58.0404271555130.20443@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404271555130.20443@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Linus Torvalds wrote:

> How about just _always_ including stdarg.h, and doing it by just making 
> the main Makefile add a "-include <pathname>" to the CFLAGS? We should be 
> able to generate the stdarg.h pathname pretty easily, with something like
> 
> 	gcc --print-file-name=include/stdarg.h
> 
> (and that may depend on gcc versions too, of course).

stdarg.h is innocent, it is just one of the few include files valid in
the stdinc paths.

How about making sure the dependency information is complete, even when
BK has just "bk clean"ed an unedited file in the course of a "bk pull"?

Maybe mkdep or Makefile should just try to check out missing files and
mkdep barf if it cannot open a file it was given? It works for .c files,
it works for many of the .h files - it lacks for some other .h files and
for the Config.in or Kconfig files. That would leave the BK user with
just the "bk get" boot-strap at top level.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

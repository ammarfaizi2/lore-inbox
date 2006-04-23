Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWDWUr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWDWUr0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 16:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWDWUr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 16:47:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61090 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751456AbWDWUrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 16:47:25 -0400
Subject: Re: [PATCH] 'make headers_install' kbuild target.
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: bunk@stusta.de, sam@ravnborg.org
In-Reply-To: <1145672241.16166.156.camel@shinybook.infradead.org>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Sun, 23 Apr 2006 21:47:46 +0100
Message-Id: <1145825267.16166.229.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 03:17 +0100, David Woodhouse wrote:
> I expect the kbuild folks to reimplement what I've done in the Makefile,
> but it works well enough to get us started. The text file listing the
> header files will probably want to change -- maybe we'll have a file in
> each directory listing the exportable files in that directory, or maybe
> we'll put a marker in the public files which we can grep for. I don't
> care much. 

And lo... within 10 hours a patch landed in my mailbox which did it all
properly. Now we have Kbuild files in each directory under include/
which list $(header-y) files for copying and $(unifdef-y) files which
need unifdef run on them. Thanks Arnd :)

This is in the git tree at
git://git.infradead.org/~dwmw2/headers-2.6.git

I'm going to stick that in a public directory and give group access to
it, and give out accounts to anyone who wants to assist. Although that
probably isn't necessary -- the individual header file cleanups can
probably go upstream directly rather than into this tree.

-- 
dwmw2


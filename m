Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWDXALq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWDXALq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 20:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWDXALq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 20:11:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20895 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751049AbWDXALp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 20:11:45 -0400
Subject: Re: [PATCH] 'make headers_install' kbuild target.
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: bunk@stusta.de, sam@ravnborg.org
In-Reply-To: <1145672241.16166.156.camel@shinybook.infradead.org>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 01:12:07 +0100
Message-Id: <1145837528.16166.251.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 03:17 +0100, David Woodhouse wrote:
> Attached is the current patch from mainline to my working tree at
> git://git.infradead.org/~dwmw2/headers-2.6.git -- visible in gitweb at
> http://git.infradead.org/?p=users/dwmw2/headers-2.6.git;a=summary
> 
> It adds a 'make headers_install' target to the kernel makefiles, which
> exports a subset of the headers and runs 'unifdef' on them to clean
> them up for installation in /usr/include. 

I've now added a 'make headers_check' target which goes through the
resulting headers and checks that they are a closed set -- they don't
attempt to include any kernel header which isn't selected for export.
I've also committed enough header cleanups to ensure that the checks
pass, at least for ARCH=powerpc. 

In time, I'd like to see additional checks added, such as checking for
namespace pollution and perhaps attempting to compile each header
standalone.

Now that we can see the mess we have when we export it, there should be
plenty of fun pickings for kernel janitor-types. There's no particular
reason why those cleanups should come through my tree, although I'm
happy enough to collect them and to give accounts on git.infradead.org
to anyone who's going to make a habit of sending them. 

-- 
dwmw2


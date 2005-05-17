Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVEQSfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVEQSfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 14:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVEQSfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 14:35:41 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:37247 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261937AbVEQSfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 14:35:20 -0400
Date: Tue, 17 May 2005 20:36:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com
Subject: Re: [PATCH] Makefile include path ordering
Message-ID: <20050517183631.GA16936@mars.ravnborg.org>
References: <Pine.LNX.4.61.0505161700150.14180@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505161700150.14180@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 05:02:17PM -0400, Rik van Riel wrote:
> The arch Makefile may override the include path order, which is
> used by Xen (and UML?) to make sure include/asm-xen is searched
> before include/asm-i386.

gcc will respect the order of -I options assinged to CFLAGS
So adding xen support at the proper (topmost) place in
arch/i386/Makefile should satisfy this requirement.

Also playing with NOSTDINC_FLAGS will most likely break builds with O=
since kbuild does not mangle patchs specified with NOSTDINC

	Sam

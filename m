Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVEQVpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVEQVpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 17:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVEQVpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:45:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:6062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261953AbVEQVmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:42:51 -0400
Date: Tue, 17 May 2005 14:44:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: Andrew Morton <akpm@osdl.org>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: Re: [PATCH] uml: remove elf.h
In-Reply-To: <20050517213447.GN7136@pasky.ji.cz>
Message-ID: <Pine.LNX.4.58.0505171443180.18337@ppc970.osdl.org>
References: <200505171704.j4HH4Ne8002532@hera.kernel.org>
 <20050517142113.59097a3d.akpm@osdl.org> <20050517213447.GN7136@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 May 2005, Petr Baudis wrote:
>
> Perhaps some artificial timestamp could help to the file
> removal heuristic in GNU patch. Or passing it -E, but that will
> obviously do the wrong thing to any other zero-sized files.

-E is always correct for the kernel, since zero-length files aren't really 
supposed to exist anyway, and "make distclean" has always removed them.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUFXQCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUFXQCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 12:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265806AbUFXQCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 12:02:41 -0400
Received: from zeus.kernel.org ([204.152.189.113]:5838 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265805AbUFXQCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 12:02:34 -0400
Date: Thu, 24 Jun 2004 09:41:04 -0400
From: Ben Collins <bcollins@debian.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: using gcc built-ins for bitops?
Message-ID: <20040624134103.GB9774@phunnypharm.org>
References: <20040624070936.GB30057@devserv.devel.redhat.com> <20040624020022.0601d4ae.akpm@osdl.org> <20040624090605.GA11805@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624090605.GA11805@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps. It's not impossible that say gcc 3.5 will add a few more builtins
> even that then allow more functions to be converted, otoh that shouldn't be
> impossible to cope with. I'll have a look to see how it pans out.

You could have an asm-generic/bitops-builtin.h and arch's could #include
that after defining all the HAVE_BUILTIN_xxx macros they want. I suspect
not all architectures will get the most correct built-ins (e.g. the arch
may be able to optimize better than gcc's builtin is doing).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

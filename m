Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265175AbUFATtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUFATtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 15:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265184AbUFATtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 15:49:09 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59561 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S265175AbUFATtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 15:49:06 -0400
Message-Id: <200406011948.i51JmajD006349@eeyore.valparaiso.cl>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count 
In-Reply-To: Message from =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> 
   of "Tue, 01 Jun 2004 15:37:53 +0200." <20040601133753.GC14572@wohnheim.fh-wedel.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 01 Jun 2004 15:48:36 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> said:

[...]

> What I need is:
> 1. Recursion count

How do you know the limit is enforced? By guessing?

> 2. All functions involved in the recursion in the correct order (a
>    calls b calls c calls d calls a, something like that).

But also b calls f calls g...

Maintaining the full possible-call-graph is a _huge_ job, better done
automatically (because somebody _will_screw up when doing it by hand). Plus
the fun "structure spicked with all sorts of function pointers" object
implementation in the kernel... note that your carefully maintained call
graph/counts can be screwed up royally by any random third-party device
driver or filesystem module.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

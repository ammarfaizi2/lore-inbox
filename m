Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVLMOSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVLMOSK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbVLMOSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:18:10 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:10173 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964888AbVLMOSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:18:08 -0500
Message-Id: <200512131317.jBDDHFFr004724@laptop11.inf.utfsm.cl>
To: Felix Oxley <lkml@oxley.org>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from Felix Oxley <lkml@oxley.org> 
   of "Mon, 12 Dec 2005 18:53:30 -0000." <B1E7AE38-6D7C-4CE6-847E-8F1608F66D77@oxley.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Tue, 13 Dec 2005 10:17:10 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 13 Dec 2005 11:16:28 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Oxley <lkml@oxley.org> wrote:
> On 12 Dec 2005, at 17:17, Horst von Brand wrote:
> > Felix Oxley <lkml@oxley.org> wrote:
> >
> > [...]
> >
> >> What if ...
> >>
> >> 1. When people make a patch set, if they have encountered any 'bugs'
> >> they split them out as separate items.

> > No need. Patches are either (a) bug fixes, or (b) infrastructure
> > changes, or (c) additions (mostly drivers). You only need to pick (a)
> > items. Check.

[...]

> >> 3. When the patch is posted to LKML, it is tagged [PATCH][FIX] in the
> >> subject line.
> >>      In the body of the fix would be noted each kernel to which the
> >>      fix applied e.g [FIX 2.6.11][FIX 2.6.12][FIX 2.6.13][FIX 2.6.14]

> > No do. Problem are the (b) and (c) patches above, they change
> > whatever the patch applies to and make it not apply anymore. The effort
> > of finding out if the patch is (a) or (c) class, seeing if it is really
> > needed, and modifying it so it applies to your source base is called
> > "backporting". And it remains hard, thankless work.
> 
> If this was done for 'trivial' patches of type (a):
> 	1. Would that make it simple enough for people to actually do it?
> 	2. Would it be worthwhile? (Are there enough 'trivial fixes'?)

Not all important fixes are "trivial", far from it; so this is rather
suspect in any case. Changes to the underlying source make even "trivial"
patches soon not apply anymore. And there still is the job of finding out
if some patch is or is not necessary...

> I envisaged something like the current Stable series, just for longer
> than a single release cycle.

Go right ahead. If enough people get interested and work on it, it might
turn out useful. I rather doubt it, as the current development model is
exactly geared towards keeping people up to date, not running ancient
kernels and then jumping a few versions ahead. The problem with doing that
is that instead of one problem at a time you see a dozen, and then it is
hard to pin down /when/ it broke (and thus what change is responsible).
Plus the drift from backported patches, where you can't be sure it /seemed/
to work because of some random patch.

Again, this development model was tried /hard/ for some 12 years by the
distributions, and found sorely lacking (and essentially unfixable).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

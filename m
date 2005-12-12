Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVLLRUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVLLRUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 12:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVLLRUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 12:20:17 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41954 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932070AbVLLRUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 12:20:16 -0500
Message-Id: <200512121717.jBCHHqHe017137@laptop11.inf.utfsm.cl>
To: Felix Oxley <lkml@oxley.org>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from Felix Oxley <lkml@oxley.org> 
   of "Mon, 12 Dec 2005 14:45:52 -0000." <671576E7-A7F1-4FF9-8E4B-361A89ADA173@oxley.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Mon, 12 Dec 2005 14:17:52 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 12 Dec 2005 14:17:53 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Oxley <lkml@oxley.org> wrote:

[...]

> What if ...
> 
> 1. When people make a patch set, if they have encountered any 'bugs'
> they split them out as separate items.

No need. Patches are either (a) bug fixes, or (b) infrastructure changes,
or (c) additions (mostly drivers). You only need to pick (a) items. Check.

> 2. The submitter would identify through GIT when the error had been
> introduced

Hard to find out. Nobody will do so.

>            so that the the person responsible could be CC'ed, also
> anybody who had worked on the code recently would be CCed, therefore
> the programmers who were most familiar with that section of code
> would be made aware of it.

Cc:ing them is part of the development anyway (in reality, Cc:ing anybody
interested in the area). Check.

> 3. When the patch is posted to LKML, it is tagged [PATCH][FIX] in the
> subject line.
>      In the body of the fix would be noted each kernel to which the
>      fix applied e.g [FIX 2.6.11][FIX 2.6.12][FIX 2.6.13][FIX 2.6.14]

No do. Problem are the (b) and (c) patches above, they change whatever the
patch applies to and make it not apply anymore. The effort of finding out
if the patch is (a) or (c) class, seeing if it is really needed, and
modifying it so it applies to your source base is called "backporting". And
it remains hard, thankless work.

> 4. The programmers mentioned in (2) would ACK the patch which would
> then become part of an 'official' fixes list.

Won't happen.

> 5. If a volunteer wanted to maintain, say, 2.6.14 + fixes, they could
> build and test it and be a point of contact regarding any problems.
> These could hopefully be tracked down and submitted as a new fix patch.

Go right ahead. Just be warned that distributions hired a small army of
kernel specialists to do exactly this, and got tired of doing so. Among
others because the patches deemed necessary were different from one
distributuion to the next, and then usually incompatible with one another
and with what turned out to be the standard solution. This gave rise to the
current development model...

Armchair software engineering is much like armchair $SPORT.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

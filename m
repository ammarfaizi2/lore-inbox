Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266281AbUIFL7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUIFL7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 07:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUIFL7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 07:59:48 -0400
Received: from web52302.mail.yahoo.com ([206.190.39.97]:48989 "HELO
	web52302.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266281AbUIFL7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 07:59:45 -0400
Message-ID: <20040906115945.65379.qmail@web52302.mail.yahoo.com>
Date: Mon, 6 Sep 2004 13:59:45 +0200 (CEST)
From: =?iso-8859-1?q?Albert=20Herranz?= <albert_herranz@yahoo.es>
Subject: Re: 2.6.9-rc1-mm1 ppc build broken
To: Joseph Fannin <jhf@rivenstone.net>, Andrew Morton <akpm@osdl.org>
Cc: roland@redhat.com, linux-kernel@vger.kernel.org, benh@kernel.crashing.org
In-Reply-To: <20040906014308.GA2638@samarkand.rivenstone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > OK, now I have an ordering problem.  If I
> understand you correctly, this
> > patch fixes a ppc problem which was introduced by
> a patch from the bk-ia64
> > tree, yes?
> 
>    Yes.
>  

As I understand it, the build problem was triggered
when the waitid-system-call.patch from Roland McGrath
and the bk-ia64.patch time interpolation logic patch
from Cristoph Lameter were applied.

But the cause itself, as Roland pointed, is the fact
that the asm-ppc/io.h includes linux/mm.h, unlike
other platforms (that's why the build problem only
affected ppc).
This seems to be unnecessary. At least, confirmation
for this exists for some embedded ppc ports (me) and
the PowerMac (Joseph). 

> > If so, my options are to ask Tony to add this
> patch to the bk-ia64 tree so
> > they all go in at the same time, or to merge this
> patch into Linus's tree
> > prior to the ia64 patch.  To do the latter, I'd
> need confirmation that your
> > patch is safe against current -linus.  Can you
> please confirm this?
> 
>     -rc1-bk12 with this patch applied builds and
> runs okay on my
> Powermac, so yes.  Thanks!
> 

IIRC, the linus tree also includes linux/mm.h in
asm-ppc/io.h since several versions.

Cheers,
Albert



		
______________________________________________
Renovamos el Correo Yahoo!: ¡100 MB GRATIS!
Nuevos servicios, más seguridad
http://correo.yahoo.es

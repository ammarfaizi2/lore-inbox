Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTE2N7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 09:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTE2N7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 09:59:11 -0400
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:34579 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S262253AbTE2N7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 09:59:10 -0400
Date: Thu, 29 May 2003 16:10:34 +0200
From: Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, axboe@suse.de, m.c.p@wolk-project.de,
       kernel@kolivas.org, manish@storadinc.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030529141034.GA1547@rz.uni-karlsruhe.de>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Andrew Morton <akpm@digeo.com>, axboe@suse.de,
	m.c.p@wolk-project.de, kernel@kolivas.org, manish@storadinc.com,
	marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <200305281713.24357.kernel@kolivas.org> <20030528071355.GO845@suse.de> <200305280930.48810.m.c.p@wolk-project.de> <20030528073544.GR845@suse.de> <20030528005156.1fda5710.akpm@digeo.com> <20030528101348.GA804@rz.uni-karlsruhe.de> <20030528032315.679e77b0.akpm@digeo.com> <20030528121040.GA1193@rz.uni-karlsruhe.de> <20030529131937.GJ1453@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529131937.GJ1453@dualathlon.random>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 03:19:37PM +0200, Andrea Arcangeli wrote:
> On Wed, May 28, 2003 at 02:10:40PM +0200, Matthias Mueller wrote:
> > Tested all of them and some combinations:
> > patch 1 alone: still mouse hangs
> > patch 2 alone: still mouse hangs
> > patch 3 alone: no hangs, but I get some zombie process (starting a lot of
> >                xterms results in zombie xterms, not noticed with vanilla
> >                and the other patches)
> > patch 1+2: no mouse hangs
> > patch 1+2+3: no mouse hangs, no zombies
> 
> I can't find a sense in the zombie thing, how can you generate zombie at
> all from xterms? That sounds like your userspace is terribly broken and
> it may have race conditions or whatever. In no way those patches can
> generate or not-generate zombies from xterms. I never ever seen a zombie
> xterm in my whole linux experience.

I rechecked everything an noticed, that it wasn't a xterm, but a wrapper
script, that executed rxvt. I changed that to plain xterm and the zombies
were gone. So I think there was probably a bug in rxvt triggered there.
After that I redid the tests, with the same result (and no zombies).
I can feel no difference between 1+2 or 1+2+3.

Matthias
-- 
Matthias.Mueller@rz.uni-karlsruhe.de
Rechenzentrum Universitaet Karlsruhe
Abteilung Netze

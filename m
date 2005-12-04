Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVLDOZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVLDOZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 09:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVLDOZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 09:25:58 -0500
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:25779 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S932234AbVLDOZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 09:25:57 -0500
Date: Sun, 4 Dec 2005 15:25:51 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204142551.GB4769@merlin.emma.line.org>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <1133630556.22170.26.camel@laptopd505.fenrus.org> <20051203230520.GJ25722@merlin.emma.line.org> <43923DD9.8020301@wolfmountaingroup.com> <20051204121209.GC15577@merlin.emma.line.org> <1133699555.5188.29.camel@laptopd505.fenrus.org> <20051204132813.GA4769@merlin.emma.line.org> <1133703338.5188.38.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133703338.5188.38.camel@laptopd505.fenrus.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Dec 2005, Arjan van de Ven wrote:

> On Sun, 2005-12-04 at 14:28 +0100, Matthias Andree wrote:
> 
> > I meant the ipmi, smbus and copa modules by Fujitsu-Siemens.
> > 
> > They are provided in source form, but I just found out (reading the
> > headers and not just the lines that broke the compile) they are not open
> > source. Perhaps one should prod them to slap a modified-BSD or perhaps
> > GPL label onto their modules.
> 
> is there an URL to these?

http://download.fujitsu-siemens.com/prim_supportcd/Programs/General/ServView/Linux/agents/srvmagt-mods_src.suse.rpm

> > It seems you'd then maintain them after their submission? :-)
> 
> usually such modules are extremely low maintenance once merged.... There
> are many many drivers without a maintainer, and they still get fixed.

As I say, these aren't licensed for inclusion into the kernel, they bear
a (C) Copyright notice and "All rights reserved."

> > These use inter_module_get() 
> 
> which is still there even in the latest 2.6.15-rc. It should be going
> out but hasn't yet. And that is the case for at least a year (eg they
> are __deprecated but still there).

No, they aren't - at least not anywhere declared below include/ and thus
uncompilable with GCC4.

> Most of those were already in the final place with a temporary compat
> header in the old one I guess. But if this is all.... that really isn't
> a big deal. I suspect some of these headers aren't even used by the
> driver (sometimes people just include the world for no reason)..

The reason would be convenience, or maintainer efficiency as the Camel
book ("Programming Perl") words it.

If not including the right header file (such as ioctl32.h on x86_64)
breaks the compile, I presume they are needed.

-- 
Matthias Andree

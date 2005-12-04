Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVLDN2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVLDN2V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 08:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVLDN2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 08:28:21 -0500
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:435 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S932213AbVLDN2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 08:28:20 -0500
Date: Sun, 4 Dec 2005 14:28:13 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204132813.GA4769@merlin.emma.line.org>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <1133630556.22170.26.camel@laptopd505.fenrus.org> <20051203230520.GJ25722@merlin.emma.line.org> <43923DD9.8020301@wolfmountaingroup.com> <20051204121209.GC15577@merlin.emma.line.org> <1133699555.5188.29.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133699555.5188.29.camel@laptopd505.fenrus.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Dec 2005, Arjan van de Ven wrote:

> On Sun, 2005-12-04 at 13:12 +0100, Matthias Andree wrote:
> > On Sat, 03 Dec 2005, Jeff V. Merkey wrote:
> > 
> > > These folks have nothing new to innovate here. The memory manager and VM 
> > > gets revamped every other release. Exports get broken, binary only 
> > > module compatibility busted every rev of the kernel. I spend weeks on 
> > 
> > Who cares for binary modules?
> > 
> > It hurts however if external OSS modules are broken.
> 
> then those modules should be submitted realistically. That's just best
> for everyone involved. Which modules in particular do you mean btw?

I meant the ipmi, smbus and copa modules by Fujitsu-Siemens.

They are provided in source form, but I just found out (reading the
headers and not just the lines that broke the compile) they are not open
source. Perhaps one should prod them to slap a modified-BSD or perhaps
GPL label onto their modules.

It seems you'd then maintain them after their submission? :-)

> It's rare even in the 2.6 tree to mass-break well written drivers. Just
> because it's a lot of work to fix all in kernel drivers up. But a fully
> stable API is also not good. My guess is that the drivers that break
> most are the ones using the not-right APIs (eg internals and such). 

These use inter_module_get() (ok, inter_module_get_request isn't
difficult) and some #include headers that have moved around between
linux and asm directories.

-- 
Matthias Andree

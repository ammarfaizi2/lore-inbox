Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTKIKTE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 05:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTKIKTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 05:19:04 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:56335 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262308AbTKIKS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 05:18:58 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] KBUILD 2.5 issues/regressions
Date: Sun, 9 Nov 2003 13:12:56 +0300
User-Agent: KMail/1.5.3
Cc: Alistair J Strachan <alistair@devzero.co.uk>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <E1AHHny-000CwE-00.arvidjaar-mail-ru@f10.mail.ru> <20031106172333.GA1097@mars.ravnborg.org>
In-Reply-To: <20031106172333.GA1097@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311091312.56115.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 November 2003 20:23, Sam Ravnborg wrote:
> > So it is still an issue. I am thinking about some way to direct modpost
> > to extract versions out of /boot/vmlinuz and /lib/modules if it detects
> > pristine distribution sources
> >
> > To recap - currently under Mandrake and RH it is possible to do
> >
> > rpm -i kernel-source
> > cd /external/module/src
> > make
> >
> > and it will automatically create module for currently running kernel as
> > long as kernel is distribution kernel without any extra configuration.
>
> I am in the process of addressing this issue.
> What I plan to do is to provide a script solely for the purpose of building
> modules. This script will be simple but allow us to change the build
> process, without changing the way modules are build.
> In order to use module versioning the distributor needs to ship all
> modules. Otherwise the build process cannot look up a symbol exported
> in module A, used by module B.
>

sure. But distributor already has shipped all the modules as part of kernel 
package. Given the number of different kernels in Mandrake currently shipping 
yet another copy of binary modules for kernel sources would easily fill up 
the whole CD alone.

besides it is not the only problem. Even without MODVERSIONS build process 
attempts to write in temporary directory in kernel build tree making it 
impossible for non-root to build module.

> I have the basics implemented. Building a module with src located
> away from the kernel src, and output files located a third place.
> I simply need some spare time to do the rest....
>
> The idea comes from Kai Germaschewski - but I like it and will try to
> implement it.
>

Could you point to posts that describe this idea? Also we could join efforts 
:)

Thank you

-andrey


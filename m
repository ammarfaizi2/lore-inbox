Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbTKFRXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbTKFRXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:23:39 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:14091 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263793AbTKFRXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:23:36 -0500
Date: Thu, 6 Nov 2003 18:23:33 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Alistair J Strachan <alistair@devzero.co.uk>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC] KBUILD 2.5 issues/regressions
Message-ID: <20031106172333.GA1097@mars.ravnborg.org>
Mail-Followup-To: Andrey Borzenkov <arvidjaar@mail.ru>,
	Alistair J Strachan <alistair@devzero.co.uk>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <E1AHHny-000CwE-00.arvidjaar-mail-ru@f10.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AHHny-000CwE-00.arvidjaar-mail-ru@f10.mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So it is still an issue. I am thinking about some way to direct modpost
> to extract versions out of /boot/vmlinuz and /lib/modules if it detects
> pristine distribution sources
> 
> To recap - currently under Mandrake and RH it is possible to do
> 
> rpm -i kernel-source
> cd /external/module/src
> make
> 
> and it will automatically create module for currently running kernel as long
> as kernel is distribution kernel without any extra configuration.

I am in the process of addressing this issue.
What I plan to do is to provide a script solely for the purpose of building
modules. This script will be simple but allow us to change the build process,
without changing the way modules are build.
In order to use module versioning the distributor needs to ship all
modules. Otherwise the build process cannot look up a symbol exported
in module A, used by module B.

I have the basics implemented. Building a module with src located
away from the kernel src, and output files located a third place.
I simply need some spare time to do the rest....

The idea comes from Kai Germaschewski - but I like it and will try to
implement it.

	Sam

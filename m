Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbTISQMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 12:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTISQMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 12:12:15 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:55022 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S261612AbTISQMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 12:12:13 -0400
Subject: Re: Make modules_install doesn't create /lib/modules/$version
From: Martin Schlemmer <azarah@gentoo.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Rusty Russell <rusty@rustcorp.com.au>, "Randy.Dunlap" <rddunlap@osdl.org>,
       rob@landley.net, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <16234.51231.312249.132103@gargle.gargle.HOWL>
References: <20030919024455.834992C0F1@lists.samba.org>
	 <1063950080.5491.10.camel@workshop.saharacpt.lan>
	 <16234.51231.312249.132103@gargle.gargle.HOWL>
Content-Type: text/plain
Message-Id: <1063987305.5491.21.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 19 Sep 2003 18:01:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-19 at 11:10, Mikael Pettersson wrote:
> Martin Schlemmer writes:
>  > On Fri, 2003-09-19 at 04:25, Rusty Russell wrote:
>  > > In message <20030918091511.276309a6.rddunlap@osdl.org> you write:
>  > > > On Thu, 18 Sep 2003 03:21:40 -0400 Rob Landley <rob@landley.net> wrote:
>  > > > 
>  > > > | I've installed -test3, -test4, and now -test5, and each time make 
>  > > > | modules_install died with the following error:
>  > > > | 
>  > > > | Kernel: arch/i386/boot/bzImage is ready
>  > > > | sh arch/i386/boot/install.sh 2.6.0-test5 arch/i386/boot/bzImage System.map ""
>  > > > | /lib/modules/2.6.0-test5 is not a directory.
>  > > 
>  > > Looks like arch/i386/boot/install.sh is calling ~/bin/installkernel or
>  > > /sbin/installkernel, which is not creating the directory.
>  > > 
>  > > Should depmod create the directory?  It can, of course, but AFAICT the
>  > > old one didn't.
>  > > 
>  > > Maybe a RedHat issue?
>  > > 
>  > 
>  > Likely, it works fine here with the one we are using
>  > from debianutils.
> 
> So how come it's never been a problem on my RH boxes?
> (Currently RH9 + module-init-tools but none of Arjan's .rpms)
> 
> I basically do
> make bzImage modules |& tee /tmp/log
> grep Warning /tmp/log
> su
> make modules_install
> make install
> 
> Creating the /lib/modules/<version> directory is the kernel's
> job, not installkernel (it's never done that before).

Yes, OK, so I have not checked =)  I just reacted on if
installkernel form non RH misbehave or not.

So what have you tried up to now ?  Does there even
exist a /lib/modules/2.6.0-test5 ?  If so, is it an file/something
else ?  What happens if you create it manually beforehand ?

Else have a look at scripts/Makefile.modinst and maybe add
a few @echo's.  I have not looked that closely at the build
system yet.


-- 
Martin Schlemmer



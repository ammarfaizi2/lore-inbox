Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVAXUKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVAXUKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVAXUKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:10:33 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:57045 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261608AbVAXUKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:10:20 -0500
Date: Mon, 24 Jan 2005 23:28:51 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, Adrian Bunk <bunk@stusta.de>,
       Jurriaan <thunder7@xs4all.nl>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050124232851.1968d8d1@zanzibar.2ka.mipt.ru>
In-Reply-To: <d120d500050124113214195863@mail.gmail.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	<20050124175449.GK3515@stusta.de>
	<20050124214336.2c555b53@zanzibar.2ka.mipt.ru>
	<20050124184111.GA9335@middle.of.nowhere>
	<20050124222302.6f962097@zanzibar.2ka.mipt.ru>
	<20050124190546.GP3515@stusta.de>
	<20050124223925.76cabedd@zanzibar.2ka.mipt.ru>
	<d120d500050124113214195863@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 14:32:19 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> > > > > lsmod in bugreports giving unspecific results, for example.
> > > >
> > > > If you load scx200 from superio subsystem, then obviously you can not
> > > > use old i2c/acb modules which require old scx200.
> > > > And vice versa.
> > > >
> > > > One needs to load exactly what he wants.
> > >
> > > You did not understand what Jurriaan said:
> > >
> > > Even if it was working, "lsmod" would not be able to tell which of the
> > > two modules was loaded.
> > >
> > > This would cause much headache for many people.
> > 
> > 
> > Module is just a piece of code, or programm if someone may think.
> > And there no problems when we type
> > $ ps
> > and see only "aterm", if someone wants to know what exactly means "aterm",
> > one can run ps axufw.
> > And even with the case of lsmod: one can see that scx200 will or will not
> > depend on superio, and that will explain everything.

Before I murdered in my bad, I want to say, that I agree that changing 
scx200 into scx is easier and probably better idea.
And I will do it(I am doing it right now),

> There are so many problems and ambiguites with having non-unique
> module names it is not even funny:
> - when I modprobe scx200 what willI get?

Sorry or answering with a question, but what will you run when typing 
aterm in your shell?
Is it simlink to xterm, or /bin/aterm, or /usr/local/bin/aterm?
It depends on $PATH, with modprobe it depends on something else...
Bug? Probably. Feature? Maybe. I do not complain.

> - if I want to blacklist one of the modules (let's say hotplug) how do
> I do that?

When you want to run exact program, you type the whole path, no?
Load exact modules with known-to-be-good pathes.
I can hack shell script over modprobe to warn if there are several modules 
with the same name, and ask exact path or something...

> - lsmod (with everything else compiled in, possible?) - which one is loadded?

/sbin/modinfo shows enough information about module to distingiush one from another.

> ...etc, etc...


I understand your point of view, and can say, that the same module names are not 
very convenient and some times even confused, but it is not a cause to kill
such idea and mark it as badly broken.
It is right thing, it just currently has some nitpicks, nothing more, noone complains
that modules for different kernel versions have the same name, but different
elf sections in it, it is of course different things, but they do have the same 
roots in common.

As I have beed told in private, 
"what is technically possible, is not necessarily practically useful.", probably
it is the essence.

Thank you for discussion.
 
> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt

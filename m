Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVAXTfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVAXTfe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVAXTdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:33:54 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:26607 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261603AbVAXTcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:32:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kPiVa0GeTEC68IH74omsCzLF63KCyoPzjPyYPfwii/bSA6q3jEEt22HIfyimd6cHX8Wiq6ag7y+F+dvnAfKeh0dDUj2Qjh3D80Ytx4joN4ZR36pVpSP2+EvEzeitl9or6M3T9008JZjedTvHDrPM7Mz4PO1r8A8YflpNcVrDiLY=
Message-ID: <d120d500050124113214195863@mail.gmail.com>
Date: Mon, 24 Jan 2005 14:32:19 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Cc: Adrian Bunk <bunk@stusta.de>, Jurriaan <thunder7@xs4all.nl>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050124223925.76cabedd@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050124175449.GK3515@stusta.de>
	 <20050124214336.2c555b53@zanzibar.2ka.mipt.ru>
	 <20050124184111.GA9335@middle.of.nowhere>
	 <20050124222302.6f962097@zanzibar.2ka.mipt.ru>
	 <20050124190546.GP3515@stusta.de>
	 <20050124223925.76cabedd@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 22:39:25 +0300, Evgeniy Polyakov
<johnpol@2ka.mipt.ru> wrote:
> On Mon, 24 Jan 2005 20:05:46 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > On Mon, Jan 24, 2005 at 10:23:02PM +0300, Evgeniy Polyakov wrote:
> > > On Mon, 24 Jan 2005 19:41:11 +0100
> > > Jurriaan <thunder7@xs4all.nl> wrote:
> > >
> > > > From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> > > > Date: Mon, Jan 24, 2005 at 09:43:36PM +0300
> > > > > On Mon, 24 Jan 2005 18:54:49 +0100
> > > > > Adrian Bunk <bunk@stusta.de> wrote:
> > > > >
> > > > > > It seems noone who reviewed the SuperIO patches noticed that there are
> > > > > > now two modules "scx200" in the kernel...
> > > > >
> > > > > They are almost mutually exlusive(SuperIO contains more advanced),
> > > > > so I do not see any problem here.
> > > > > Only one of them can be loaded in a time.
> > > > >
> > > > > So what does exactly bother you?
> > > > >
> > > > lsmod in bugreports giving unspecific results, for example.
> > >
> > > If you load scx200 from superio subsystem, then obviously you can not
> > > use old i2c/acb modules which require old scx200.
> > > And vice versa.
> > >
> > > One needs to load exactly what he wants.
> >
> > You did not understand what Jurriaan said:
> >
> > Even if it was working, "lsmod" would not be able to tell which of the
> > two modules was loaded.
> >
> > This would cause much headache for many people.
> 
> 
> Module is just a piece of code, or programm if someone may think.
> And there no problems when we type
> $ ps
> and see only "aterm", if someone wants to know what exactly means "aterm",
> one can run ps axufw.
> And even with the case of lsmod: one can see that scx200 will or will not
> depend on superio, and that will explain everything.
> 

There are so many problems and ambiguites with having non-unique
module names it is not even funny:
- when I modprobe scx200 what willI get?
- if I want to blacklist one of the modules (let's say hotplug) how do
I do that?
- lsmod (with everything else compiled in, possible?) - which one is loadded?

...etc, etc...

-- 
Dmitry

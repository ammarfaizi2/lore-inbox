Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSK0JzJ>; Wed, 27 Nov 2002 04:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbSK0JzI>; Wed, 27 Nov 2002 04:55:08 -0500
Received: from [81.2.122.30] ([81.2.122.30]:5124 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261894AbSK0JzH>;
	Wed, 27 Nov 2002 04:55:07 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200211271012.gARACl1C000335@darkstar.example.net>
Subject: Re: A Kernel Configuration Tale of Woe
To: cate@debian.org (Giacomo Catenazzi)
Date: Wed, 27 Nov 2002 10:12:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DE485C5.8080309@debian.org> from "Giacomo Catenazzi" at Nov 27, 2002 09:43:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This demonstrates a very important point - _any_ automatic
> > configuration program is likely to cause more traffic to this mailing
> > list, and create more work for users and developers that the current
> > automatic configuration process:
> >
> > echo 'My box doesn't boot' | mail linux-kernel@vger.kernel.org
> >
> > The kernel knows nothing about motherboards, cards, etc.  It knows
> > about chipsets, and nothing else.  By definition, you cannot have a
> > kernel configurator that works at a higher level than that.
> 
> I disagree. When we have a booting kernel, finding out the used drivers
> is not so difficult: kernel give us already enough informations (modules
> loaded, in drivers that use some resources,...).

OK, so you can analyse the data from a fully modular kernel, then use
that information to build a kernel with just the required hardware
support built in.

That will tell you what drivers are in use for the chipsets that are
present on your devices.  If you remove your foobar ethernet adaptor,
and replace it with a foobar ethernet adaptor from the same
manufacturer, it may stop working.  It doesn't achieve what the
original poster wanted.

The problem is that when it doesn't work, and somebody posts to this
list saying that it doesn't work, I strongly suspect that it's going
to be a lot more time consuming figuring out why, then just telling
them which option needs to be set in their .config.

> The problem is: what will be the use of such minimalistic/optimal but
> non-modular kernel?

Well, I use non-modular kernels by default, mainly because Linux
didn't have modular support when I first used it, and I don't really
find the need for them.  Most desktop users find them indispenable,
though.

> If I add a new device (such a modem, a printer, new USB device...) or
> if I use a new disk with an other FS, the users of an autoconfiguration
> will be lost, but not the users of the vendors kernels.
> 
> Thus the real problem is: where will use such autoconfiguration? Why?
> IMHO it can be used only by expert, to find what drivers is need for
> such device (when hotplug cannot help you).

There already is a kind of autoconfiguration - reading the help text
for each option in xconfig usually says, "If you're not sure say
[Y|N|M]".  Why doesn't the new xconfig just have the ability to set
all of the options the the recommended ones?

John

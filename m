Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVA2Xke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVA2Xke (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVA2Xke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:40:34 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:29861 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261604AbVA2XkP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:40:15 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
Date: Sat, 29 Jan 2005 18:40:12 -0500
User-Agent: KMail/1.7.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home> <200501291750.50886.dtor_core@ameritech.net> <Pine.LNX.4.61.0501300008381.6118@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501300008381.6118@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501291840.12694.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 January 2005 18:20, Roman Zippel wrote:
> Hi,
> 
> On Sat, 29 Jan 2005, Dmitry Torokhov wrote:
> 
> > On Saturday 29 January 2005 17:20, Roman Zippel wrote:
> > > --- linux-2.6.11.orig/drivers/input/serio/Kconfig       2005-01-29 22:50:43.404946203 +0100
> > > +++ linux-2.6.11/drivers/input/serio/Kconfig    2005-01-29 22:56:42.549085439 +0100
> > > @@ -3,6 +3,7 @@
> > >  #
> > >  config SERIO
> > >         tristate "Serial i/o support" if EMBEDDED || !X86
> > > +       depends on INPUT
> > 
> > ????
> > 
> > serio_raw works fine without INPUT.
> 
> All current serio users depend on INPUT, it's maybe not a strict 
> dependency, but it pretty much needs INPUT anyway to be usable, so I don't 
> see the problem.
> The alternative is to move it completely out of the input menu, if it's 
> really that important for the user being able to select it without input.
> 

I can assure you that serio_raw driver _does not_ use input system - it is
implementation of pre 2.6 /dev/psaux interface giving you access to raw AUX
data. It was written so we can still use PS/2 devices for which we don't have
proper in-kernel driver but have working userspace solution. It completely
bypasses input layer.
 
-- 
Dmitry

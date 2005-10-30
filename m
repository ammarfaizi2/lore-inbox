Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVJ3XRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVJ3XRj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 18:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVJ3XRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 18:17:39 -0500
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:19631 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932403AbVJ3XRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 18:17:38 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: SPARC64: Configuration offers keyboards that don't make sense
Date: Sun, 30 Oct 2005 18:17:32 -0500
User-Agent: KMail/1.8.3
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>
References: <200510300326.j9U3QXeT027101@inti.inf.utfsm.cl>
In-Reply-To: <200510300326.j9U3QXeT027101@inti.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510301817.33363.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 October 2005 22:26, Horst von Brand wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > On Friday 28 October 2005 19:06, Horst von Brand wrote:
> > > Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> > > > On Fri, 2005-10-28 17:09:31 -0300, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> 
> [...]
> 
> > > > > Also, configuring this one gives a non-functional keyboard (the
> > > > > machine is running, I can log in over SSH, but keypresses have no
> > > > > effect at all).
> 
> > > > Did the serial port register serio ports?
> 
> > > How can I find this out?
> 
> > Just post your dmesg..
> 
> Nothing relevant I can see.
> 
> >                        Or ssh into it and poke around /sys/bus/serio...
> 
> Got /sys/sun/bus/serio/drivers/subkbd/ with several files inside
>

BUt nothing in /sys/bus/serio/devices, right? That means you don't have any
serial port drivers loaded so sunkbd does not have aport to attach to.

> > Sun keyboard can be autodetected AFAIK so you don't need to fiddle with
> > inputattach.
> 
> The setup works for the shipped Aurora kernel, but to compile that
> configuration would take a few days...
> 
> >              Do you have sunsu or sunzilog drivers selected?
> 
> SUNZILOG is module, and is not loaded right now. No serials in use.

Please try loading it (or compile it in).

-- 
Dmitry

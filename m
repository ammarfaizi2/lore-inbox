Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267540AbUI1FeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbUI1FeR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 01:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267542AbUI1FeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 01:34:17 -0400
Received: from digitalimplant.org ([64.62.235.95]:4321 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S267540AbUI1FeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 01:34:11 -0400
Date: Mon, 27 Sep 2004 22:34:03 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: "Zhu, Yi" <yi.zhu@intel.com>
cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       "" <linux-kernel@vger.kernel.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Oliver Neukum <oliver@neukum.org>
Subject: RE: suspend/resume support for driver requires an external firmware
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD57A0@pdsmsx403>
Message-ID: <Pine.LNX.4.50.0409272232330.24893-100000@monsoon.he.net>
References: <3ACA40606221794F80A5670F0AF15F8403BD57A0@pdsmsx403>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Sep 2004, Zhu, Yi wrote:

> Patrick Mochel wrote:

> > As far as the firmware goes, there are two choices - reload
> > it from userspace once we return or save it memory during
> > suspend. I assume that these devices provide some means for
> > reading the firmware from them, so you can just allocate a
> > buffer and read it into that during the transition.
>
> Agreed. I think now we need a clean interface that makes
> drivers, swsusp or even the end user to work together to
> finally achieve the goal.

Well, if you can read firmware back from the device, then that interface
is called kmalloc() to allocate the buffer, and whatever driver-specific
routine to copy it from the device into that buffer. It then stays in
memory during suspend and can be rewritten to the device once resumed.

What's so bad about that?


	Pat

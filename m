Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWDRPlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWDRPlU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 11:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWDRPlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 11:41:20 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:9408 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932282AbWDRPlR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 11:41:17 -0400
Subject: Re: [RFC] binary firmware and modules
From: Marcel Holtmann <marcel@holtmann.org>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Jon Masters <jonathan@jonmasters.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200604181659.04657.duncan.sands@math.u-psud.fr>
References: <1145088656.23134.54.camel@localhost.localdomain>
	 <200604181537.47183.duncan.sands@math.u-psud.fr>
	 <1145370171.10255.58.camel@localhost>
	 <200604181659.04657.duncan.sands@math.u-psud.fr>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 17:41:18 +0200
Message-Id: <1145374878.10255.69.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Duncan,

> > we have two kind of devices that need firmware download. The easy and
> > clean ones which need one or two files and these basically change not
> > that often. In most cases these are the network or storage devices and
> > for exactly these we need the MODULE_FIRMWARE() support to know which
> > files have to be put into initrd.
> 
> > The messed up devices like the Speedtouch and maybe even some WiFi
> > dongles are another story.
> 
> I don't know why you consider the speedtouch to be messed up.  What's
> messed up is not the modems themselves, but the fact that we don't know
> what modems exist, and how they differ in their firmware requirements.

if you don't know the firmware requirements, then this is what I call
messed up. I now that this is basically the fault of the manufacturer or
missing specifications, but wild guessing on the firmware doesn't really
help. A kernel driver should know which firmware it needs.

> Anyway, speedtouch users also need their firmware to end up in any initrd.
> Since the driver expects all firmware files to start with "speedtch",
> the MODULE_FIRMWARE scheme would work for the speedtouch driver too as
> long as it allows the driver to specify just the initial part of a file
> name.  You could go all the way to regular expressions, but that seems
> a bit ridiculous.

I personally prefer full firmware names. This makes the dependency easy
and even an end user can call modinfo and see what firmware is expected
by a certain driver (without looking at the source code).

Regards

Marcel



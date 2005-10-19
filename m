Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVJVRBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVJVRBc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVJVRBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:01:32 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:13456
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750735AbVJVRBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:01:32 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: kronos@kronoz.cjb.net
Subject: Re: ipw2200 only works as a module?
Date: Wed, 19 Oct 2005 16:35:12 -0500
User-Agent: KMail/1.8
Cc: Keenan Pepper <keenanpepper@gmail.com>, linux-kernel@vger.kernel.org
References: <20050926171220.GA9341@dreamland.darkstar.lan>
In-Reply-To: <20050926171220.GA9341@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510191635.13253.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 September 2005 12:12, Luca wrote:
> Keenan Pepper <keenanpepper@gmail.com> ha scritto:
> > With CONFIG_IPW2200=y I get:
> >
> > ipw2200: ipw-2.2-boot.fw load failed: Reason -2
> > ipw2200: Unable to load firmware: 0xFFFFFFFE
> >
> > but with CONFIG_IPW2200=m it works fine. If it doesn't work when built
> > into the kernel, why even give people the option?
> >
> > BTW, a better error message than "Reason -2" would be nice. =)
>
> -2 is -ENOENT (no such file or directory). ipw2000 requests its firmware
> using a hotplug event, but when the driver is compiled into the kernel
> it gets loaded _before_ the root fs is mounted and of course the hotplug
> system and the firmware are not available.

Any possibility of extracting initramfs early enough that the firmware could 
live in there when this sucker's built in?

Rob

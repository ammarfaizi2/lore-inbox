Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVGTNCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVGTNCL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 09:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVGTNCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 09:02:11 -0400
Received: from mail.portrix.net ([212.202.157.208]:5093 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261191AbVGTNCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 09:02:05 -0400
Message-ID: <42DE4B44.80504@ppp0.net>
Date: Wed, 20 Jul 2005 15:01:56 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mundt <lethal@Linux-SH.ORG>
CC: snogglethorpe@gmail.com, miles@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: defconfig for v850, please
References: <42DE17DC.7050506@ppp0.net> <fc339e4a05072002355e4062d6@mail.gmail.com> <42DE1DDE.90503@ppp0.net> <fc339e4a0507200302d9f0141@mail.gmail.com> <20050720115218.GB9754@linux-sh.org>
In-Reply-To: <20050720115218.GB9754@linux-sh.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt wrote:
> On Wed, Jul 20, 2005 at 07:02:53PM +0900, Miles Bader wrote:
> 
>>Some archs seem to provide defconfigs for various different platforms,
>>which seems nice, and there seems to be some sort of framework for
>>doing this, but ...
>>
> 
> For most of the architectures aimed at embedded systems, having an
> arch/foo/defconfig makes no sense. The basic "framework" is to have

Still, for basic compile testing and testing patches on other
architectures it would be nice, when the patch writer can test his/her
patch with a simple defconfig, without knowing a common platform for
this target arch.
So please include a defconfig with a reasonable common set of CONFIG_*
options. It's about testing the core of the architecure not about
random driver failures.

> arch/foo/configs and place all of your board-specific defconfigs in there
> (as boardname_defconfig -- the reason for this is that you get free make
> targets of the same name which copy the defconfig over, see 'make help').
> 
> If you have a particular board that you can assume will be kept
> reasonably up-to-date, you can set KBUILD_DEFCONFIG in your Makefile to
> set the default config to use by name, and then you can forego having an
> arch/foo/defconfig entirely (you can look at sh and some of the other
> architectures to see this being done).

arm is another one which uses this style, ia64 for example uses configs/*
and defconfig. But on arm and sh `make defconfig` works contrary to v850.

Thanks,

-- 
Jan

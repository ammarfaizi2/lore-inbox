Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277074AbRJQTeQ>; Wed, 17 Oct 2001 15:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277094AbRJQTeG>; Wed, 17 Oct 2001 15:34:06 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:27008
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S277074AbRJQTdw>; Wed, 17 Oct 2001 15:33:52 -0400
Date: Wed, 17 Oct 2001 12:34:08 -0700
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200110171934.f9HJY8w01260@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: pierre@lineo.com
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <3BCDE77F.D1B164A@lineo.com>
In-Reply-To: <Pine.LNX.4.10.10110171126480.5821-100000@innerfire.net> <3BCDE77F.D1B164A@lineo.com>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, Pierre-Philippe Coupard wrote:

> The kernel doesn't actually do anything with the "tainted" flag,
> insmod does. So you have to compile things as module and insmod
> them, and insmod will dump a message if the MODULE_LICENSE thing
> isn't in the module. If you compile things inside the kernel instead
> of modules, you will see nothing and /proc/sys/kernel/tainted will
> contain 0, which is wrong.

I think the idea is that if you compile something inside the kernel,
you have the source, so at least from the debugging point of view, the
kernel has not been tainted by a binary-only module.

It seems like people (collectively) have two different purposes in
mind for /proc/sys/kernel/tainted: ensuring that only "open source"
modules are used, for debugging purposes, and ensuring that only
"GPL-compatible" modules are used, for possible legal purposes.  If
both of these are desirable, perhaps the two purposes should be
separated into two /proc files?

Cheers, Wayne


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbTJXV6L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 17:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbTJXV6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 17:58:10 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:4032 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262667AbTJXV6J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 17:58:09 -0400
Date: Fri, 24 Oct 2003 17:58:08 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: dleonard@dleonard.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Copying .config to /lib/modules/`uname -r`/kernel
In-Reply-To: <Pine.LNX.4.31.0310241423120.24862-100000@nymph.dleonard.net>
Message-ID: <Pine.LNX.4.56.0310241744430.4182@marabou.research.att.com>
References: <Pine.LNX.4.31.0310241423120.24862-100000@nymph.dleonard.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Oct 2003 dleonard@dleonard.net wrote:

> Personally I like to put it in the same place as the kernel itself and
> the System.map.  Then I tack the full version number on the end just
> like I do with System.map.  Even for non-modular kernels it is
> frequently convenient to have access to the .config so when you boot up
> a random isolinux CD you know exactly what support you are going to
> have.

Yes, I actually found that scripts/mkspec and scripts/kconfig/confdata.c
in the Linux source already know about /boot/config-`uname -r`, so it's
not just a Red Hat specific thing.  I didn't make enough research.

It looks like the interface to /sbin/installkernel is not very flexible as
it doesn't get .config as an argument.  Anyway, I can provide a patch to
install .config to /boot/config-`uname -r` for all architectures if
anybody is interested.

-- 
Regards,
Pavel Roskin

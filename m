Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWENRIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWENRIa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 13:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWENRIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 13:08:30 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:49336 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1750861AbWENRI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 13:08:29 -0400
Date: Sun, 14 May 2006 18:08:27 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Frederic Rible <frible@teaser.fr>,
       Jean-Paul Roubelat <jpr@f6fbb.org>, linux-hams@vger.kernel.org
Subject: Re: [PATCH] fix potential NULL pointer dereference in yam
Message-ID: <20060514170827.GA24169@linux-mips.org>
References: <200605141512.50923.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605141512.50923.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 03:12:50PM +0200, Jesper Juhl wrote:

> Testing a pointer for NULL after it has already been dereferenced is not
> very safe.
> Patch below to rework yam_open() so that `dev' is not dereferenced until
> after it has been tested for NULL.

It may not obvious and that itself is some sort of bug bug netdev_priv()
assumes that the private part of struct netdev has been allocated
immediately following struct netdev, so the macro will compile into just
pointer arithmetic.  So no possible NULL pointer dereference here.

  Ralf

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269754AbUJVNwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269754AbUJVNwN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269755AbUJVNwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:52:13 -0400
Received: from mail1.kontent.de ([81.88.34.36]:37346 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S269754AbUJVNu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:50:59 -0400
Subject: Re: BT848 video support dropped in 2.6.9?
From: Markus Trippelsdorf <markus@trippelsdorf.net>
To: linux-kernel@vger.kernel.org, kernel@kolivas.org
In-Reply-To: <1098447230.12289.12.camel@localhost>
References: <1098447230.12289.12.camel@localhost>
Content-Type: text/plain
Date: Fri, 22 Oct 2004 15:50:57 +0200
Message-Id: <1098453057.1099.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 22:19 +1000, Con Kolivas wrote: 
> Markus Trippelsdorf wrote:
> > The "BT848 video for linux" item does not show up
> > with menuconfig in the "Video for linux" category.
> > It was there in all previous kernels that I've used.
> > Am I missing something obvious?
> 
> config VIDEO_BT848
> 	depends on VIDEO_DEV && PCI && I2C && FW_LOADER
> 
> Therefore you need those options or else you wont even be allowed to try 
> to turn the option on.

Thanks Con. 
The FW_LOADER option is new. In previous kernels the driver
depended on:
config VIDEO_BT848
tristate "BT848 Video For Linux"
depends on VIDEO_DEV && PCI && I2C && SOUND

I think the FW_LOADER dependency is there by mistake.
So I just edited the drivers/video/Kconfig file and replaced
FW_LOADER with SOUND. Everything is working as expected now.

Markus


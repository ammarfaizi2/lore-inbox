Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbUBRCp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 21:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267178AbUBRCp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 21:45:26 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:18960 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267190AbUBRCpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 21:45:23 -0500
Date: Wed, 18 Feb 2004 03:45:09 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, GCS <gcs@lsc.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, vandrove@vc.cvut.cz
Subject: Re: Linux 2.6.3-rc4
In-Reply-To: <20040217225905.GQ1308@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0402180337100.7851@serv>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
 <20040217184543.GA18495@lsc.hu> <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
 <20040217200545.GP1308@fs.tum.de> <Pine.LNX.4.58.0402171214230.2154@home.osdl.org>
 <20040217225905.GQ1308@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 17 Feb 2004, Adrian Bunk wrote:

> @@ -548,7 +544,8 @@
>
>  config FB_MATROX_I2C
>  	tristate "Matrox I2C support"
> -	depends on FB_MATROX && I2C
> +	depends on FB_MATROX
> +	select I2C
>  	select I2C_ALGOBIT
>  	---help---
>  	  This drivers creates I2C buses which are needed for accessing the

This was okay, this is a tristate and limited by I2C, so it will select
I2C_ALGOBIT correctly.

>  config FB_RADEON_I2C
>  	bool "DDC/I2C for ATI Radeon support"
> -	depends on FB_RADEON && I2C
> +	depends on FB_RADEON
> +	select I2C
>  	select I2C_ALGOBIT
>  	default y
>  	help

Linus, I think that's the best solution for now. I have to think a bit
more about the problem, how a boolean symbol should select a tristate
symbol.

bye, Roman

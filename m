Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271369AbTG2J6g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271371AbTG2J6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:58:35 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16900 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S271369AbTG2J6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:58:33 -0400
Date: Tue, 29 Jul 2003 11:58:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Michael Hunold <hunold@convergence.de>
cc: linux-kernel@vger.kernel.org, <alan@lxorguk.ukuu.org.uk>,
       <torvalds@osdl.org>
Subject: Re: [PATCH 1/6] [DVB] Kconfig and Makefile updates
In-Reply-To: <10594710302828@convergence.de>
Message-ID: <Pine.LNX.4.44.0307291153340.717-100000@serv>
References: <10594710302828@convergence.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 29 Jul 2003, Michael Hunold wrote:

>  config VIDEO_SAA7146
>          tristate
> -        default y if DVB_AV7110=y || DVB_BUDGET=y || DVB_BUDGET_AV=y || VIDEO_MXB=y || VIDEO_DPC=y
> -        default m if DVB_AV7110=m || DVB_BUDGET=m || DVB_BUDGET_AV=m || VIDEO_MXB=m || VIDEO_DPC=m
> -        depends on VIDEO_DEV && PCI
> +        default y if DVB_AV7110=y || DVB_BUDGET=y || DVB_BUDGET_AV=y || VIDEO_MXB=y || VIDEO_DPC=y || VIDEO_HEXIUM_ORION=y || VIDEO_HEXIUM_GEMINI=y
> +        default m if DVB_AV7110=m || DVB_BUDGET=m || DVB_BUDGET_AV=m || VIDEO_MXB=m || VIDEO_DPC=m || VIDEO_HEXIUM_ORION=m || VIDEO_HEXIUM_GEMINI=m
> +        depends on VIDEO_DEV && PCI && I2C

You can change this also into:

config VIDEO_SAA7146
	def_tristate DVB_AV7110 || DVB_BUDGET || DVB_BUDGET_AV || \
		     VIDEO_MXB || VIDEO_DPC || VIDEO_HEXIUM_ORION || \
		     VIDEO_HEXIUM_GEMINI
	depends on VIDEO_DEV && PCI && I2C

bye, Roman


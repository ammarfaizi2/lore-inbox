Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271374AbTG2KF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 06:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271375AbTG2KF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 06:05:28 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:52140 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S271374AbTG2KFK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 06:05:10 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01BF88A1@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH 1/6] [DVB] Kconfig and Makefile updates
Date: Tue, 29 Jul 2003 12:05:04 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman,

	Does \t a standard for menu entries definition ? I keep seeing
multiple spaces in some places which can be troublesome to kernelServer for
instance.

Regards,
Fabian

-----Message d'origine-----
De : Roman Zippel [mailto:zippel@linux-m68k.org]
Envoyé : mardi 29 juillet 2003 11:58
À : Michael Hunold
Cc : linux-kernel@vger.kernel.org; alan@lxorguk.ukuu.org.uk;
torvalds@osdl.org
Objet : Re: [PATCH 1/6] [DVB] Kconfig and Makefile updates


Hi,

On Tue, 29 Jul 2003, Michael Hunold wrote:

>  config VIDEO_SAA7146
>          tristate
> -        default y if DVB_AV7110=y || DVB_BUDGET=y || DVB_BUDGET_AV=y ||
VIDEO_MXB=y || VIDEO_DPC=y
> -        default m if DVB_AV7110=m || DVB_BUDGET=m || DVB_BUDGET_AV=m ||
VIDEO_MXB=m || VIDEO_DPC=m
> -        depends on VIDEO_DEV && PCI
> +        default y if DVB_AV7110=y || DVB_BUDGET=y || DVB_BUDGET_AV=y ||
VIDEO_MXB=y || VIDEO_DPC=y || VIDEO_HEXIUM_ORION=y || VIDEO_HEXIUM_GEMINI=y
> +        default m if DVB_AV7110=m || DVB_BUDGET=m || DVB_BUDGET_AV=m ||
VIDEO_MXB=m || VIDEO_DPC=m || VIDEO_HEXIUM_ORION=m || VIDEO_HEXIUM_GEMINI=m
> +        depends on VIDEO_DEV && PCI && I2C

You can change this also into:

config VIDEO_SAA7146
	def_tristate DVB_AV7110 || DVB_BUDGET || DVB_BUDGET_AV || \
		     VIDEO_MXB || VIDEO_DPC || VIDEO_HEXIUM_ORION || \
		     VIDEO_HEXIUM_GEMINI
	depends on VIDEO_DEV && PCI && I2C

bye, Roman

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

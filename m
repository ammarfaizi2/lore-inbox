Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWJMPqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWJMPqa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 11:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWJMPqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 11:46:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:2254 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751323AbWJMPqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 11:46:30 -0400
Subject: Re: [PATCH 2.6.18] hda_intel: add ATI RS690 HDMI audio support
From: Lee Revell <rlrevell@joe-job.com>
To: Luugi Marsan <lmarsan@ati.com>
Cc: linux-kernel@vger.kernel.org,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <3AF59FEEF017114286E7EF94EEC971B5599E67@TORCAEXMB3.atitech.com>
References: <3AF59FEEF017114286E7EF94EEC971B5599E67@TORCAEXMB3.atitech.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 11:47:25 -0400
Message-Id: <1160754446.4201.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-13 at 11:38 -0400, Luugi Marsan wrote:
> This patch adds support for the HDMI codec of the ATI RS690 IGP
> northbridge.
> 
> Signed-off-by: Felix Kuehling <fkuehlin@ati.com>
> 

- Patch is word-wrapped
- ALSA patches should go to alsa-devel at lists.sourceforge.net

Lee

> diff -urN vanilla/sound/pci/hda/hda_intel.c
> linux-2.6.18.x86_64/sound/pci/hda/hda_intel.c
> --- vanilla/sound/pci/hda/hda_intel.c	2006-09-19 23:42:06.000000000
> -0400
> +++ linux-2.6.18.x86_64/sound/pci/hda/hda_intel.c	2006-09-26
> 04:24:02.000000000 -0400
> @@ -83,6 +83,7 @@
>  			 "{ATI, SB450},"
>  			 "{ATI, SB600},"
>  			 "{ATI, RS600},"
> +			 "{ATI, RS690},"
>  			 "{VIA, VT8251},"
>  			 "{VIA, VT8237A},"
>  			 "{SiS, SIS966},"
> @@ -1637,6 +1638,7 @@
>  	{ 0x1002, 0x437b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI
> }, /* ATI SB450 */
>  	{ 0x1002, 0x4383, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI
> }, /* ATI SB600 */
>  	{ 0x1002, 0x793b, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> AZX_DRIVER_ATIHDMI }, /* ATI RS600 HDMI */
> +	{ 0x1002, 0x7919, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> AZX_DRIVER_ATIHDMI }, /* ATI RS690 HDMI */
>  	{ 0x1106, 0x3288, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_VIA
> }, /* VIA VT8251/VT8237A */
>  	{ 0x1039, 0x7502, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_SIS
> }, /* SIS966 */
>  	{ 0x10b9, 0x5461, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ULI
> }, /* ULI M5461 */
> diff -urN vanilla/sound/pci/hda/patch_atihdmi.c
> linux-2.6.18.x86_64/sound/pci/hda/patch_atihdmi.c
> --- vanilla/sound/pci/hda/patch_atihdmi.c	2006-09-19
> 23:42:06.000000000 -0400
> +++ linux-2.6.18.x86_64/sound/pci/hda/patch_atihdmi.c	2006-09-26
> 04:23:27.000000000 -0400
> @@ -161,5 +161,6 @@
>   */
>  struct hda_codec_preset snd_hda_preset_atihdmi[] = {
>  	{ .id = 0x1002793c, .name = "ATI RS600 HDMI", .patch =
> patch_atihdmi },
> +	{ .id = 0x1002791a, .name = "ATI RS690 HDMI", .patch =
> patch_atihdmi },
>  	{} /* terminator */
>  };
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


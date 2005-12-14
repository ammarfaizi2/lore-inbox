Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVLNWBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVLNWBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVLNWBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:01:40 -0500
Received: from bno-84-242-95-19.nat.karneval.cz ([84.242.95.19]:64136 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S965009AbVLNWBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:01:40 -0500
Message-ID: <43A09627.60106@liberouter.org>
Date: Wed, 14 Dec 2005 23:01:11 +0100
From: Jiri Slaby <slaby@liberouter.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?UmVuw6kgUmViZQ==?= <rene@exactcode.de>
CC: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] cs5536 ID for cs5535audio
References: <200512141431.32685.rene@exactcode.de>
In-Reply-To: <200512141431.32685.rene@exactcode.de>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

René Rebe napsal(a):
> Hi all,
> 
> relative to 2.6.15-rc5-mm2 / alsa-cvs, works for me:
> 
> Added AMD CS5536 to the cs5535audio driver.
> 
> Signed-off-by: René Rebe <rene@exactcode.de>
> 
> --- sound/pci/cs5535audio/cs5535audio.c.orig	2005-12-14 14:39:11.000000000 +0100
> +++ sound/pci/cs5535audio/cs5535audio.c	2005-12-14 14:29:23.000000000 +0100
> @@ -46,8 +46,10 @@
>  static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
>  
>  static struct pci_device_id snd_cs5535audio_ids[] = {
> -	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO, PCI_ANY_ID,
> -		PCI_ANY_ID, 0, 0, 0, },
> +	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> +	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
Seems like a PCI_DEVICE() candidate

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E

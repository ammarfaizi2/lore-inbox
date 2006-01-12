Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161205AbWALT2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161205AbWALT2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbWALT2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:28:36 -0500
Received: from bno-84-242-95-19.nat.karneval.cz ([84.242.95.19]:50118 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1161205AbWALT2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:28:35 -0500
Message-ID: <43C6ADDE.5060904@liberouter.org>
Date: Thu, 12 Jan 2006 20:28:30 +0100
From: Jiri Slaby <slaby@liberouter.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jon Mason <jdmason@us.ibm.com>
CC: mulix@mulix.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
References: <20060112175051.GA17539@us.ibm.com>
In-Reply-To: <20060112175051.GA17539@us.ibm.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Mason napsal(a):
> Some pcnet32 hardware erroneously has the Vendor ID for Trident.  The
> pcnet32 driver looks for the PCI ethernet class before grabbing the
> hardware, but the current trident driver does not check against the
> PCI audio class.  This allows the trident driver to claim the pcnet32 
> hardware.  This patch prevents that.
> 
> This patch is untested on Trident 4DWAVE_DX hardware, but has been
> tested on pcnet32 hardware.
> 
> Thanks,
> Jon
> 
> Signed-off-by: Jon Mason <jdmason@us.ibm.com>
> 
> diff -r 4a7597b41d25 sound/oss/trident.c
> --- a/sound/oss/trident.c	Wed Jan 11 19:14:08 2006
> +++ b/sound/oss/trident.c	Thu Jan 12 11:32:26 2006
You should change alsa driver (sound/pci/trident/trident.c), rather than this,
which will be removed soon, I guess. And, additionally, could you change that
lines to use PCI_DEVICE macro?

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E

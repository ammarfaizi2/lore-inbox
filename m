Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWGMG14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWGMG14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 02:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWGMG1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 02:27:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:8168 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932562AbWGMG1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 02:27:55 -0400
Message-ID: <44B5E845.1040708@manoweb.com>
Date: Thu, 13 Jul 2006 08:29:25 +0200
From: Alessio Sangalli <alesan@manoweb.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Daniel Ritz <daniel.ritz-ml@swissonline.ch>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cardbus: revert IO window limit
References: <200607010003.31324.daniel.ritz-ml@swissonline.ch> <Pine.LNX.4.64.0606301516140.12404@g5.osdl.org> <200607010109.40486.daniel.ritz-ml@swissonline.ch> <Pine.LNX.4.64.0606301614470.12404@g5.osdl.org> <44B4AAF9.1000706@manoweb.com> <Pine.LNX.4.64.0607120816070.5623@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607120816070.5623@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:98b9443de46bd48dbf34b16449aa5d76
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>> PCI: Probing PCI hardware
>> PCI: Probing PCI hardware (bus 00)
>> PCI quirk: region 1000-103f claimed by PIIX4 ACPI
>> PCI quirk: region 1400-140f claimed by PIIX4 SMB
>> PIIX4 devres C PIO at 0398-0399
> 
> Thanks, that explains it. Anybody who allocated region 1000 and 1400 would 
> clash with the built-in PIIX magic IO regions, and any driver that tried 
> to access those regions would instead end up accessing magic SMBus or ACPI 
> registers.
> 
> So your lock-ups are very understandable indeed, and I'll apply this to 
> the standard kernel. MUCH better than reverting the IO window limits.


Ok I'm glad we (you) have found the best solution.

Remember you are all welcome at the Planetarium of Lecco, Italy ;)

Thank you
Alessio Sangalli IZ2GMV


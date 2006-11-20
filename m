Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966252AbWKTRt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966252AbWKTRt0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966272AbWKTRt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:49:26 -0500
Received: from isilmar.linta.de ([213.239.214.66]:48271 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S966252AbWKTRtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:49:25 -0500
Date: Mon, 20 Nov 2006 12:49:24 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Linux kernel development <linux-kernel@vger.kernel.org>,
       PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Jaroslav Kysela <perex@suse.cz>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: Re: [PATCH] PCMCIA identification strings for Elan -- second attempt
Message-ID: <20061120174924.GC18660@isilmar.linta.de>
Mail-Followup-To: Tony Olech <tony.olech@elandigitalsystems.com>,
	Linux kernel development <linux-kernel@vger.kernel.org>,
	PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
	David Hinds <dahinds@users.sourceforge.net>,
	Jaroslav Kysela <perex@suse.cz>,
	Bart Prescott <bart.prescott@elandigitalsystems.com>
References: <200611201306.kAKD6gRt008347@imap.elan.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611201306.kAKD6gRt008347@imap.elan.private>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch looks good, except:

> +	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: CF332",0x3beb8cf2,0x16dc1ba7),
> +	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL332",0x3beb8cf2,0x19816c41),
> +	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL385",0x3beb8cf2,0x64112029),
> +	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> +	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial+Parallel Port: SP230",0x3beb8cf2,0xdb9e58bc),
> +	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: CF332",0x3beb8cf2,0x16dc1ba7),
> +	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL332",0x3beb8cf2,0x19816c41),
> +	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL385",0x3beb8cf2,0x64112029),
> +	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> +	PCMCIA_MFC_DEVICE_PROD_ID12(2,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> +	PCMCIA_MFC_DEVICE_PROD_ID12(3,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),

does the SL432 device have four independent multifunction subdevices? This
would be something I haven't seen before, and which would likely not work
with current code...

Thanks,
	Dominik


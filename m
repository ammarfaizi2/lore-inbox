Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWCVKSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWCVKSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 05:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWCVKSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 05:18:51 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:9914 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751189AbWCVKSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 05:18:50 -0500
From: Arnd Bergmann <abergman@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] hpet header sanitization
Date: Wed, 22 Mar 2006 11:18:43 +0100
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, clemens@ladisch.de,
       akpm <akpm@osdl.org>
References: <20060321144607.153d1943.rdunlap@xenotime.net>
In-Reply-To: <20060321144607.153d1943.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200603221118.43853.abergman@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 March 2006 23:46, Randy.Dunlap wrote:
> +#define        HPET_IE_ON      _IO('h', 0x01)  /* interrupt on */
> +#define        HPET_IE_OFF     _IO('h', 0x02)  /* interrupt off */
> +#define        HPET_INFO       _IOR('h', 0x03, struct hpet_info)
> +#define        HPET_EPI        _IO('h', 0x04)  /* enable periodic */
> +#define        HPET_DPI        _IO('h', 0x05)  /* disable periodic */
> +#define        HPET_IRQFREQ    _IOW('h', 0x6, unsigned long)   /* IRQFREQ usec */

By the way, HPET_INFO and HPET_IRQFREQ don't work for 32 bit user space,
the driver needs a compat_ioctl() method to handle those.

	Arnd <><

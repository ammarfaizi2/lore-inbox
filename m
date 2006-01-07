Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWAGFJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWAGFJs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 00:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWAGFJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 00:09:46 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:30105 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030433AbWAGFJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 00:09:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Dave Jones <davej@redhat.com>
Subject: Re: Allow iseries to disable input layer without CONFIG_EMBEDDED
Date: Sat, 7 Jan 2006 00:09:29 -0500
User-Agent: KMail/1.8.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060106073819.GA731@redhat.com>
In-Reply-To: <20060106073819.GA731@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601070009.29920.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 02:38, Dave Jones wrote:
> iSeries has no keyboard, so it's valid to build a kernel with no input layer.
> It seems a bit absurd to call one of these 'embedded'.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.15/drivers/input/Kconfig~	2006-01-06 02:27:56.000000000 -0500
> +++ linux-2.6.15/drivers/input/Kconfig	2006-01-06 02:28:08.000000000 -0500
> @@ -5,7 +5,7 @@
>  menu "Input device support"
>  
>  config INPUT
> -	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
> +	tristate "Generic input layer (needed for keyboard, mouse, ...)"
>  	default y
>  	---help---
>  	  Say Y here if you have any input device (mouse, keyboard, tablet,

It is there as a precaution... I wonder if we should have it changed to:

		if EMBEDDED || !X86

to ensure that we don't have issues on commodity hardware.

-- 
Dmitry

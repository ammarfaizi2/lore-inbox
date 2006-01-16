Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWAPKdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWAPKdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 05:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWAPKdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 05:33:44 -0500
Received: from cantor.suse.de ([195.135.220.2]:48256 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932321AbWAPKdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 05:33:43 -0500
Date: Mon, 16 Jan 2006 11:33:41 +0100
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Input: HID - add support for fn key on Apple PowerBooks
Message-ID: <20060116103341.GA4809@suse.de>
References: <200601141910.k0EJAm65013553@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200601141910.k0EJAm65013553@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Jan 14, Linux Kernel Mailing List wrote:

> tree 8ba37791bfeb95e660caf6192c8dcecd9ba2aa6e
> parent 1e27ffd4d7d39783c5196daa2584cca5785d1f95
> author Michael Hanselmann <linux-kernel@hansmi.ch> Sat, 14 Jan 2006 20:08:06 -0500
> committer Dmitry Torokhov <dtor_core@ameritech.net> Sat, 14 Jan 2006 20:08:06 -0500
> 
> Input: HID - add support for fn key on Apple PowerBooks
> 
> This patch implements support for the fn key on Apple PowerBooks using
> USB based keyboards and makes them behave like their ADB counterparts.
> 
> Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
> Acked-by: Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Acked-by: Vojtech Pavlik <vojtech@suse.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
>  drivers/usb/input/Kconfig     |   10 ++
>  drivers/usb/input/hid-core.c  |    8 ++
>  drivers/usb/input/hid-input.c |  166 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/usb/input/hid.h       |   31 ++++---
>  4 files changed, 201 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
> index 509dd0a..5246b35 100644
> --- a/drivers/usb/input/Kconfig
> +++ b/drivers/usb/input/Kconfig
> @@ -37,6 +37,16 @@ config USB_HIDINPUT
>  
>  	  If unsure, say Y.
>  
> +config USB_HIDINPUT_POWERBOOK
> +	bool "Enable support for iBook/PowerBook special keys"
> +	default n
> +	depends on USB_HIDINPUT
> +	help
> +	  Say Y here if you want support for the special keys (Fn, Numlock) on
> +	  Apple iBooks and PowerBooks.

Should this depend on CONFIG_$powerbook?

-- 
short story of a lazy sysadmin:
 alias appserv=wotan

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263211AbUJ2KLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbUJ2KLm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbUJ2KLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:11:41 -0400
Received: from gprs214-50.eurotel.cz ([160.218.214.50]:56192 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263211AbUJ2KLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:11:09 -0400
Date: Fri, 29 Oct 2004 12:10:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4/8] sonypi: rework input support
Message-ID: <20041029101050.GA1183@elf.ucw.cz>
References: <20041028100525.GA3893@crusoe.alcove-fr> <20041028100823.GE3893@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028100823.GE3893@crusoe.alcove-fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +/* Correspondance table between sonypi events and input layer events */
> +struct {
> +	int sonypiev;
> +	int inputev;
> +} sonypi_inputkeys[] = {
> +	{ SONYPI_EVENT_CAPTURE_PRESSED,	 	KEY_CAMERA },
> +	{ SONYPI_EVENT_FNKEY_ONLY, 		KEY_FN },
> +	{ SONYPI_EVENT_FNKEY_ESC, 		KEY_FN_ESC },
> +	{ SONYPI_EVENT_FNKEY_F1, 		KEY_FN_F1 },
> +	{ SONYPI_EVENT_FNKEY_F2, 		KEY_FN_F2 },
> +	{ SONYPI_EVENT_FNKEY_F3, 		KEY_FN_F3 },
> +	{ SONYPI_EVENT_FNKEY_F4, 		KEY_FN_F4 },
> +	{ SONYPI_EVENT_FNKEY_F5, 		KEY_FN_F5 },
> +	{ SONYPI_EVENT_FNKEY_F6, 		KEY_FN_F6 },
> +	{ SONYPI_EVENT_FNKEY_F7, 		KEY_FN_F7 },
> +	{ SONYPI_EVENT_FNKEY_F8, 		KEY_FN_F8 },
> +	{ SONYPI_EVENT_FNKEY_F9,		KEY_FN_F9 },
> +	{ SONYPI_EVENT_FNKEY_F10,		KEY_FN_F10 },
> +	{ SONYPI_EVENT_FNKEY_F11, 		KEY_FN_F11 },
> +	{ SONYPI_EVENT_FNKEY_F12,		KEY_FN_F12 },
> +	{ SONYPI_EVENT_FNKEY_1, 		KEY_FN_1 },
> +	{ SONYPI_EVENT_FNKEY_2, 		KEY_FN_2 },
> +	{ SONYPI_EVENT_FNKEY_D,			KEY_FN_D },
> +	{ SONYPI_EVENT_FNKEY_E,			KEY_FN_E },
> +	{ SONYPI_EVENT_FNKEY_F,			KEY_FN_F },
> +	{ SONYPI_EVENT_FNKEY_S,			KEY_FN_S },
> +	{ SONYPI_EVENT_FNKEY_B,			KEY_FN_B },
> +	{ SONYPI_EVENT_BLUETOOTH_PRESSED, 	KEY_BLUE },
> +	{ SONYPI_EVENT_BLUETOOTH_ON, 		KEY_BLUE },
> +	{ SONYPI_EVENT_PKEY_P1, 		KEY_PROG1 },
> +	{ SONYPI_EVENT_PKEY_P2, 		KEY_PROG2 },
> +	{ SONYPI_EVENT_PKEY_P3, 		KEY_PROG3 },
> +	{ SONYPI_EVENT_BACK_PRESSED, 		KEY_BACK },
> +	{ SONYPI_EVENT_HELP_PRESSED, 		KEY_HELP },
> +	{ SONYPI_EVENT_ZOOM_PRESSED, 		KEY_ZOOM },
> +	{ SONYPI_EVENT_THUMBPHRASE_PRESSED, 	BTN_THUMB },
> +	{ 0, 0 },
> +};
>  

KEY_FN_D does not sound too usefull (similar for FN_F1..FN_F12). Are
there some pictures on those keys? Mapping FN_F3 to for example
KEY_SUSPEND would be usefull...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

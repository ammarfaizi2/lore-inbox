Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbTKELDN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 06:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbTKELDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 06:03:12 -0500
Received: from f17.mail.ru ([194.67.57.47]:52749 "EHLO f17.mail.ru")
	by vger.kernel.org with ESMTP id S262836AbTKELDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 06:03:11 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Herbert Xu=?koi8-r?Q?=22=20?= 
	<herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [MOUSE] Alias for /dev/psaux
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [212.30.182.96]
Date: Wed, 05 Nov 2003 14:03:10 +0300
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AHLRO-000BA7-00.arvidjaar-mail-ru@f17.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> This patch creates an alias for /dev/psaux so that mousedev is loaded
> automatically.
[...]
> Index: kernel-source-2.5/drivers/input/mousedev.c
[...]
> +#ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
> +MODULE_ALIAS_CHARDEV(MISC_MAJOR, PSMOUSE_MINOR);
> +#endif

Well if you intend to go this way you have to add aliases for all
low-level mouse drivers, e.g. HID etc. What makes psmouse so special?

And if new mouse driver is added (worst case - off tree) it won't be catched.

I like hotplug approach better ...

-andrey

Please Cc me on reply.

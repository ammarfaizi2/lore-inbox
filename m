Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291347AbSAaVvX>; Thu, 31 Jan 2002 16:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291351AbSAaVvN>; Thu, 31 Jan 2002 16:51:13 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:24581 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S291347AbSAaVu4>; Thu, 31 Jan 2002 16:50:56 -0500
Message-ID: <3C59BC36.14267AE7@linux-m68k.org>
Date: Thu, 31 Jan 2002 22:50:46 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@transvirtual.com>
CC: linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers
In-Reply-To: <Pine.LNX.4.10.10201310712130.20956-100000@www.transvirtual.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

James Simmons wrote:

> +       printk(amikbd_messages[scancode]);      /* scancodes >= 0x78 are error codes */

Damn, Geert was faster with this. :)

> +       for (i = 0; i < 0x78; i++)
> +               if (amikbd_keycode[i])
> +                       set_bit(amikbd_keycode[i], amikbd_dev.keybit);

Do I understand it correctly, that amikbd_keycode[i] must have non zero
value for a valid key? If yes, something must be wrong here:

> +static unsigned char amikbd_keycode[0x78] = {
> +         0,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 43,  0, 82,

0 is a valid keycode on the Amiga, it should be KEY_GRAVE.

bye, Roman

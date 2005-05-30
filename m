Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVE3O2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVE3O2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVE3O2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:28:43 -0400
Received: from animx.eu.org ([216.98.75.249]:37293 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261607AbVE3O2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:28:41 -0400
Date: Mon, 30 May 2005 10:25:15 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc2: Compose key doesn't work
Message-ID: <20050530142515.GA20372@animx.eu.org>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <4258F74D.2010905@keyaccess.nl> <20050414100454.GC3958@nd47.coderock.org> <20050526122315.GA3880@nd47.coderock.org> <20050526154509.GB9443@animx.eu.org> <20050526155344.GB3694@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050526155344.GB3694@ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Thu, May 26, 2005 at 11:45:09AM -0400, Wakko Warner wrote:
> > I do wish they'd fix it, because I use this key (kinda like another ALT key)
> > more than my compose key (again, the menu key, not the right win logo key)
>  
> This patch should fix it.

At work, I have a USB keyboard with 8 extra keys.  Could something like this
be the cause of about 5 of those keys not working?  (They worked under 2.4
perfectly)

>  atkbd.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
> diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> --- a/drivers/input/keyboard/atkbd.c	2005-05-03 15:23:34 +02:00
> +++ b/drivers/input/keyboard/atkbd.c	2005-05-03 15:23:34 +02:00
> @@ -171,9 +171,9 @@
>  	unsigned char set2;
>  } atkbd_scroll_keys[] = {
>  	{ ATKBD_SCR_1,     0xc5 },
> -	{ ATKBD_SCR_2,     0xa9 },
> -	{ ATKBD_SCR_4,     0xb6 },
> -	{ ATKBD_SCR_8,     0xa7 },
> +	{ ATKBD_SCR_2,     0x9d },
> +	{ ATKBD_SCR_4,     0xa4 },
> +	{ ATKBD_SCR_8,     0x9b },
>  	{ ATKBD_SCR_CLICK, 0xe0 },
>  	{ ATKBD_SCR_LEFT,  0xcb },
>  	{ ATKBD_SCR_RIGHT, 0xd2 },

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

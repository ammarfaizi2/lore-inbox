Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVAERJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVAERJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVAERJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:09:41 -0500
Received: from dialin-145-254-057-142.arcor-ip.net ([145.254.57.142]:53509
	"EHLO spit.home") by vger.kernel.org with ESMTP id S261848AbVAERJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:09:30 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [patch] pedantic correctness cleanup for conf.c in scripts/kconfig/ .
Date: Wed, 5 Jan 2005 13:26:55 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0501040031460.3529@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0501040031460.3529@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501051326.56959.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 04 January 2005 00:35, Jesper Juhl wrote:

> @@ -305,8 +305,8 @@ static int conf_choice(struct menu *menu
>    printf("%*s%s\n", indent - 1, "", menu_get_prompt(menu));
>    def_sym = sym_get_choice_value(sym);
>    cnt = def = 0;
> -  line[0] = '0';
> -  line[1] = 0;
> +  line[0] = '\0';
> +  line[1] = '\0';
>    for (child = menu->list; child; child = child->next) {
>     if (!menu_is_visible(child))
>      continue;

This would make a difference and even the other change is not an improvement, 
0 is special string marker and not a character.

bye, Roman


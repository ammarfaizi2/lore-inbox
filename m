Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164022AbWLGXzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164022AbWLGXzV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164023AbWLGXzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:55:21 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1196 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164022AbWLGXzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:55:20 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: [PATCH] sound : Replace kmalloc()+memset(0) with kzalloc().
Date: Fri, 8 Dec 2006 00:55:14 +0100
User-Agent: KMail/1.9.5
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0612071553580.22255@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612071553580.22255@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612080055.14488.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 


>   Replace all appropriate kmalloc() + memset() combinations with
> kzalloc() throughout the sound/ directory.

[... cut ...]

> diff --git a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
> index c3c8a72..f5e31f1 100644
> --- a/sound/oss/i810_audio.c
> +++ b/sound/oss/i810_audio.c
> @@ -2580,10 +2580,9 @@ static int i810_open(struct inode *inode
>  		for (i = 0; i < NR_HW_CH && card && !card->initializing; i++) {
>  			if (card->states[i] == NULL) {
>  				state = card->states[i] = (struct i810_state *)
> -					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
> +					kzalloc(sizeof(struct i810_state), GFP_KERNEL);

You can remove those casts while you're at it.

-- 
Regards,

	Mariusz Kozlowski

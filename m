Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbWEOSIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWEOSIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWEOSIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:08:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18666 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965067AbWEOSIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:08:40 -0400
Date: Mon, 15 May 2006 11:11:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: michal.k.k.piotrowski@gmail.com, perex@suse.cz,
       alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm1
Message-Id: <20060515111111.510f214a.akpm@osdl.org>
In-Reply-To: <s5hy7x341f8.wl%tiwai@suse.de>
References: <20060515005637.00b54560.akpm@osdl.org>
	<6bffcb0e0605150940l647273f0jf4e1b9d5737bbd2@mail.gmail.com>
	<20060515100429.5069f6ca.akpm@osdl.org>
	<s5h3bfb5h73.wl%tiwai@suse.de>
	<s5hy7x341f8.wl%tiwai@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> -unsigned int snd_cards_lock = 0;	/* locked for registering/using */
> +static unsigned int snd_cards_lock = 0;	/* locked for registering/using */

May as well remove the `= 0' while you're there.  It adds four bytes to the
module unnecessarily.

>  void snd_request_card(int card)
>  {
> -	int locked;
> -
>  	if (! current->fs->root)
>  		return;

I wonder what that's there for.


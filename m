Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVGZQW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVGZQW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVGZQRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 12:17:37 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:13324 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261930AbVGZQRS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 12:17:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=moS/jIQTCL3wJ2OYTN532f2ZZG7/A3MS9V7xSSY/2E7/DLgMKki2BjajRihEj7d3cHyD3PHi6HtkkgbCR5nw4QO8YxSox8WXKx9AKLIQO2FQZ2T/K/QXNDJvuEOB4qK41W7Np4GlfAHxW4+khT8yP9c+/4C2sYQbvz5HOUfMLGc=
Message-ID: <105c793f050726091722f3cbb2@mail.gmail.com>
Date: Tue, 26 Jul 2005 12:17:14 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
In-Reply-To: <20050726150837.GT3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050726150837.GT3160@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/05, Adrian Bunk <bunk@stusta.de> wrote:
>  config SOUND_OPL3SA2
>         tristate "Yamaha OPL3-SA2 and SA3 based PnP cards"
> -       depends on SOUND_OSS
> +       depends on SOUND_OSS && OBSOLETE_OSS_DRIVER
>         help
>           Say Y or M if you have a card based on one of these Yamaha sound
>           chipsets or the "SAx", which is actually a SA3. Read
Forgive me if I'm misreading this (I'm hardly a coder and no kernel
hacker) but, as it stands, the OPL3SA2 driver provided by ALSA and the
main kernel tree work but are not correctly detected by ALSA's
detection routines (in alsaconf) on the 2.6 kernel. The OSS drivers
work, as well, but (AFAIK) there are no methods of automatic
configuration with the OSS drivers.

So, for people who don't feel like configuring ALSA with their OPL3SA2
card, the OSS modules may be easier to configure and thus should be
left in until the ALSA/2.6 kernel problems are worked out with the
OPL3SA2.

-Andy

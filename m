Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUITEWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUITEWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 00:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUITEWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 00:22:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:16323 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265978AbUITEWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 00:22:22 -0400
Date: Sun, 19 Sep 2004 21:06:49 -0700
From: Greg KH <greg@kroah.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040920040649.GA5344@kroah.com>
References: <414C9003.9070707@softhome.net> <1095568704.6545.17.camel@gaston> <414D42F6.5010609@softhome.net> <20040919140034.2257b342.Ballarin.Marc@gmx.de> <414D96EF.6030302@softhome.net> <20040919171456.0c749cf8.Ballarin.Marc@gmx.de> <414DE099.8040202@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414DE099.8040202@softhome.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 09:40:09PM +0200, Ihar 'Philips' Filipau wrote:
> >For example, modprobe ide-cd will succeed even when no CD-ROMs are
> >present. The old script would break in this case, the new one wouldn't be
> >called at all.
> >
> 
>   You are wrong. Hardware driver must fail, when hardware is not 
> present/not detected. Simple as that.

I'm sorry, but this is not how Linux device drivers work.  It's been
this way for over 4 years, and hopefully we have fixed up almost all
drivers to be able to be loaded even if the hardware they are using
isn't currently present.  Do you know of any we have missed?

thanks,

greg k-h

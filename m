Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVAaPsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVAaPsB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 10:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVAaPsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 10:48:01 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:1002 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261239AbVAaPr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 10:47:56 -0500
Date: Mon, 31 Jan 2005 19:07:39 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, Adrian Bunk <bunk@stusta.de>,
       Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] connector.c: make notify_lock static
Message-ID: <20050131190739.11048162@zanzibar.2ka.mipt.ru>
In-Reply-To: <d120d50005013107005a8c39b1@mail.gmail.com>
References: <20050131124119.GE18316@stusta.de>
	<d120d50005013107005a8c39b1@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 10:00:51 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Mon, 31 Jan 2005 13:41:19 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > notify_lock isn't a good name for a global lock.
> > But since it's not used outside of the file, it can be made static.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.11-rc2-mm2-full/drivers/connector/connector.c.old 2005-01-31 13:09:14.000000000 +0100
> > +++ linux-2.6.11-rc2-mm2-full/drivers/connector/connector.c     2005-01-31 13:09:28.000000000 +0100
> > @@ -41,7 +41,7 @@
> > module_param(cn_idx, uint, 0);
> > module_param(cn_val, uint, 0);
> > 
> > -spinlock_t notify_lock = SPIN_LOCK_UNLOCKED;
> > +static spinlock_t notify_lock = SPIN_LOCK_UNLOCKED;
> > static LIST_HEAD(notify_list);
> > 
> > static struct cn_dev cdev;
> > 
> 
> Isn't this supposed to be "static DEFINE_SPINLOCK(notify_lock);" nowadays?

That's not a problem, I will cook up a patch and send it through Greg.
Thank you.

> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt

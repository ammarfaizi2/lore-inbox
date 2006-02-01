Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWBACKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWBACKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 21:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWBACKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 21:10:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964773AbWBACKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 21:10:10 -0500
Date: Tue, 31 Jan 2006 18:09:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: mail@joachim-breitner.de, linux-kernel@vger.kernel.org,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] [CM4000,CM4040] Add device class bits to enable udev
 device creation
Message-Id: <20060131180927.6843c775.akpm@osdl.org>
In-Reply-To: <20060131101046.GS4603@sunbeam.de.gnumonks.org>
References: <1138536696.6509.9.camel@otto.ehbuehl.net>
	<1138541796.6395.8.camel@otto.ehbuehl.net>
	<20060131101046.GS4603@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte <laforge@gnumonks.org> wrote:
>
> Please apply this fix to the cm4000/4040 drivers, thanks!
> 
>  [CM4000,CM4040] Add device class bits to enable udev device creation
> 
>  Using this patch, Omnikey CardMan 4000 and 4040 devices automatically
>  get their device nodes created by udev.

Dominik has made quite widespread changes to these drivers - enough that
I'm not confident to fix the rejects, make it compile and hope that it
still works.

So can you please sort things out with Dominik?  I guess a tested patch
against -mm4 would be ideal.

I note that these drivers forget to check for pcmcia_register_driver()
failure.  That's a fairly good way of getting an oops in rmmod.

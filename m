Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265058AbUDUGsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbUDUGsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265020AbUDUGsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:48:37 -0400
Received: from [194.89.250.117] ([194.89.250.117]:50825 "EHLO
	kimputer.holviala.com") by vger.kernel.org with ESMTP
	id S265058AbUDUGsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:48:31 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse fixes for 2.6.5
Date: Wed, 21 Apr 2004 09:48:29 +0300
User-Agent: KMail/1.6.1
References: <200404201038.46644.kim@holviala.com> <200404202338.53773.kim@holviala.com> <200404202117.37104.dtor_core@ameritech.net>
In-Reply-To: <200404202117.37104.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210948.29095.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 April 2004 05:17, Dmitry Torokhov wrote:

> > > > - support for Targus Scroller mice (from my last weeks patch)
> > >
> > > Why do you have Tragus as a config option - just set the protocol mask
> > > correctly by default...

It's not a config option, I just have a little note on the Kconfig file for 
those that read the help pages.

> And I think you will achieve the desired result by just doing:
>
> -static unsigned int psmouse_max_proto = -1U;
> +static unsigned int psmouse_probe_proto = PSMOUSE_ANY & ~PSMOUSE_TARGUS;

You're right... I did have a small logic problem there - that looks much 
better.



Kim

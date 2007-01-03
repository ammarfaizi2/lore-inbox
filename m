Return-Path: <linux-kernel-owner+w=401wt.eu-S1754993AbXACHvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbXACHvH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754995AbXACHvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:51:07 -0500
Received: from mail.queued.net ([207.210.101.209]:4329 "EHLO mail.queued.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993AbXACHvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:51:06 -0500
Message-ID: <459B6062.6050300@queued.net>
Date: Wed, 03 Jan 2007 02:50:58 -0500
From: Andres Salomon <dilinger@queued.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz, warp@aehallh.com
Subject: Re: [PATCH] psmouse split [01/03]
References: <457F822E.4040404@debian.org> <200612130108.19447.dtor@insightbb.com> <457FAA01.9010807@debian.org> <d120d5000612130612v5d12adc0uc878b8307770d79@mail.gmail.com> <45802D98.7030608@debian.org> <d120d5000612130947w899614y68cf32cb1e3b35ec@mail.gmail.com> <459B51C4.8040906@queued.net> <20070103073637.GA26825@uranus.ravnborg.org>
In-Reply-To: <20070103073637.GA26825@uranus.ravnborg.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> Hi Andres.
> 
[...]
> 
> The above code should be redone to use list based assignement.
> Something like this:
> 
> psmouse-y := psmouse-base.o
> psmouse-$(CONFIG_MOUSE_PS2_ALPS)       += alps.o
> psmouse-$(CONFIG_MOUSE_PS2_LOGIPS2PP)  += logips2pp.o
> psmouse-$(CONFIG_MOUSE_PS2_SYNAPTICS)  += synaptics.o
> psmouse-$(CONFIG_MOUSE_PS2_LIFEBOOK)   += lifebook.o
> psmouse-$(CONFIG_MOUSE_PS2_TRACKPOINT) += trackpoint.o
> 
> 	Sam

Thanks; committed to my git repo.

http://dev.laptop.org/git?p=users/dilinger/psmouse-split;a=shortlog;h=psmouse-static


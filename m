Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUDSPmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264466AbUDSPmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:42:22 -0400
Received: from slip32-106-21-233.fra.de.prserv.net ([32.106.21.233]:12161 "EHLO
	aj.andaco.de") by vger.kernel.org with ESMTP id S264246AbUDSPmU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:42:20 -0400
Date: Mon, 19 Apr 2004 17:41:37 +0200
To: Wichert Akkerman <wichert@wiggy.net>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tg3 driver - make use of binary-only firmware optional
Message-ID: <20040419154137.GA4885@andaco.de>
References: <20040418135534.GA6142@andaco.de> <20040418180811.0b2e2567.davem@redhat.com> <20040419080439.GB11586@andaco.de> <20040419085809.GA585@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419085809.GA585@wiggy.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Andreas Jochens <aj@andaco.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-Apr-19 10:58, Wichert Akkerman wrote:
> Is there any reason for not using the hotplug firmware infrastructure?

I had the hotplug mechanism in mind when I moved the three firmware 
images from tg3.c to three separate firmware files in my first patch.
I thought of this as a first step which could be followed by 
converting the driver to use the hotplug firmware 
infrastructure and moving the firmware images to user space.

However, since a patch putting the firmware in separate files doesn't 
seem to be welcome, I doubt that a conversion to use the hotplug 
mechanism will be accepted because this would separate the firmware 
and the driver even more.

In any case, making the use of the firmware optional by introducing 
CONFIG_TIGON3_FIRMWARE seems to make sense. A later conversion to the 
hotplug firmware mechanism will always be possible.

Regards
Andreas Jochens

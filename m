Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbUDSPxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbUDSPxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:53:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51335 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264490AbUDSPw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:52:59 -0400
Message-ID: <4083F5CE.5080008@pobox.com>
Date: Mon, 19 Apr 2004 11:52:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Jochens <aj@andaco.de>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tg3 driver - make use of binary-only firmware optional
References: <20040418135534.GA6142@andaco.de> <20040418180811.0b2e2567.davem@redhat.com> <20040419080439.GB11586@andaco.de>
In-Reply-To: <20040419080439.GB11586@andaco.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jochens wrote:
> On 04-Apr-18 18:08, David S. Miller wrote:
> 
>>However, that in no way means that Jeff and myself have to split
>>the firmware out of the driver either.  In fact, I do not want to
>>as I like keeping all of the network drivers I write in single
>>foo.c and foo.h files.
> 
> 
> Would the patch be acceptable if the firmware parts were kept in tg3.c
> as they are now but #ifdef'd out when CONFIG_TIGON3_FIRMWARE is not set?
> 
> At least this would make it clear that the driver is usable even without 
> the firmware. Or is there perhaps any technical problem which might 
> occur when firmware loading is optionally disabled as indicated below?
> 
> Thank you for your attention.


It's still a patch for more political purposes than technical ones.

See my other message -- when the Just Works(tm) value is high enough, we 
can use the kernel firmware loader, and the firmware will be outside the 
driver source code.

But since using the firmware loader _right now_ would kill 
loader-unaware situations like the installer or "kickstart", it's not 
feasible.

	Jeff




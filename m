Return-Path: <linux-kernel-owner+w=401wt.eu-S1762515AbWLJUV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762515AbWLJUV5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 15:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762549AbWLJUV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 15:21:57 -0500
Received: from livid.absolutedigital.net ([66.92.46.173]:1686 "EHLO
	mx2.absolutedigital.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762515AbWLJUV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 15:21:56 -0500
Date: Sun, 10 Dec 2006 15:21:51 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Window scaling problem?
In-Reply-To: <Pine.LNX.4.61.0612101001390.9675@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0612101507180.23130@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.61.0612101001390.9675@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006, Jan Engelhardt wrote:

> for some reason unknown to me, some TCP connections just hang or get
> reset after some kilobytes have been transferred. I suppose it is a
> router with broken window scaling, but I can not say for sure from
> the tcpdump logs.

I observed the exact same behavior on a client's network not too long ago 
which used a Cyberguard firewall as a NAT gateway. I didn't have time to 
fully look into it but disabling TCP window scaling in Linux allowed me to 
work without problems.

> If anyone could take a look, I'd be grateful. Kernel currently
> running is 2.6.18.5, but I have seen this with 2.6.17 I was running
> two months ago too, so I do not suspect a kernel bug.

I saw this with kernels v2.6.16, v2.6.17, and v2.6.18. Windows XP however 
didn't seem to have any problems. So unless Windows doesn't have window 
scaling on by default (or uses a workaround) it could be a broken kernel.

Wish I could be more help...

  - C.

-- 
"There is nothing wrong with your television set. Do not attempt
    to adjust the picture. We are controlling transmission."
                    -- The Outer Limits


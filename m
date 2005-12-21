Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbVLUSgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVLUSgd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVLUSgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:36:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36568 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964791AbVLUSgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:36:32 -0500
Date: Wed, 21 Dec 2005 10:32:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Steve deRosier <derosier@pianodisc.com>
cc: James Courtier-Dutton <James@superbug.co.uk>, Adrian Bunk <bunk@stusta.de>,
       Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>,
       mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
In-Reply-To: <43A989CF.3000901@pianodisc.com>
Message-ID: <Pine.LNX.4.64.0512211029200.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de>
 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <43A86B20.1090104@superbug.co.uk>
 <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org> <43A989CF.3000901@pianodisc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Dec 2005, Steve deRosier wrote:
> 
> Thankfully, we've never had to deal with this sort of failure; all of our Alsa
> drivers and services have been well behaved (mostly).

Yes, I think the common case is that built-in _does_ work. I certainly 
have used sound that way. This one case is a bit special just because it's 
not under the sound/ directory, but I suspect that may be true of some USB 
sound"cards" too. 

Now, hot-plug devices tend to have a stronger case for being built as 
modules, although even there I personally actually end up just building in 
the devices I have (whether cardbus cards or things like the USB
printer/mouse/keyboard).

So I don't think sound is terminally broken here, just a few small details 
that it gets wrong that causes some odder drivers to not like being built 
in.

		Linus

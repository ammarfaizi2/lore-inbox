Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265080AbSJWQGj>; Wed, 23 Oct 2002 12:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSJWQGi>; Wed, 23 Oct 2002 12:06:38 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:59839 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265080AbSJWQGh>; Wed, 23 Oct 2002 12:06:37 -0400
Subject: Re: [PATCHSET 22/25] add support for PC-9800 architecture (sound
	alsa)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Osamu Tomita <tomita@cinet.co.jp>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hbs5l17ku.wl@alsa2.suse.de>
References: <20021019015653.A1642@precia.cinet.co.jp>
	<s5hznt51ksm.wl@alsa2.suse.de> <3DB6C1BD.41DC80AC@cinet.co.jp> 
	<s5hbs5l17ku.wl@alsa2.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 17:29:22 +0100
Message-Id: <1035390562.4319.69.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 16:46, Takashi Iwai wrote:
> the question is, whether cs4232 module works on PC9800, or not.
> i guess the control-port is not used on this card.  in such a case,
> you can deactivate the control-port via module option (or even add
> ifdef for the specific kernel config).

In the longer run it may well be much cleaner to make pc98 a variable
just like eisa, mca are. On a non pc98 box it might happen to be a
constant 0 and optimised but that is a detail.

Its much easier to follow

	if(!pc98)
		outb(a,b);



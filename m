Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVEKCDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVEKCDn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 22:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVEKCDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 22:03:43 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:5289 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261878AbVEKCDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 22:03:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ALPS touchpad issues still exist in 2.6.12-rc4h
Date: Tue, 10 May 2005 20:59:36 -0500
User-Agent: KMail/1.8
Cc: Stuart Shelton <stuart@zeus.com>, Daniel Drake <dsd@gentoo.org>,
       Alan Lake <alan.lake@lakeinfoworks.com>, petero2@telia.co.uk,
       vojtech@suse.cz
References: <42801AEE.5080308@lakeinfoworks.com> <d120d5000505101520ad1761@mail.gmail.com> <1115767038.12779.36.camel@callisto.dnsalias.net>
In-Reply-To: <1115767038.12779.36.camel@callisto.dnsalias.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505102059.36744.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 May 2005 18:17, Stuart Shelton wrote:
> 
> Hi,
> 
> I've been testing this on my laptop in framebuffer console mode only -
> I've not tested the Synaptics driver with the newer kernels.
> 
> I'm not sure if an updated GPM is the right solution: tapping does very
> occasionally seem to work (although it might be some facet of the bug
> that sometimes causes the cursor to appear and select the character
> beneath it when typing).

I am not sure if I understand what you saying... Are you saying that you
tried GPM with proper evdev support and you are seeing some issues or that
you do not believe that GPM should be touched at all?

> 
> More than this, with every kernel (at least since the very early 2.4
> ones) up to 2.6.10 the ALPS touchpad has worked just fine through
> input/mice or the psaux device - why has this changed in 2.6.11,

Because some people do not want tapping and some people do not like
default sensitivity and some like having virtual scrolling while other
want to have different actions assigned to corner taps.

> and can the change be reverted before 2.6.12 is released?

You do not need to wait for 2.6.12:

	modprobe psmouse proto=exps

or boot with "psmouse.proto=exps" if mouse is built as a module.

On a bit tangent note - anyone is willing to test resync patches? I do not
have access to ALPS touchpad and that's the one piece of hardware that does
not want to play nicely...

-- 
Dmitry

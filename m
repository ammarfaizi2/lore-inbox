Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWAFJtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWAFJtl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 04:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWAFJtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 04:49:41 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:52908 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S964887AbWAFJtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 04:49:40 -0500
Date: Fri, 6 Jan 2006 10:49:38 +0100
From: Tino Keitel <tino.keitel@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: No Coax digital out with SB Live! and 2.6.15
Message-ID: <20060106094938.GA8091@localhost.localdomain>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	linux-kernel@vger.kernel.org
References: <20060103180831.GA5265@localhost.localdomain> <20060104072618.GA10973@localhost.localdomain> <20060104073617.GA15342@localhost.localdomain> <1136498477.847.52.camel@mindpipe> <20060106000921.GA4867@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106000921.GA4867@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 01:09:21 +0100, Tino Keitel wrote:

[...]

> I booted with the 2.6.15 driver and got a silent digital out, like
> reported. The headphone which is plugged into the analog output gives
> sound.
> 
> If I load the 1.0.10 driver, sound works in xmms. If I unload it and
> reload the original 2.6.15 driver, sound still works. If I reboot with
> the original 2.6.15 driver, the digital out is silent again, while the
> analog output works.
> 
> However, if I now chose a specific output device in xmms, hw:0,2,
> instead of the default device, digital out gives sound. With the 1.0.10
> driver, this hw:0,2 device stays completely silent (digital and
> analog). With this version, the hw:0,0 device (which seems to be the
> default) gives analog and digital sound.

The solution looks more simple: just removing and reloading the
original snd-emu10k1 module reorders the devices so that the default
device gives sound on the digital output. The driver is blacklisted in
udev and loaded at boot time in /etc/modules, so the module-init-tools
initscript will load them. However, I have no idea why it behaves
different if loaded at boot time than when reloaded later.

Regards,
Tino


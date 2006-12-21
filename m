Return-Path: <linux-kernel-owner+w=401wt.eu-S1422929AbWLUKBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422929AbWLUKBE (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 05:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422932AbWLUKBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 05:01:04 -0500
Received: from eazy.amigager.de ([213.239.192.238]:52548 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422929AbWLUKBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 05:01:03 -0500
Date: Thu, 21 Dec 2006 11:01:01 +0100
From: Tino Keitel <tino.keitel@tikei.de>
To: linux-kernel@vger.kernel.org
Subject: Re: How to interpret PM_TRACE output
Message-ID: <20061221100101.GA23386@dose.home.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20061213212258.GA9879@dose.home.local> <20061216085748.GE4049@ucw.cz> <20061219085616.GA2053@dose.home.local> <20061220161903.GB4261@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220161903.GB4261@ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 16:19:04 +0000, Pavel Machek wrote:
> Hi!
> 
> > > > I tried PM_TRACE to find the driver that breaks resume from suspend.
> > > > I got working resume until I switched to the sk98lin driver
> > > > (because sky2 doesn't support wake on LAN). That's why I was quite sure that
> > > > sk98lin is the culprit, but I tried PM_TRACE anymay.
> > > 
> > > See Doc*/power/*.
> > 
> > There is a nice mixture of documentation about swusp, video stuff,
> > developer documentation, and one short paragraph about PM_TRACE that
> > tells me nothing new. Could you point me to the documentation part that
> > you are referring to, and that tells me what to do if PM_TRACE shows
> > the usb device but the failure only occurs when I load the sk98lin
> > driver?
> 
> Hmmm, so it fails somewhere in usb only if sk98lin is loaded? If you
> unload it again, resume works? Are usb interrupts shared? Where

Yes, it works with sky2. Yes, the USB device that is reported to fail
by PM_TRACE shares the interrupt with eth0, which is sk98lin (see my
original posting in this thread).

> exactly in the usb does it fail?

I don't know, all I have is the PM_TRACE output.

Meanwhile, tried to remove uhci_hcd before suspend, and wakeup works
then. However, my DVB-T box is dead after resume (reloading the driver
doesn't work, only unplug/replug the device helps). It works with
suspend to disk, though.

Regards,
Tino

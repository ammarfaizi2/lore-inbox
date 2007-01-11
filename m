Return-Path: <linux-kernel-owner+w=401wt.eu-S1030363AbXAKNVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbXAKNVa (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbXAKNVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:21:30 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:46716 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030363AbXAKNV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:21:29 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.20-rc4: null pointer deref in khubd
Date: Thu, 11 Jan 2007 14:21:47 +0100
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>
References: <20070110104937.GA32112@elf.ucw.cz> <200701101653.57929.oneukum@suse.de> <20070110203809.GA6378@ucw.cz>
In-Reply-To: <20070110203809.GA6378@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701111421.48125.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Januar 2007 21:38 schrieb Pavel Machek:
> Hi!
> 
> > > usb 2-1: new full speed USB device using uhci_hcd and address 68
> > > usb 2-1: USB disconnect, address 68
> > > usb 2-1: unable to read config index 0 descriptor/start
> > > usb 2-1: chopping to 0 config(s)
> > 
> > Does anybody know a legitimate reasons a device should have
> > 0 configurations? Independent of the reason of this bug, should we disallow
> > such devices and error out?
> 
> It is not bad device, btw, but extremely flakey connector. Bug is
> random :-(, and machine is smp, so it might even be a race.

With that config option, there's a race even on UP. probe() can
sleep.

	Regards
		Oliver

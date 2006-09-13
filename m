Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWIMRBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWIMRBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 13:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWIMRBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 13:01:09 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:19408 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750784AbWIMRBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 13:01:08 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1
Date: Wed, 13 Sep 2006 19:00:37 +0200
User-Agent: KMail/1.9.1
Cc: Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0609121605200.5686-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0609121605200.5686-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609131900.38215.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 12 September 2006 22:10, Alan Stern wrote:
> On Tue, 12 Sep 2006, Mattia Dongili wrote:
> 
> > No luck here. I'll give -mm2 a run just to 
> > 
> > full dmesg
> > with patch applied[1]:
> > http://oioio.altervista.org/linux/dmesg-2.6.18-rc6-mm1-fail-S3-2
> > 
> > without it (it's almost identical :)):
> > http://oioio.altervista.org/linux/dmesg-2.6.18-rc6-mm1-fail-S3
> > 
> > .config:
> > http://oioio.altervista.org/linux/config-2.6.18-rc6-mm1-3
> > 
> > [1]: I didn't rebuild fully, just applied the patch and re-run make
> > bzImage modules
> 
> I can't reproduce your results here with my configuration.  I used 
> 2.6.18-rc6-mm2 instead of -mm1 but I don't think that should matter.

On my box the issue (the second suspend of USB controllers in a row fails
100% of the time) went away after I had reverted the following patches
(I'm using 2.6.18-rc6-mm2 now):

fix-gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure.patch
gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure.patch
gregkh-usb-usbcore-non-hub-specific-uses-of-autosuspend.patch
gregkh-usb-usbcore-remove-usb_suspend_root_hub.patch

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

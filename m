Return-Path: <linux-kernel-owner+w=401wt.eu-S1750741AbXAVID1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbXAVID1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 03:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbXAVID0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 03:03:26 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:36025 "EHLO mx1.skjellin.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750741AbXAVIDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 03:03:25 -0500
X-Greylist: delayed 1768 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jan 2007 03:03:25 EST
Message-ID: <45B468DE.7030902@tomt.net>
Date: Mon, 22 Jan 2007 08:33:50 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Patrick Ale <patrick.ale@gmail.com>
Subject: Re: pata_sil680 module, udev and changing drive node order
References: <8d158e1f0701201623q1519c6e7m334f0c702553b666@mail.gmail.com>
In-Reply-To: <8d158e1f0701201623q1519c6e7m334f0c702553b666@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Ale wrote:
> The drivers load correctly but my drives seem to be in a different
> order all the time, which is not very convinient when your run md
> devices.

md does not rely on device names, it can work on array UUID's too (check 
out man mdadm.conf).

> So, my question is: how do I force a fixed order for a module handling
> two PCI cards, or how do I tell udev to always use the same mapping
> for the device nodes in /dev?

To avoid these kinds of pitfalls I usually only specify UUID's for mdadm 
to assemble, not device-names. Mount can also work with partition UUID's 
  if you are not using something like devicemapper or md in between that 
has a static device name scheme.

Beware that you may need a fairly modern initramfs/initrd setup to get 
all this to work cleanly, especially if the root device is involved.

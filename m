Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266727AbUHWDvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266727AbUHWDvZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 23:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUHWDvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 23:51:25 -0400
Received: from havoc.gtf.org ([216.162.42.101]:5854 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266727AbUHWDvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 23:51:23 -0400
Date: Sun, 22 Aug 2004 23:51:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alexandre <almeida@urbi.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: wrong IDE disk size
Message-ID: <20040823035121.GA28537@havoc.gtf.org>
References: <008601c488c3$a607dd30$21c3060a@nheotfd7dz4lxz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008601c488c3$a607dd30$21c3060a@nheotfd7dz4lxz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 12:45:35AM -0300, Alexandre wrote:
> Hi,
> 
> I installed two new SAMSUNG SP1203N (120GB) drives on the same IDE.
> But, from the boot log:
> 
> hdc: attached ide-disk driver.
> hdc: host protected area => 1
> hdc: 234493056 sectors (120060 MB) w/2048KiB Cache, CHS=14596/255/63,
> UDMA(100)
> hdd: attached ide-disk driver.
> hdd: host protected area => 1
> hdd: setmax_ext LBA 234493056, native  66055248
> hdd: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=4111/255/63, UDMA(100)
> 
> So the second one get its capacity limited to ~33GB. I know there is a limit
> of 34GB (CHS=4111/255/53) with older BIOSes and kernel, but i believe it
> doesnt apply as the first drive got recognized properly. Also, i have
> another 120 GB SEAGATE as hda working properly. (So the disk with wrong
> capacity is the third IDE drive)
> 
> I'm running kernel 2.4.25. CONFIG_IDEDISK_STROKE is off.
> 
> Any ideas of what might be happening?

It looks like hdd's host protected area is enabled, and you need
to turn on CONFIG_IDEDISK_STROKE to be able to access 100% of it.

	Jeff




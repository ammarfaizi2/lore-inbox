Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVEaQzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVEaQzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVEaQvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:51:33 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:19036 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261970AbVEaQuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:50:09 -0400
Message-ID: <429C95BF.3070102@tls.msk.ru>
Date: Tue, 31 May 2005 20:50:07 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg K-H <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] PCI: add modalias sysfs file for pci devices
References: <11163663063114@kroah.com>
In-Reply-To: <11163663063114@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> [PATCH] PCI: add modalias sysfs file for pci devices
[With similar patch and $MODALIAS in hotplug path stuff
 submitted for USB]

Speaking of all this...  While the two (USB and PCI) are
most important nowadays...  Hmm, so probably all other
similar "busses", like PCMCIA, even bluetooth, and "not
so obvious ones" like IDE and SCSI, and PNP&EISA -- this
same approach may be used for all, providing device/modalias
file for all (scsi:t0 for sd_mod etc), and $MODALIAS for
hotpluggable ones, with appropriate .modalias in modules...

I mean, are we on the way to converting just everything
into this modalias thing, so that hotplug/modloading will
be just one-liner?

Providing "trivial" aliases for eg PNP or EISA busses
seems to be a bit redundrand (a list of pnp:dXXX in
device/modalias in addition to XXX in device/id), but
without that this whole picture will not be consistent...
or should it?

/mjt

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263249AbTIVRXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 13:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbTIVRXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 13:23:11 -0400
Received: from mail.convergence.de ([212.84.236.4]:17095 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263249AbTIVRXI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 13:23:08 -0400
Date: Mon, 22 Sep 2003 19:23:03 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's the point of __KERNEL_SYSCALLS__?
Message-ID: <20030922172303.GA3733@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
References: <20030919164044.GF21596@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919164044.GF21596@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> 
> Given that, why should they exist?  It only encourages monstrosities
> like sp8870_read_code() in drivers/media/dvb/frontends/alps_tdlb7.c that
> probably don't work anyway.
...
> read is used by DVB and the wavefront sound driver
> lseek is only used by DVB
> open is used by DVB, init/main.c and wavefront.
> close is used by wavefront.  (DVB calls sys_close directly).

Those binary-only firmwares are a curse :-(

Anyway, we want to replace all our firmware loading code and the
compiled-in firmwares with the firmware_class loader as soon as
there is a usable hotplug agent available. There already are some
experimental patches for av7110.c in linuxtv.org CVS.


Johannes

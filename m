Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbTITWsd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 18:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbTITWsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 18:48:33 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:16571 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261637AbTITWsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 18:48:32 -0400
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <3F6CD341.40104@pobox.com>
References: <200309131101.h8DB1WNd021570@harpo.it.uu.se>
	 <1063476275.8702.35.camel@dhcp23.swansea.linux.org.uk>
	 <20030913184934.GB10047@gtf.org> <20030913190131.GD10047@gtf.org>
	 <20030915073445.GC27105@suse.de> <20030916194955.GC5987@gtf.org>
	 <20030916195515.GC906@suse.de>  <3F6C9C55.6050608@pobox.com>
	 <1064096170.23121.3.camel@dhcp23.swansea.linux.org.uk>
	 <3F6CD341.40104@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064098014.23121.32.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Sat, 20 Sep 2003 23:46:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-20 at 23:22, Jeff Garzik wrote:
> > Is that an error and change in behaviour ?
> 
> 
> No and yes.  :)
> 
> Current sg breaks the Unix model of write(2)... you shouldn't error out 
> if the queue will "probably" become available again.

Thats what I thought - because apps want to know if the queue is full
when doing raw scsi work some of the time. Would the change break any
known apps - if not it seems fine (providing O_NDELAY is supported)


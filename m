Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTIMSF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 14:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbTIMSF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 14:05:59 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:59803 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262057AbTIMSF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 14:05:57 -0400
Subject: Re: DMA for ide-scsi?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309131101.h8DB1WNd021570@harpo.it.uu.se>
References: <200309131101.h8DB1WNd021570@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063476275.8702.35.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sat, 13 Sep 2003 19:04:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-13 at 12:01, Mikael Pettersson wrote:
> That begs the question: why won't ide-scsi do DMA?

Because nobody added it. Its that simple

> I understand you'd rather see it disappear (:->) but since I use
> it for other ATAPI devices as well, I'd like to see it maintained
> and fully operational. Having DMA in ide-scsi would be nice.

I don't see it vanishing either - people abuse IDE (especially SATA) for
weird stuff like high end scanners which want to use ide-scsi for sg. I
agree with Bart about ide-scsi for disks. For tape ide-tape isnt good
enough for newer stuff but that could be fixed either way

> (And the concept of using a SCSI API to ATA devices is in itself
> not broken, even if the implementation has some problems.)

ATA drives don't generally talk ATAPI as well so you have protocol
stuff. For Serial ATA that is what the current SATA code everyone is
using does and each SATA vendor has followed the same path because our
existing PATA code 

In 2.7 the SCSI layer split can get finished so it seperates "scsi the
protocol" from "queueing engine and handling for an intelligent
controller".

Right now its not too bad - error handling is entirely pluggable for
example.


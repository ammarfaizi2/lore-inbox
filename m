Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUHSI5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUHSI5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 04:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUHSI5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 04:57:03 -0400
Received: from [80.188.250.22] ([80.188.250.22]:46539 "EHLO
	thinkpad.gardas.net") by vger.kernel.org with ESMTP id S264085AbUHSIyO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 04:54:14 -0400
Date: Thu, 19 Aug 2004 10:54:00 +0200 (CEST)
From: Karel Gardas <kgardas@objectsecurity.com>
X-X-Sender: karel@thinkpad.gardas.net
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: IBM T22/APM suspend does not work with yenta_socket module loaded
 on 2.6.8.1
In-Reply-To: <20040819094702.A546@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.43.0408191050420.1006-100000@thinkpad.gardas.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004, Russell King wrote:

> On Thu, Aug 19, 2004 at 10:16:04AM +0200, Karel Gardas wrote:
> > I've found that APM suspend is not working on my IBM T22 properly, when
> > cardbus services are loaded. I've identified the problematic piece of code
> > as a yenta_socket module -- when I stop cardmgr and unload this module,
> > suspend starts to work.
>
> So it doesn't even work with cardmgr stopped and yenta loaded?

Yes, cardmgr stopped and all modules loaded (including yenta) results in
non-functioning suspend. Also I've forgotten to mention that my cardmgr is
version 3.1.33...

> Have you tried removing any cards plugged in to the sockets?

I don't have any cards in any socket.

> You could try grabbing the cbdump program from pcmcia.arm.linux.org.uk
> and trying to identify whether there's any differences in the register
> settings of the Cardbus bridges - between having no yenta module loaded
> and having yenta loaded with the sockets suspended using:
>
> echo 3 > /sys/class/pcmcia_socket/pcmcia_socket0/device/power/state
> echo 3 > /sys/class/pcmcia_socket/pcmcia_socket1/device/power/state
>
> (echo 0 to these files to resume the sockets.)

Will try and hopefully report results this week.

Thanks,

Karel
--
Karel Gardas                  kgardas@objectsecurity.com
ObjectSecurity Ltd.           http://www.objectsecurity.com


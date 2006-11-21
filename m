Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030904AbWKUMSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030904AbWKUMSZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 07:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030909AbWKUMSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 07:18:25 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:36493 "EHLO
	torres.zugschlus.de") by vger.kernel.org with ESMTP
	id S1030904AbWKUMSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 07:18:24 -0500
Date: Tue, 21 Nov 2006 13:18:23 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ttyS0 not working any more, LSR safety check engaged
Message-ID: <20061121121823.GA6208@torres.l21.ma.zugschlus.de>
References: <20061111114352.GA9206@torres.l21.ma.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061111114352.GA9206@torres.l21.ma.zugschlus.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 12:43:52PM +0100, Marc Haber wrote:
> since a few kernel versions (I unfortunately do not have logs going
> back more than two months, 2.6.17.13), the serial port on my hp compaq
> nc8000 is not working any more.
> 
> The Linux kernel logs "ttyS0: LSR safety check engaged!" whenever I
> try to use the port. Googling for this error message suggests that the
> port may either not be present or broken. I can confirm that both are
> not the case: The port is present and works fine both on Windows and
> with an older Knoppix version using a very old 2.6 kernel (I think
> 2.6.4).
> 
> Is it possible that a moderately recent update to the driver is
> broken?

The issue was udev loading smsc_ircc2. As soon as smsc_ircc2 is
loaded, the serial port shows the behavior listed above. Unloading the
module does not help, a reboot is needed.

I have now solved the issue locally by blacklisting smsc_ircc2 and
hope that I didn't break anything in this process.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835

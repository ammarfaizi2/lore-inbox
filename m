Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWF0TcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWF0TcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWF0TcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:32:18 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:9098 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1030316AbWF0TcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:32:17 -0400
Subject: Re: [PATCH] 8250 UART backup timer
From: Alex Williamson <alex.williamson@hp.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: rmk+serial@arm.linux.org.uk, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <44A183C5.6050002@zytor.com>
References: <1151435054.11285.41.camel@lappy>  <44A183C5.6050002@zytor.com>
Content-Type: text/plain
Organization: OSLO R&D
Date: Tue, 27 Jun 2006 13:32:11 -0600
Message-Id: <1151436731.5600.50.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 12:15 -0700, H. Peter Anvin wrote:
> Alex Williamson wrote:
> >    The patch below works around a minor bug found in the UART of the
> > remote management card used in many HP ia64 and parisc servers (aka the
> > Diva UARTs).  The problem is that the UART does not reassert the THRE
> > interrupt if it has been previously cleared and the IIR THRI bit is
> > re-enabled.  This can produce a very annoying failure mode when used as
> > a serial console, allowing a boot/reboot to hang indefinitely until an
> > RX interrupt kicks it into working again (ie. an unattended reboot could
> > stall). 
> 
> I have seen this same bug in soft UART IP from "a major vendor."

   If you get a chance to try, please let us know if this patch works
there too or needs any additional tweaking to make it work there.
Thanks,

	Alex

-- 
Alex Williamson                             HP Open Source & Linux Org.


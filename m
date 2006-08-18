Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161099AbWHRUgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbWHRUgQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 16:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbWHRUgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 16:36:16 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:18959 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161099AbWHRUgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 16:36:15 -0400
Date: Fri, 18 Aug 2006 21:36:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mark Hounschell <markh@compro.net>
Cc: Lee Revell <rlrevell@joe-job.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Fulghum <paulkf@microgate.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial issue
Message-ID: <20060818203607.GK21101@flint.arm.linux.org.uk>
Mail-Followup-To: Mark Hounschell <markh@compro.net>,
	Lee Revell <rlrevell@joe-job.com>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Paul Fulghum <paulkf@microgate.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1155915851.3426.4.camel@amdx2.microgate.com> <1155923734.2924.16.camel@mindpipe> <44E602C8.3030805@microgate.com> <1155925024.2924.22.camel@mindpipe> <Pine.LNX.4.61.0608181512520.19876@chaos.analogic.com> <1155928885.2924.40.camel@mindpipe> <Pine.LNX.4.61.0608181551510.19978@chaos.analogic.com> <44E6221D.4040008@compro.net> <1155932916.2924.47.camel@mindpipe> <44E623EB.1060908@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E623EB.1060908@compro.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 04:32:43PM -0400, Mark Hounschell wrote:
> Lee Revell wrote:
> > On Fri, 2006-08-18 at 16:25 -0400, Mark Hounschell wrote:
> >> Take it from someone who actually still uses dumb terminals every day,
> >> any thing over 9600 baud still requires some kind of flow control for
> >> reliable consistent operation. Software (Xon/Xoff) and or hardware
> >> (RTS/RTS/DTE) flow control.
> >>
> > 
> > Any idea why the serial console does not work at all with flow control
> > enabled (regardless of whether the host runs Linux or another OS)?
> > 
> > Lee
> > 
> > 
> 
> Your cable is probably wrong.  Both ends have to be using the type of flow
> control your cable is wired for.

Not quite true.  You can use XON/XOFF or hardware flow with a fully
populated cable, but if you have a sparsely populated cable (RX,TX,GND
only) then hardware flow control can't (and won't) work.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

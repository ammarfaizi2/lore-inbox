Return-Path: <linux-kernel-owner+w=401wt.eu-S1030455AbXAHCba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbXAHCba (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 21:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbXAHCba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 21:31:30 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:46696 "HELO
	smtp101.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030455AbXAHCb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 21:31:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=pM4+1oZRz8ZEa+RnPIikXRxc4yf5UhigmczS8KICw8uMldxqabtXBIdQH7W1WteHkQF48eWRfAu9MBc0RwTjjXribQGy+OWULdNLGkJ5MujUvEOI0Lk+K9GTqdTLyZB9hE+1w9ScflAANgWlEI2jKkIdLt+pVBsYKb2SNC5RWak=  ;
X-YMail-OSG: J0idOdAVM1ksGIGuaToQGL9IzSM1mx9U4kjGgX1tDm1HpOhePDlPR75sVBqXS0DZyNl4sSo0eer.UfXI8f6aNBbS49mIyMyzjgrLQjP1QEhSyVTvOpA8dQ.Fy63DJmEmFBdE8Vvk3hPfR1iKLgs7e7O9KquypiWJU.SAl6_vFP9R.cfSjofTqDaURgpj
From: David Brownell <david-b@pacbell.net>
To: Philippe De Muyter <phdm@macqel.be>
Subject: Re: RTC subsystem and fractions of seconds
Date: Sun, 7 Jan 2007 18:10:30 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
References: <200701051949.00662.david-b@pacbell.net> <20070107101449.GA24163@ingate.macqel.be>
In-Reply-To: <20070107101449.GA24163@ingate.macqel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701071810.30310.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 January 2007 2:14 am, Philippe De Muyter wrote:
> On Fri, Jan 05, 2007 at 07:49:00PM -0800, David Brownell wrote:
> > >  	Those rtc's actually have a 1/100th of second
> > > register.  Should the generic rtc interface not support that?
> > 
> > Are you implying a new userspace API, or just an in-kernel update?
> > 
> > Either way, that raises the question of what other features should
> > be included.  What sub-second precision?  Multiple alarms?  Ways
> > to manage output clocks?  Sub-HZ periodic alarms?
> 
> One usefull addition for my needs and with a m41t81 is the support of
> the calibration of the rtc.  However this can perhaps be hidden in the
> .set_mmss function.

Doesn't seem like an set_mmss() mechanism at all.  Some drivers give
sysfs access to an oscillator "trim" mechanism.  What tools do you
have which track how far off that crystal is?

- Dave

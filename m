Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbTEOT7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTEOT7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:59:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:61846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264228AbTEOT66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:58:58 -0400
Subject: Re: Problem with e100 driver and latency on different packet sizes
From: Mark Haverkamp <markh@osdl.org>
To: Jonathan Brown <jbrown@emergence.uk.net>
Cc: Corey Minyard <cminyard@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1053019911.28121.1.camel@localhost>
References: <3EC3AA1E.6050401@mvista.com>
	 <1053019911.28121.1.camel@localhost>
Content-Type: text/plain
Organization: 
Message-Id: <1053029505.4109.20.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 May 2003 13:11:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 10:31, Jonathan Brown wrote:
> sounds like the cpu cycle saver
> 
> check out networking/e100.txt

I had seen something similar in an application of mine.  If I loaded the
e100 module with BundleMax=1 I got the same results as using the
eepro100 driver.

Mark.


> 
> On Thu, 2003-05-15 at 15:54, Corey Minyard wrote:
> > I'm seeing an odd thing with the e100 driver.  It seems to be this way
> > with the 2.4 series and with 2.5.68, and I couldn't find anything with a
> > search.
> > 
> > I've attached a small program to measure latency of round-trip time on
> > UDP.  If I send 85-byte packets between two of my machines, I get 170us
> > round-trip latency.  If I send 86-byte packets, I get 1329us latency. 
> > This seems quite odd.  If I test on the eepro100 driver, I get expected
> > linear increase in round-trip time as the packet size increases, and it
> > never gets close to 1300us.
> > 
> > To run the program, do:
> > 
> > ./ip_lat -s <port>
> > 
> > on one machine to run the server, and then do
> > 
> > ./ip_lat <server IP> <port> 1000 85
> > 
> > to send 1000 85-byte packets from another machine.  Change the 85 to 86
> > to see the latency go up.
> > 
> > -Corey

-- 
Mark Haverkamp <markh@osdl.org>


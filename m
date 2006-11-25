Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966997AbWKYXWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966997AbWKYXWl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 18:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966999AbWKYXWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 18:22:41 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:34486 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966997AbWKYXWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 18:22:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=gzrSOtWuZlFPSuh2UEX0jvyg3X5QswcJ8MDj+7WXxMxW7l4PynD4a1uRFbt7I6RyPFcUcaRiNBx6pAHB8ohC6I3ilYWmbYnIxMT1AMZ8LnWONuHkFsPXlheJ+ZlK61tIdrRFsYEMnvXS/wgYj2nYLORgY6EVCZIAp+uFbANDsWM=  ;
X-YMail-OSG: k3jc5tUVM1lPZlXIXuDDqyG9pQql78gj86gF9SJIZ8yT8vMN7xhmNoJhkDqQyf3HKRS2QsFJIVYWy33JGj3PkZukIf5BLY5VEjGkhQDGEvfTh7S67eCzyg--
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: NTP time sync
Date: Sat, 25 Nov 2006 15:22:18 -0800
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@muc.de>, Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
       Kim Phillips <kim.phillips@freescale.com>, akpm@osdl.org,
       davem@davemloft.net, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org,
       paulus@samba.org, ralf@linux-mips.org, rmk@arm.linux.org.uk
References: <20061122203633.611acaa8@inspiron> <20061123105400.GA75714@muc.de> <1164279605.5653.51.camel@localhost.localdomain>
In-Reply-To: <1164279605.5653.51.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611251522.19900.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 November 2006 3:00 am, Benjamin Herrenschmidt wrote:
> 
> Couldn't we have a transition period by making the kernel not rely on
> interrupts ? if the NTP irq code just triggers a work queue, then all of
> a sudden, all of the RTC drivers can be used and the latency is small.
> That might well be a good enough solution and is very simple.

Good point.  Of course, one issue is that the NTP sync code all
seems to be platform-specific right now ... just like the code
to set the system time from an RTC at boot (except for the new
RTC framework stuff) and after resume.

- Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWF2OWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWF2OWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 10:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWF2OWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 10:22:08 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:49304 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750730AbWF2OWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 10:22:07 -0400
Subject: Re: NO_HZ Kconfig rework
From: Daniel Walker <dwalker@mvista.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Daniel Walker <dwalker@dwalker1.mvista.com>, tglx@linutronix.de,
       mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20060629094231.GA2009@elf.ucw.cz>
References: <200606261616.k5QGGbem016569@dwalker1.mvista.com>
	 <20060629094231.GA2009@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 07:22:01 -0700
Message-Id: <1151590921.23920.28.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 11:42 +0200, Pavel Machek wrote:
> On Mon 2006-06-26 09:16:37, Daniel Walker wrote:
> > I got NO_HZ working on ARM, but because the ARM tree already
> > extensively implements NO_IDLE_HZ I had to make NO_HZ a
> > completely seprate option.
> 
> So... what is the difference between NO_HZ and NO_IDLE_HZ?

NO_HZ is a generic version of dynamic tick. NO_IDLE_HZ has some generic
parts but is mostly implemented by the architecture. In this case ARM
fully implements NO_IDLE_HZ, which then collides with NO_HZ if they
depend on each other.

Daniel




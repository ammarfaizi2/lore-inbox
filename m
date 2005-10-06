Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVJFPn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVJFPn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVJFPn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:43:26 -0400
Received: from ns.firmix.at ([62.141.48.66]:22686 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751111AbVJFPnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:43:24 -0400
Subject: Re: select(0,NULL,NULL,NULL,&t1) used for delay
From: Bernd Petrovitsch <bernd@firmix.at>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Alex Riesen <raa.lkml@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <43454238.4040907@nortel.com>
References: <1128606546.14385.26.camel@penguin.madhu>
	 <81b0412b0510060727h35c0fd78i260037ca89f253f9@mail.gmail.com>
	 <43454238.4040907@nortel.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 06 Oct 2005 17:42:50 +0200
Message-Id: <1128613370.6630.5.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-06 at 09:26 -0600, Christopher Friesen wrote:
> Alex Riesen wrote:
> 
> > Why don't you just use nanosleep(2) (or usleep)?
> 
> I can think of one main reason...existing code.  Also, nanosleep() 

And it's cooler to hack the kernel than to create and use a
portable_sleep() function and use it.

> rounds up excessively in many kernel versions, so that a request to 
> sleep for less than 1 tick ends up sleeping for 2 ticks.
                                                  ^^^^^^^

> The select() man page explicitly mentions this usage;
> 
> "Some code calls select with all three sets empty, n zero, and a 
> non-null timeout as a fairly portable way to sleep with subsecond 
                                                          ^^^^^^^^^
> precision."
  ^^^^^^^^^

You do realize that "subsecond precision" is probably meant as
improvement to sleep(3) and surely not to nanosleep(2)?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


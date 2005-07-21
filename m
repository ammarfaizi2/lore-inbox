Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVGUBZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVGUBZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 21:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVGUBZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 21:25:13 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:7180 "EHLO tron.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S261195AbVGUBZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 21:25:09 -0400
Message-ID: <42DEF96E.60103@stud.feec.vutbr.cz>
Date: Thu, 21 Jul 2005 03:25:02 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Andreas Steinmetz <ast@domdv.de>, Pavel Machek <pavel@suse.cz>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
References: <42DD67D9.60201@stud.feec.vutbr.cz> <200507201115.08733.rjw@sisk.pl> <42DECB21.5020903@stud.feec.vutbr.cz> <200507210123.16537.rjw@sisk.pl>
In-Reply-To: <200507210123.16537.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0001]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Thursday, 21 of July 2005 00:07, Michal Schmidt wrote:
>>I also tried putting a printk before restore_processor_state(), but I'm 
>>not sure if it is safe to use printk there.
> 
> 
> Yes, it is, but you may be unable to see the message if the box reboots before
> it can be displayed.

OK, but then I also tried putting a 5s long busy wait there and the 
reset was not delayed. Therefore, the reset must be occurring before 
restore_processor_state().
Or is there a reason why
	for(i=0; i<5000; i++)
		udelay(1000);
wouldn't work as expected?

Michal
